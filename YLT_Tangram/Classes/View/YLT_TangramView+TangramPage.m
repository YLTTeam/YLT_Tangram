//
//  YLT_TangramView+TangramPage.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramView+TangramPage.h"

@implementation YLT_TangramView (TangramPage)

//解析当前模型的相关属性
- (void)updatePage {
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.pageModel.ylt_padding);
    }];
    [self.ylt_currentVC.view layoutIfNeeded];
    
    self.hidden = self.pageModel.hidden;
    self.mainView.backgroundColor = self.pageModel.background.ylt_androidColorFromHexString;
    
    [self updateBorder];    
}

- (void)updateBorder {
    if (CGRectEqualToRect(CGRectZero, self.mainView.bounds)) {
        return;
    }
    if (self.pageModel.borderRadius != 0 && self.pageModel.borderLocation != 0) {
        [self.mainView ylt_cornerType:(UIRectCorner)self.pageModel.borderLocation radius:self.pageModel.borderRadius];
    }
    if (self.pageModel.borderWidth != 0) {
        self.mainView.layer.borderWidth = self.pageModel.borderWidth;
        self.mainView.layer.borderColor = self.pageModel.borderColor.ylt_androidColorFromHexString.CGColor;
    }
}

@end
