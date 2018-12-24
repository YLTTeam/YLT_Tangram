//
//  YLT_TangramCell+Binding.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/24.
//

#import "YLT_TangramCell+Binding.h"
#import "YLT_TangramImage.h"
#import "YLT_TangramLabel.h"

@implementation YLT_TangramCell (Binding)

- (void)bindingFramelayout:(YLT_TangramFrameLayout *)framelayout data:(NSDictionary *)data {
    NSLog(@"   %@  ", data);
    if ([framelayout.pageModel.identify isEqualToString:@"TangramMenu"]) {
        [framelayout.mainView.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<NSDictionary *> *list = framelayout.pageModel.ylt_sourceData[@"subTangrams"];
            [list enumerateObjectsUsingBlock:^(NSDictionary *map, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[YLT_TangramImage class]] && [map[@"type"] isEqualToString:@"TangramImage"] && ((TangramImage *) ((YLT_TangramImage *) obj).content)) {
                    YLT_Log(@"%@", ((TangramImage *) ((YLT_TangramImage *) obj).content));
                    ((TangramImage *) ((YLT_TangramImage *) obj).content).src = self.config.ylt_sourceData[@"src"];
                    ((YLT_TangramImage *) obj).pageData = data;
                } else if ([obj isKindOfClass:[YLT_TangramLabel class]] && [map[@"type"] isEqualToString:@"TangramLabel"] && ((TangramLabel *) ((YLT_TangramLabel *) obj).content)) {
                    ((TangramLabel *) ((YLT_TangramLabel *) obj).content).text = self.config.ylt_sourceData[@"text"];
                    ((YLT_TangramLabel *) obj).pageData = data;
                }
            }];
        }];
    }
}

@end
