//
//  YLT_TangramVC.h
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import <YLT_Kit/YLT_Kit.h>
#import "TangramModel+Calculate.h"

@interface YLT_TangramVC : YLT_BaseVC

/**
 页面数据
 */
@property (nonatomic, strong) NSMutableArray<TangramView *> *pageModels;

@property (nonatomic, strong) NSMutableDictionary *pageDatas;


+ (YLT_TangramVC *)tangramWithPages:(NSArray<NSDictionary *> *)pages
                          withDatas:(NSMutableDictionary *)datas;

@end
