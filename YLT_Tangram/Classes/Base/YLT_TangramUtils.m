//
//  YLT_TangramUtils.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramUtils.h"
#import "YLT_TangramVC.h"
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
 
 @param itemname Item 名称
 @return 模型
 */
+ (TangramView *)typeFromItemname:(NSString *)itemname {
    if (![self.ylt_currentVC isKindOfClass:[YLT_TangramVC class]]) {
        return [TangramView new];
    }
    TangramView *result = nil;
    YLT_TangramVC *currentVC = (YLT_TangramVC *)self.ylt_currentVC;
    if ([currentVC.itemLayouts.allKeys containsObject:itemname]) {
        NSDictionary *data = [currentVC.itemLayouts objectForKey:itemname];
        if ([data isKindOfClass:[NSDictionary class]]) {
            result = [self loadTemplateKeyname:nil data:data classname:nil];
        }
    }
    
    return result?:[TangramView new];
}

+ (id)valueFromSourceData:(id)sourceData keyPath:(NSString *)keypath {
    if (sourceData == nil) {
        return nil;
    }
    if (!keypath.ylt_isValid) {
        return sourceData;
    }
    id result = sourceData;
    NSArray *list = [keypath arrayOfCaptureComponentsMatchedByRegex:@"\\$\\{([\\s\\S]*?)\\}"];
    switch (list.count) {
        case 0: {
            result = keypath;
        }
            break;
        case 1: {
            /** 匹配到了多个变量  目前只支持字符串的多变量匹配 */
            NSMutableString *str = [[NSMutableString alloc] initWithString:keypath];
            if ([[list firstObject] isKindOfClass:[NSArray class]] && ((NSArray *)[list firstObject]).count == 2) {
                result = [self singalValueFromData:sourceData path:[((NSArray *)[list firstObject]) lastObject]];
            }
            /** 匹配到的内容是字符串 那么就进行拼接一下 */
            if ([result isKindOfClass:[NSString class]] || [result isKindOfClass:[NSNumber class]]) {
                result = [NSString stringWithFormat:@"%@", result];
                [str replaceOccurrencesOfString:list.firstObject[0] withString:result options:0 range:NSMakeRange(0, str.length)];
                result = str;
            }
        }
            break;
        default: {
            /** 匹配到了多个变量  目前只支持字符串的多变量匹配 */
            NSMutableString *str = [[NSMutableString alloc] initWithString:keypath];
            [list enumerateObjectsUsingBlock:^(NSArray*_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSArray class]] && obj.count == 2) {
                    NSString *temp = [self singalValueFromData:sourceData path:obj[1]];
                    if ([temp isKindOfClass:[NSString class]] || [temp isKindOfClass:[NSNumber class]]) {
                        temp = [NSString stringWithFormat:@"%@", temp];
                        [str replaceOccurrencesOfString:obj[0] withString:temp options:0 range:NSMakeRange(0, str.length)];
                    }
                }
            }];
            result = str;
        }
            break;
    }
    return result;
}

+ (id)singalValueFromData:(id)sourceData path:(NSString *)keypath {
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
