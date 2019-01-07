//
//  YLT_TangramVC+Router.h
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/29.
//

#import "YLT_TangramVC.h"

@interface YLT_TangramVC (Router)

/**
 网络请求动态添加参数

 @param params 参数
 */
- (void)requestParams:(NSDictionary *)params;

/**
 发起网络请求
 
 @param params 参数
 */
- (void)sendRequest:(NSDictionary *)params;

@end
