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

- (void)bindingFramelayout:(YLT_TangramFrameLayout *)framelayout {
    NSLog(@"%@", self.config.ylt_sourceData);
    if ([framelayout.pageModel.identify isEqualToString:@"TangramMenu"]) {
        [framelayout.mainView.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray<NSDictionary *> *list = framelayout.pageModel.ylt_sourceData[@"subTangrams"];
            [list enumerateObjectsUsingBlock:^(NSDictionary *map, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[YLT_TangramImage class]] && [map[@"type"] isEqualToString:@"TangramImage"]) {
                    ((TangramImage *) ((YLT_TangramImage *) obj).pageModel).src = self.config.ylt_sourceData[@"src"];
                } else if ([obj isKindOfClass:[YLT_TangramLabel class]] && [map[@"type"] isEqualToString:@"TangramLabel"]) {
                    ((TangramLabel *) ((YLT_TangramLabel *) obj).pageModel).text = self.config.ylt_sourceData[@"text"];
                }
            }];
        }];
    }
}

@end
