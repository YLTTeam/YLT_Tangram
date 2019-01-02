//
//  YLT_TangramVC.h
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import <YLT_Kit/YLT_Kit.h>
#import "TangramModel+Calculate.h"

@interface YLT_TangramVC : YLT_BaseVC

/**
 网络请求参数
 */
@property (nonatomic, strong) NSMutableDictionary *reqParams;

/**
 页面数据
 */
@property (nonatomic, strong) NSMutableArray<TangramView *> *pageModels;

/**
 页面数据  可能根据网络请求填充
 */
@property (nonatomic, strong) NSMutableDictionary *pageDatas;

/**
 网络请求
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSDictionary *> *pageRequest;

+ (YLT_TangramVC *)tangramWithPages:(NSArray<NSDictionary *> *)pages
                           requests:(NSDictionary<NSString *, NSDictionary *> *)pageRequests
                          withDatas:(NSMutableDictionary *)datas;

/**
 生成页面

 @param requestParams 页面的网络请求
 @return 页面
 */
+ (YLT_TangramVC *)tangramWithRequestParams:(NSDictionary *)requestParams;

@end
