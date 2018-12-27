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

@property (nonatomic, copy) NSString *(^tangramImageURLString)(NSString *path);

@property (nonatomic, copy) UIView *(^tangramViewFromPageModel)(NSDictionary *pageModel);

@end
