//
//  YLT_TangramFrameLayout.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramFrameLayout.h"
#import "YLT_TangramManager.h"
#import "YLT_TangramView+layout.h"
#import "YLT_TangramFrameLayout.h"

@implementation YLT_TangramFrameLayout

- (void)refreshPage {
    if ([self.pageModel isMemberOfClass:[TangramFrameLayout class]]) {
        [((TangramFrameLayout *) self.pageModel).subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class cls = NULL;
            if ([obj respondsToSelector:@selector(type)]) {
                cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@", obj.type]);
            }
            if (cls == NULL) {
                cls = YLT_TangramView.class;
            }
            if ([cls isSubclassOfClass:YLT_TangramView.class]) {
                YLT_TangramView *sub = [[cls alloc] init];
                Class modelClass = NSClassFromString(obj.type);
                if (modelClass == NULL) {
                    modelClass = TangramView.class;
                }
                sub.pageModel = [modelClass mj_objectWithKeyValues:obj.ylt_sourceData];
                [self.mainView addSubview:sub];
                [sub mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(obj.ylt_layoutMagin);
                }];
                [sub updateLayout];
            }
        }];
    }
}

@end
