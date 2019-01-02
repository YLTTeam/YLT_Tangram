//
//  YLT_TangramUtils.h
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import <Foundation/Foundation.h>
#import "TangramModel.h"
#import "TangramModel+Calculate.h"
@interface YLT_TangramUtils : NSObject

/**
 加载布局
 
 @param keyname 布局名称
 @param data 布局数据
 @param classname 类名 使用什么类型来解析对应的 Model
 */
+ (TangramView *)loadTemplateKeyname:(NSString *)keyname data:(NSDictionary *)data classname:(NSString *)classname;

/**
 获取PageData数据
 
 @param itemname Item 名称
 @return 模型
 */
+ (TangramView *)typeFromItemname:(NSString *)itemname;

+ (id)valueFromSourceData:(id)sourceData keyPath:(NSString *)keypath;
///计算size
+ (CGSize)tangramSizePageModel:(TangramView *)pageModel;

@end
