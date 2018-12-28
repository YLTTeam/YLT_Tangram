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
@property (nonatomic, assign) CGFloat layoutWeightHeight;
@property (nonatomic, assign) CGFloat layoutWeightWidth;
@end

@interface TangramFrameLayout (Calculate)
@property (nonatomic, assign) CGFloat layoutTotalV;
@property (nonatomic, assign) CGFloat layoutTotalH;
@end



