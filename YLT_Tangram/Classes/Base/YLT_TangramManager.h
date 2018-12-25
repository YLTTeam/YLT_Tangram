//
//  YLT_TangramManager.h
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "TangramModel.h"
#import <Foundation/Foundation.h>
#import <YLT_BaseLib/YLT_BaseLib.h>

@interface YLT_TangramManager : NSObject

YLT_ShareInstanceHeader(YLT_TangramManager);

@property (nonatomic, copy) NSString *(^splitImageURLString)(NSString *path);

/**
 加载布局
 
 @param keyname 布局名称
 @param path 布局路径
 @param classname 类名 使用什么类型来解析对应的 Model
 */
+ (void)loadTemplateKeyname:(NSString *)keyname path:(NSString *)path classname:(NSString *)classname;

+ (TangramView *)typeFromKeyname:(NSString *)keyname;

+ (TangramView *)typeFromPageData:(NSDictionary *)pageData;

@end
