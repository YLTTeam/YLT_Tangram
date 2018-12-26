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

@interface YLT_TangramCell () {
}
@property (nonatomic, strong) NSMutableDictionary<NSString *, YLT_TangramView *> *subTangrams;
@end

@implementation YLT_TangramCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)cellFromConfig:(TangramView *)config {
    self.config = config;
    YLT_TangramView *sub = nil;
    if ([self.subTangrams.allKeys containsObject:config.identify]) {
        sub = [self.subTangrams objectForKey:config.identify];
    } else {
        if ([config isKindOfClass:[TangramLabel class]]) {
            sub = [[YLT_TangramLabel alloc] init];
        } else if ([config isKindOfClass:[TangramImage class]]) {
            sub = [[YLT_TangramImage alloc] init];
        } else if ([config isKindOfClass:[TangramFrameLayout class]]) {
            sub = [[YLT_TangramFrameLayout alloc] init];
        } else if ([config isKindOfClass:[TangramGridLayout class]]) {
            
        }
        if (sub) {
            [self.contentView addSubview:sub];
            sub.pageModel = config;
            [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(config.ylt_layoutMagin);
            }];
            [self.subTangrams setObject:sub forKey:config.identify];
        }
    }
    
    if (sub) {
        [sub updateLayout];
    }
}

- (void)reloadCellData:(id)data {
    if ([self.subTangrams.allKeys containsObject:self.config.identify]) {
        [self.subTangrams.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YLT_TangramView *sub = (YLT_TangramView *)self.subTangrams[obj];
            sub.pageData = data;
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
