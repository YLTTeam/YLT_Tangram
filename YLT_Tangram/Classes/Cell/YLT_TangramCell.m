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

@interface YLT_TangramCell () {
}
@property (nonatomic, strong) NSMutableDictionary<NSString *, TangramView *> *subTangrams;
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

- (void)configCellFromConfigname:(NSString *)configname {
    TangramView *model = [YLT_TangramManager typeFromKeyname:configname];
    if ([model.ylt_sourceData isKindOfClass:[NSDictionary class]]) {
        if ([((NSDictionary *) model.ylt_sourceData).allKeys containsObject:@"subTangrams"]) {
            NSArray<NSDictionary *> *list = [((NSDictionary *) model.ylt_sourceData) objectForKey:@"subTangrams"];
            [list enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj isKindOfClass:[NSDictionary class]]) {
                    return;
                }
                NSString *classname = obj[@"classname"];
                Class cls = TangramView.class;
                if (classname.ylt_isValid) {
                    cls = NSClassFromString(classname);
                }
                TangramView *pageModel = [cls ylt_objectWithKeyValues:obj];
                if (![self.subTangrams.allKeys containsObject:pageModel.identify]) {//证明当前cell 不包含小组件
                    Class cls = NULL;
                    if (pageModel.classname) {
                        cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@", pageModel.classname]);
                    }
                    if (cls == NULL) {
                        cls = YLT_TangramView.class;
                    }
                    if ([cls isSubclassOfClass:YLT_TangramView.class]) {
                        YLT_TangramView *sub = [[cls alloc] init];
                        [self.contentView addSubview:sub];
                        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.edges.mas_equalTo(pageModel.ylt_layoutMagin);
                        }];
                        sub.pageModel = pageModel;
                        [self.subTangrams setObject:sub forKey:pageModel.identify];
                    }
                }
                YLT_Log(@"%@", pageModel);
            }];
        }
    }
}

- (void)reloadCellData:(id)data {
    [self.subTangrams.allKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YLT_TangramView *sub = (YLT_TangramView *)self.subTangrams[obj];
        sub.pageData = data;
    }];
}

- (NSMutableDictionary *)subTangrams {
    if (!_subTangrams) {
        _subTangrams = [[NSMutableDictionary alloc] init];
    }
    return _subTangrams;
}

@end
