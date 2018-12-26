//
//  YLT_TangramUtils.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramUtils.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <RegexKitLite/RegexKitLite.h>

@implementation YLT_TangramUtils

+ (id)valueFromSourceData:(id)sourceData keyPath:(NSString *)keypath {
    if (!keypath.ylt_isValid) {
        return sourceData;
    }
    if (![keypath hasPrefix:@"$"]) {
        return keypath;
    }
    keypath = [keypath substringFromIndex:1];
    __block id result = sourceData;
    [[keypath componentsSeparatedByString:@"."] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *list = [obj arrayOfCaptureComponentsMatchedByRegex:@"(\\S+)(?:\\s*)\\[(\\d*)\\]"];
        NSString *key = obj;
        if (list.count > 0) {
            NSArray *contents = list.firstObject;
            if (contents.count >= 3) {
                key = contents[1];
            }
        }
        if ([result isKindOfClass:[NSDictionary class]] && [((NSDictionary *)result).allKeys containsObject:key]) {
            result = [((NSDictionary *)result) objectForKey:key];
        }
        if ([result isKindOfClass:[NSArray class]] && ((NSArray *)result).count > 0) {//元素是数组才会继续往下
            if (list.count > 0) {
                NSArray *contents = list.firstObject;
                if (contents.count >= 3) {
                    NSInteger index = [contents[2] integerValue];
                    if (index < 0) {
                        index = 0;
                    }
                    if (index >= ((NSArray *) result).count) {
                        index = ((NSArray *) result).count-1;
                    }
                    result = [((NSArray *)result) objectAtIndex:index];
                }
            }
        }
    }];
    return result;
}

+ (CGSize)tangramSizePageModel:(TangramView *)pageModel {
    if ([pageModel isMemberOfClass:[TangramView class]]) {
        CGFloat width = 0.0,height = 0.0;
        width = pageModel.layoutWidth > 0 ? pageModel.layoutWidth : 0;
        height = pageModel.layoutHeight > 0 ? pageModel.layoutHeight : 0;
        
        if (height == 0 && width > 0){
            if (pageModel.layoutRation > 0) {
                height = width / pageModel.layoutRation;
            }
        }else if (height > 0 && width == 0){
            width = height * pageModel.layoutRation;
        }else{
            //其他不考虑
        }
        return CGSizeMake(width, height);
    }else {
        return CGSizeZero;
    }
}
@end
