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
#import "YLT_TangramCell+Binding.h"

@interface YLT_TangramCell () {
}
@property (nonatomic, strong) NSMutableDictionary<NSString *, YLT_TangramView *> *subTangrams;
@end

@implementation YLT_TangramCell

static NSDictionary *unitTangram;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            unitTangram = @{
                            @"TangramLabel":@"YLT_TangramLabel",
                            @"TangramImage":@"YLT_TangramImage",
                            @"MenuItem":@"TangramMenu"
                            };
        });
    }
    return self;
}

- (void)cellFromConfig:(TangramView *)config {
    self.config = config;
    NSString *classname = config.type;
    YLT_TangramView *sub = nil;
    if ([self.subTangrams.allKeys containsObject:config.identify]) {
        sub = [self.subTangrams objectForKey:config.identify];
    } else {
        if ([unitTangram.allKeys containsObject:classname]) {
            classname = [unitTangram objectForKey:classname];
            Class cls = NSClassFromString(classname);
            if (cls) {//原子组件
                sub = [[cls alloc] init];
                [self.contentView addSubview:sub];
                sub.pageModel = config;
                [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(config.ylt_layoutMagin);
                }];
            } else {//复合组件
                NSString *path = [[NSBundle bundleForClass:self.class].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"YLT_Tangram.bundle/%@.geojson", classname]];
                NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
                classname = data[@"type"];
                cls = NSClassFromString(classname);
                if (cls) {
                    TangramFrameLayout *frameLayout = [cls mj_objectWithKeyValues:data];
                    Class viewClass = NSClassFromString([NSString stringWithFormat:@"YLT_%@", classname]);
                    sub = [[viewClass alloc] init];
                    [self.contentView addSubview:sub];
                    sub.pageModel = frameLayout;
                    [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.mas_equalTo(frameLayout.ylt_layoutMagin);
                    }];
                }
            }
        }
        if (sub) {
            [self.subTangrams setObject:sub forKey:config.identify];
        }
    }
    
    if (sub) {
        [sub updateLayout];
    }
    
    return;
//    TangramView *model = [YLT_TangramManager typeFromKeyname:configname];
//    if ([model.ylt_sourceData isKindOfClass:[NSDictionary class]]) {
//        if ([((NSDictionary *) model.ylt_sourceData).allKeys containsObject:@"subTangrams"]) {
//            NSArray<NSDictionary *> *list = [((NSDictionary *) model.ylt_sourceData) objectForKey:@"subTangrams"];
//            [list enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                if (![obj isKindOfClass:[NSDictionary class]]) {
//                    return;
//                }
//                NSString *classname = obj[@"type"];
//                Class cls = TangramView.class;
//                if (classname.ylt_isValid) {
//                    cls = NSClassFromString(classname);
//                }
//                TangramView *pageModel = [cls mj_objectWithKeyValues:obj];
//                if (![self.subTangrams.allKeys containsObject:pageModel.identify]) {//证明当前cell 不包含小组件
//                    Class cls = NULL;
//                    if (pageModel.type) {
//                        cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@", pageModel.type]);
//                    }
//                    if (cls == NULL) {
//                        cls = YLT_TangramView.class;
//                    }
//                    if ([cls isSubclassOfClass:YLT_TangramView.class]) {
//                        YLT_TangramView *sub = [[cls alloc] init];
//                        [self.contentView addSubview:sub];
//                        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.edges.mas_equalTo(pageModel.ylt_layoutMagin);
//                        }];
//                        sub.pageModel = pageModel;
//                        [self.subTangrams setObject:sub forKey:pageModel.identify];
//                    }
//                }
//                YLT_Log(@"%@", pageModel);
//            }];
//        }
//    }
}

- (void)reloadCellData:(id)data {
//    [self.subTangrams.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        YLT_TangramView *sub = (YLT_TangramView *)self.subTangrams[obj];
//        YLT_Log(@"%@", sub);
//        sub.pageData = data;
//    }];

    if ([self.subTangrams.allKeys containsObject:self.config.identify]) {
        //复合组件 绑定数据
        [self bindingFramelayout:(YLT_TangramFrameLayout *)[self.subTangrams objectForKey:self.config.identify] data:data];
    }
}

- (NSMutableDictionary *)subTangrams {
    if (!_subTangrams) {
        _subTangrams = [[NSMutableDictionary alloc] init];
    }
    return _subTangrams;
}

@end
