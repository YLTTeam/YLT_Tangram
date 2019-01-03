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

/**
 模块解密使用的KEY 使用AES加密算法 没有设置 则不解密
 */
@property (nonatomic, strong) NSString *tangramKey;

@property (nonatomic, strong) NSData *tangramIv;

@property (nonatomic, copy) NSString *(^tangramImageURLString)(NSString *path);

@property (nonatomic, copy) UIView *(^tangramViewFromPageModel)(NSDictionary *pageModel);

@property (nonatomic, copy) void(^tangramRequest)(NSArray<TangramRequest *> *requests, void(^success)(NSDictionary *result));

@end
