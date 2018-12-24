//
//  YLT_TangramUtils.h
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import <Foundation/Foundation.h>
#import "TangramModel.h"
@interface YLT_TangramUtils : NSObject

+ (id)valueFromSourceData:(id)sourceData keyPath:(NSString *)keypath;
///计算size
+ (CGSize)tangramSizePageModel:(TangramView *)pageModel;

@end
