//
//  YLT_TangramBannerLayout.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/27.
//

#import "YLT_TangramBannerLayout.h"
#import "TangramModel.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface YLT_TangramBannerLayout () {
}
@property (nonatomic, strong) NSArray *list;
@end

@implementation YLT_TangramBannerLayout

- (void)refreshPage {
    if ([self.content isKindOfClass:[TangramBannerLayout class]]) {
        self.list = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.content.dataTag];
        YLT_Log(@"%@", self.list);
    }
}

- (TangramBannerLayout *)content {
    return (TangramBannerLayout *)self.pageModel;
}

@end
