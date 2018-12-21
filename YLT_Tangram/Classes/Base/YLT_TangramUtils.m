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

@end
