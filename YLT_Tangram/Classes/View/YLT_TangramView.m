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

@interface YLT_TangramView() {
}
@end

@implementation YLT_TangramView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
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
    if ([_pageData isKindOfClass:[NSDictionary class]]) {
        self.pageModel = [YLT_TangramManager typeFromPageData:_pageData];
    }
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
