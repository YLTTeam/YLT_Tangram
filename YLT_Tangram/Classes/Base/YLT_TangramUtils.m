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
        CGFloat width = 0.0,height = 0.0;;
        if (pageModel.layoutWidth.floatValue > 0) {
            //直接取layoutMargin,超出屏幕部分，去除
            width = pageModel.layoutWidth.floatValue;
        }
        //当宽度依旧为0,取最小值
        if (width == 0.0) {
            width = pageModel.minWidth;
        }
        
        if (pageModel.layoutHeight.floatValue > 0) {
            height = pageModel.layoutHeight.floatValue;
        }
        
        if (height == 0.0) {
            height = pageModel.minHeight;
        }
        
        //根据比例来计算宽高,当高为0 切宽不为0的时候
        if (height == 0 && width > 0){
            //当高度为0，宽度不为0的时候，根据比例来计算宽高比
            height = width * pageModel.autoDimX;
        }else if (height > 0 && width == 0){
            width = height * pageModel.autoDimY;
        }else{
            //其他不考虑
        }
        return CGSizeMake(width, height);
    }else {
        return CGSizeZero;
    }
}
@end
