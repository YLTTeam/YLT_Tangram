//
//  YLT_TangramView.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramView.h"
#import "YLT_TangramView+TangramData.h"
#import "YLT_TangramView+TangramPage.h"
#import "YLT_TangramManager.h"
#import "YLT_TangramLabel.h"
#import "YLT_TangramImage.h"
#import "YLT_TangramUtils.h"

@interface YLT_TangramView() {
}
@end

@implementation YLT_TangramView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

/**
 更新页面
 
 @param pageModel 页面数据
 */
- (void)setPageModel:(TangramView *)pageModel {
    _pageModel = pageModel;
    [self updatePage];
    [self refreshPage];
}

- (void)setPageData:(NSDictionary *)pageData {
    _pageData = pageData;
    [self updateData];
    [self refreshPage];
}

/**
 刷新具体的页面
 */
- (void)refreshPage {
}

#pragma setter getter

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self addSubview:_mainView];
    }
    return _mainView;
}

@end
