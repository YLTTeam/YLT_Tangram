//
//  TangramModel+Calculate.h
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "TangramModel.h"

@interface TangramView (Calculate)

/**
 视图内边距
 */
@property (nonatomic, assign, readonly) UIEdgeInsets ylt_padding;
/**
 视图外边距
 */
@property (nonatomic, assign, readonly) UIEdgeInsets ylt_layoutMagin;
/**
 模版key
 */
@property (nonatomic, strong, readonly) NSString *ylt_identify;
@end

@interface TangramFrameLayout (Calculate)

@property (nonatomic, assign, readonly) CGFloat ylt_layoutWidthTotalWeight;

@property (nonatomic, assign, readonly) CGFloat ylt_layoutHeightTotalWeight;

/**
 总体的固定值
 */
@property (nonatomic, assign, readonly) CGFloat ylt_layoutRegularTotal;

@end



