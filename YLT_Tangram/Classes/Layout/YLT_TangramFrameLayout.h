//
//  YLT_TangramFrameLayout.h
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramView.h"
#import "TangramModel.h"

@interface YLT_TangramFrameLayout : YLT_TangramView

/**
 子视图
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, YLT_TangramView *> *subTangrams;

@end
