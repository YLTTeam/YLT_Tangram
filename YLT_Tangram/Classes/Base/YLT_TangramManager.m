//
//  YLT_TangramManager.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramManager.h"

@interface YLT_TangramManager() {
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, TangramView *> *loadTypes;
@end

@implementation YLT_TangramManager

YLT_ShareInstance(YLT_TangramManager);

- (void)ylt_init {
}
/**
 加载布局
 
 @param keyname 布局名称
 @param path 布局路径
 @param classname 类名 使用什么类型来解析对应的 Model
 */
+ (void)loadTemplateKeyname:(NSString *)keyname path:(NSString *)path classname:(NSString *)classname {
    if (!path.ylt_isValid) {
        return;
    }
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
    Class cls = NSClassFromString(classname);
    if (cls == NULL) {
        cls = NSClassFromString(data[@"classname"]);
    }
    if (cls == NULL) {
        cls = TangramView.class;
    }
    keyname = keyname.ylt_isValid?keyname:NSStringFromClass(cls);
    if (!keyname.ylt_isValid) {
        return;
    }
    if ([[YLT_TangramManager shareInstance].loadTypes.allKeys containsObject:keyname]) {
        return;
    }
    
    if (data) {
        TangramView *model = [cls performSelector:@selector(ylt_objectWithKeyValues:) withObject:data];
        if (model) {
            [[YLT_TangramManager shareInstance].loadTypes setObject:model forKey:keyname];
        }
    }
    YLT_Log(@"%@", [YLT_TangramManager shareInstance].loadTypes);
}

+ (TangramView *)typeFromKeyname:(NSString *)keyname {
    if ([[YLT_TangramManager shareInstance].loadTypes.allKeys containsObject:keyname]) {
        return [YLT_TangramManager shareInstance].loadTypes[keyname];
    }
    return [TangramView new];
}

+ (TangramView *)typeFromPageData:(NSDictionary *)pageData {
    if (pageData && [pageData.allKeys containsObject:@"type"]) {
        return [self typeFromKeyname:pageData[@"type"]];
    }
    return [TangramView new];
}

- (NSMutableDictionary<NSString *, TangramView *> *)loadTypes {
    if (!_loadTypes) {
        _loadTypes = [[NSMutableDictionary alloc] init];
    }
    return _loadTypes;
}


@end
