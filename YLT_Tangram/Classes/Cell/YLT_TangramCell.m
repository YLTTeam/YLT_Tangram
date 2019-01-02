//
//  YLT_TangramCell.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramCell.h"
#import "YLT_TangramView.h"
#import "YLT_TangramManager.h"
#import "TangramModel+Calculate.h"
#import "YLT_TangramView+layout.h"
#import "YLT_TangramFrameLayout.h"
#import "YLT_TangramImage.h"
#import "YLT_TangramLabel.h"
#import "YLT_tangramBannerLayout.h"

@interface YLT_TangramCell () {
}
@property (nonatomic, strong) NSMutableDictionary<NSString *, YLT_TangramView *> *subTangrams;
@end

@implementation YLT_TangramCell

//model 与类名的对应 默认view 的类名与Model类名相差的只是前面的 YLT_
static NSDictionary *modelViews;
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            modelViews = @{
                           };
        });
    }
    return self;
}

- (NSMutableDictionary<NSString *,YLT_TangramView *> *)extracted {
    return self.subTangrams;
}

- (void)cellFromConfig:(TangramView *)config {
    self.config = config;
    YLT_TangramView *sub = nil;
    if ([self.subTangrams.allKeys containsObject:config.identify]) {
        sub = [self.subTangrams objectForKey:config.identify];
        if ([sub respondsToSelector:@selector(setPageModel:)]) {
            sub.pageModel = config;
        }
    } else {
        Class cls = NULL;
        NSString *modelClassname = config.type;
        if ([modelViews.allKeys containsObject:modelClassname]) {
            cls = NSClassFromString(modelViews[modelClassname]);
        }
        if (cls == NULL) {
            cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@", modelClassname]);
        }
        if (cls != NULL) {
            sub = [[cls alloc] init];
        }
        
        if (sub) {
            [self.contentView addSubview:sub];
            sub.pageModel = config;
            [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(config.ylt_layoutMagin);
            }];
            [self.subTangrams setObject:sub forKey:config.identify];
        } else if ([YLT_TangramManager shareInstance].tangramViewFromPageModel) {
            sub = (YLT_TangramView *)[YLT_TangramManager shareInstance].tangramViewFromPageModel(config.ylt_sourceData);
            if (sub) {
                [self.contentView addSubview:sub];
                if ([sub respondsToSelector:@selector(setPageModel:)]) {
                    sub.pageModel = config;
                }
                [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(config.ylt_layoutMagin);
                }];
                [[self extracted] setObject:sub forKey:config.identify];
            }
        }
    }
    
    if (sub && [sub respondsToSelector:@selector(updateLayout)]) {
        [sub updateLayout];
    }
}

- (void)reloadCellData:(id)data {
    if ([self.subTangrams.allKeys containsObject:self.config.identify]) {
        [self.subTangrams.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YLT_TangramView *sub = (YLT_TangramView *)self.subTangrams[obj];
            if (sub && [sub respondsToSelector:@selector(setPageData:)]) {
                sub.pageData = data;
            }
        }];
    }
}

- (NSMutableDictionary *)subTangrams {
    if (!_subTangrams) {
        _subTangrams = [[NSMutableDictionary alloc] init];
    }
    return _subTangrams;
}

@end
