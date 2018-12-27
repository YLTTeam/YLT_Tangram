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

/**
 加载布局
 
 @param keyname 布局名称
 @param data 布局数据
 @param classname 类名 使用什么类型来解析对应的 Model
 */
+ (TangramView *)loadTemplateKeyname:(NSString *)keyname data:(NSDictionary *)data classname:(NSString *)classname {
    if (![data isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    Class cls = NSClassFromString(classname);
    if (cls == NULL) {
        cls = NSClassFromString(data[@"type"]);
    }
    if (cls == NULL) {
        cls = TangramView.class;
    }
    keyname = keyname.ylt_isValid?keyname:NSStringFromClass(cls);
    if (!keyname.ylt_isValid) {
        return nil;
    }
    
    if (data) {
        TangramView *model = [cls mj_objectWithKeyValues:data];
        if (model) {
            return model;
        }
    }
    return nil;
}

/**
 获取PageData数据
 
 @param pageData 字典或字符串
 @return 模型
 */
+ (TangramView *)typeFromPageData:(id)pageData {
    TangramView *result = nil;
    NSDictionary *data = pageData;
    if ([pageData isKindOfClass:[NSString class]]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:pageData ofType:@"geojson"];
        if (path.ylt_isValid) {
            data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
        }
    }
    if ([data isKindOfClass:[NSDictionary class]]) {
        result = [self loadTemplateKeyname:nil data:data classname:nil];
    }
    
    return result?:[TangramView new];
}

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
    if (!pageModel) {
        return CGSizeMake(YLT_SCREEN_WIDTH, 0.01);
    }
    if ([pageModel isKindOfClass:[TangramGridLayout class]]) {
        TangramGridLayout *item = (TangramGridLayout *)pageModel;
        NSInteger column = ((TangramGridLayout *) item).column;
        column = (column == 0)?1:column;
        CGSize size = CGSizeZero;
        size.width = (YLT_SCREEN_WIDTH-item.ylt_layoutMagin.left-item.ylt_layoutMagin.right-item.ylt_padding.left-item.ylt_padding.right);
        size.width = (size.width-(column-1)*((TangramGridLayout *)item).itemHorizontalMargin)/column;
        size.height = ((TangramGridLayout *)item).itemHeight;
        size.height = (size.height == 0) ? size.width:size.height;
        return size;
    } else {
        CGFloat width = 0.0,height = 0.0;
        TangramView *item = (TangramView *)pageModel;
        width = item.layoutWidth > 0 ? item.layoutWidth : 0;
        height = item.layoutHeight > 0 ? item.layoutHeight : 0;
        if (height == 0 && width > 0){
            if (item.layoutRation > 0) {
                height = width / item.layoutRation;
            }
        }else if (height > 0 && width == 0){
            width = height * item.layoutRation;
        }
        //如果以上width依旧为0，则默认取屏宽
        width = width == 0 ? YLT_SCREEN_WIDTH : width;
        height = (height == 0) ? 0.01 : height;
        return CGSizeMake(width, height);
    }
}
@end
