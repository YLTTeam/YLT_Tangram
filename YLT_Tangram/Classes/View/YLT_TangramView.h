//
//  YLT_TangramView.h
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import <YLT_Kit/YLT_Kit.h>
#import "TangramModel+Calculate.h"

@interface YLT_TangramView : YLT_BaseView
/**
 页面配置
 */
@property (nonatomic, strong, readonly) TangramView *pageModel;
/**
 数据
 */
@property (nonatomic, strong) NSDictionary *pageData;

/**
 主视图 所有的配置都在该视图上生效
 */
@property (nonatomic, strong) UIView *mainView;

/**
 刷新具体的页面 实现数据与页面的绑定
 */
- (void)refreshPage;

@end
