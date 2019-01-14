//
//  YLT_TangramFrameLayout.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramFrameLayout.h"
#import "YLT_TangramManager.h"
#import "YLT_TangramView+Layout.h"
#import "YLT_TangramFrameLayout.h"

@interface YLT_TangramFrameLayout() {
}
@end

@implementation YLT_TangramFrameLayout

- (void)refreshPage {
    if ([self.content isMemberOfClass:[TangramFrameLayout class]]) {
        __block YLT_TangramView *sub = nil;
        [self.content.subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self.subTangrams.allKeys containsObject:obj.identify]) {
                sub = self.subTangrams[obj.identify];
            } else {
                Class cls = NULL;
                if ([obj respondsToSelector:@selector(type)]) {
                    cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@", obj.type]);
                }
                if (cls == NULL) {
                    cls = YLT_TangramView.class;
                }
                if ([cls isSubclassOfClass:YLT_TangramView.class]) {
                    sub = [[cls alloc] init];
                    Class modelClass = NSClassFromString(obj.type);
                    if (modelClass == NULL) {
                        modelClass = TangramView.class;
                    }
                    sub.pageModel = [modelClass mj_objectWithKeyValues:obj.ylt_sourceData];
                    [self.mainView addSubview:sub];
                    [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.mas_equalTo(obj.ylt_layoutMargin);
                    }];
                    if (sub) {
                        [self.subTangrams setObject:sub forKey:obj.identify];
                    }
                }
            }
            if (sub) {
                sub.pageData = self.pageData;
            }
        }];
        [self updateLayoutFrameLayout];
    }
}

- (TangramFrameLayout *)content {
    return (TangramFrameLayout *)self.pageModel;
}

- (NSMutableDictionary<NSString *, YLT_TangramView *> *)subTangrams {
    if (!_subTangrams) {
        _subTangrams = [[NSMutableDictionary alloc] init];
    }
    return _subTangrams;
}

@end
