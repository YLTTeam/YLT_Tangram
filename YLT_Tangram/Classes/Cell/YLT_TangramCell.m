//
//  YLT_TangramCell.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramCell.h"
#import "YLT_TangramManager.h"

@implementation YLT_TangramCell

- (void)reloadCellData:(id)data {
    TangramView *model = [YLT_TangramManager typeFromPageData:data];
    YLT_Log(@"%@", model.ylt_sourceData);
    if ([model.ylt_sourceData isKindOfClass:[NSDictionary class]]) {
        if ([((NSDictionary *) model.ylt_sourceData).allKeys containsObject:@"subTangrams"]) {
            NSArray<NSDictionary *> *list = [((NSDictionary *) model.ylt_sourceData) objectForKey:@"subTangrams"];
            [list enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *classname = obj[@"classname"];
                if (classname.ylt_isValid) {
                    Class cls = NSClassFromString(classname);
                    
                }
            }];
        }
    }
}

@end
