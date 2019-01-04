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
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation YLT_TangramView
@synthesize pageData = _pageData;

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
    if ([pageData isKindOfClass:[NSError class]]) {
        pageData = nil;
    }
    _pageData = pageData;
    [self updateData];
    [self refreshPage];
    
    [self removeGestureRecognizer:self.tap];
    NSDictionary *clickAction = nil;
    if ([self.pageModel.action isKindOfClass:[NSString class]]) {
        if ([((NSString *) self.pageModel.action) hasPrefix:@"$"]) {
            clickAction = [YLT_TangramUtils valueFromSourceData:pageData keyPath:self.pageModel.action];
        }
        if ([clickAction isKindOfClass:[NSString class]]) {
            clickAction = clickAction.mj_JSONObject;
        }
        if ([clickAction isKindOfClass:[NSString class]]) {
            clickAction = @{@"iOS":clickAction};
        }
    } else if ([self.pageModel.action isKindOfClass:[NSDictionary class]]) {
        clickAction = self.pageModel.action;
    }
    if (clickAction && clickAction.allKeys.count > 0) {
        if ([clickAction isKindOfClass:[NSDictionary class]] && [clickAction.allKeys containsObject:@"iOS"]) {
            NSArray<NSString *> *actionList = [clickAction objectForKey:@"iOS"];
            if ([actionList isKindOfClass:[NSString class]]) {
                actionList = @[(NSString *)actionList];
            }
            if (actionList.count > 0) {
                self.userInteractionEnabled = YES;
                [self addGestureRecognizer:self.tap];
            }
        }
    }
}

- (NSDictionary *)pageData {
    if ([_pageData isKindOfClass:[NSError class]]) {
        return nil;
    }
    return _pageData;
}

/**
 刷新具体的页面
 */
- (void)refreshPage {
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    NSDictionary *clickAction = nil;
    if ([self.pageModel.action isKindOfClass:[NSString class]]) {
        if ([((NSString *) self.pageModel.action) hasPrefix:@"$"]) {
            clickAction = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.pageModel.action];
        }
        if ([clickAction isKindOfClass:[NSString class]]) {
            clickAction = clickAction.mj_JSONObject;
        }
        if ([clickAction isKindOfClass:[NSString class]]) {
            clickAction = @{@"iOS":clickAction};
        }
    } else if ([self.pageModel.action isKindOfClass:[NSDictionary class]]) {
        clickAction = self.pageModel.action;
    }
    if (clickAction && clickAction.allKeys.count > 0) {
        if ([clickAction isKindOfClass:[NSDictionary class]] && [clickAction.allKeys containsObject:@"iOS"]) {
            NSArray<NSString *> *actionList = [clickAction objectForKey:@"iOS"];
            if ([actionList isKindOfClass:[NSString class]]) {
                actionList = @[(NSString *)actionList];
            }
            [actionList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.ylt_currentVC ylt_routerToURL:obj arg:nil completion:^(NSError *error, id response) {
                }];
            }];
        }
    }
}

#pragma setter getter

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    }
    return _tap;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        [self addSubview:_mainView];
    }
    return _mainView;
}

@end
