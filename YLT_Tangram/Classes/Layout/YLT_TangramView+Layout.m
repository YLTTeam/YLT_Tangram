//
//  YLT_TangramView+Layout.m
//  YLT_Tangram
//
//  Created by John on 2018/12/21.
//

#import "YLT_TangramView+Layout.h"

@implementation YLT_TangramView (Layout)

- (void)updateLayout {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.superview) {
            self.superview.backgroundColor = [UIColor ylt_randomColor];
            self.backgroundColor = [UIColor ylt_randomColor];
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (![self updateHorizontalGravityMaker:make]) {
                    //没有水平方向上的布局 添加默认布局
                    [self updateHorizontalDefaultMaker:make];
                }
                
                //垂直方向上一定有了约束
                if (![self updateVerticalGravityMaker:make]) {
                    //没有垂直方向上的布局 添加默认布局
                    [self updateVerticalDefaultMaker:make];
                }
                make.size.mas_equalTo([self size]);
            }];
        }
    });
}

- (BOOL)updateHorizontalGravityMaker:(MASConstraintMaker *)make {
    if ((self.pageModel.layoutGravity & LayoutGravity_Left) || (self.pageModel.layoutGravity & LayoutGravity_Right) || (self.pageModel.layoutGravity & LayoutGravity_H_center)) {
        //左对齐
        if (self.pageModel.layoutGravity & LayoutGravity_Left) {
            make.left.equalTo(self.superview);
        }
        //右对齐
        if (self.pageModel.layoutGravity & LayoutGravity_Right) {
            make.right.equalTo(self.superview);
        }
        //水平居中
        if (self.pageModel.layoutGravity & LayoutGravity_H_center) {
            make.centerX.equalTo(self.superview);
        }
        return YES;
    }
    return NO;
}

- (BOOL)updateVerticalGravityMaker:(MASConstraintMaker *)make {
    //垂直方向上一定有了约束
    if ((self.pageModel.layoutGravity & LayoutGravity_Top) || (self.pageModel.layoutGravity & LayoutGravity_Bottom) || (self.pageModel.layoutGravity & LayoutGravity_V_center)) {
        //上对齐
        if (self.pageModel.layoutGravity & LayoutGravity_Top) {
            make.top.equalTo(self.superview);
        }
        //下对齐
        if (self.pageModel.layoutGravity & LayoutGravity_Bottom) {
            make.bottom.equalTo(self.superview);
        }
        //垂直居中
        if (self.pageModel.layoutGravity & LayoutGravity_V_center) {
            make.centerY.equalTo(self.superview);
        }
        return YES;
    }
    return NO;
}

- (void)updateHorizontalDefaultMaker:(MASConstraintMaker *)make {
    //水平方向上没有Gravity的约束
    if (self.pageModel.ylt_layoutMagin.right != 0) {
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
    } else {
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
    }
}

- (void)updateVerticalDefaultMaker:(MASConstraintMaker *)make {
    //垂直方向上没有Gravity约束
    if (self.pageModel.ylt_layoutMagin.bottom != 0) {
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
    } else {
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
    }
}

#pragma mark 服务端下发的控件宽高
- (CGSize)size {
    if (!self.superview) {
        return CGSizeZero;
    }
    CGFloat width = self.pageModel.layoutWidth > 0 ? self.pageModel.layoutWidth : 0.0;
    CGFloat height = self.pageModel.layoutHeight > 0 ? self.pageModel.layoutHeight : 0.0;
    //根据比例来算
    if (height == 0 && width > 0){
        if (self.pageModel.layoutRation > 0) {
            height = width / self.pageModel.layoutRation;
        }
    } else if (height > 0 && width == 0) {
        width = height * self.pageModel.layoutRation;
    }
    
    if (width == 0) {
        width = [self maxWidth];
    }
    if (height == 0) {
        height = [self maxHeight];
    }
    //约束极限宽高
    width = width > [self maxWidth] ? [self maxWidth] : width;
    height = height > [self maxHeight] ? [self maxHeight] : height;
    return CGSizeMake(width, height);
}

- (CGFloat)maxWidth {
    CGFloat width = self.superview.ylt_size.width - self.pageModel.ylt_layoutMagin.left -self.pageModel.ylt_layoutMagin.right;
    return width > 0 ? width : 0;
}

- (CGFloat)maxHeight {
    CGFloat height = self.superview.ylt_size.height - self.pageModel.ylt_layoutMagin.top -self.pageModel.ylt_layoutMagin.bottom;
    return height > 0 ? height : 0;
}

@end



@implementation YLT_TangramFrameLayout (Layout)

- (void)updateLayoutFrameLayout {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //首先更新自己的布局
        [self updateLayout];
        
        __block YLT_TangramView *currentSub = nil;
        __block YLT_TangramView *lastSub = self;
        //更新子视图的布局
        [self.content.subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            currentSub = [self.subTangrams objectForKey:obj.identify];
            if ([currentSub isKindOfClass:[YLT_TangramFrameLayout class]]) {
                [(YLT_TangramFrameLayout *)currentSub updateLayoutFrameLayout];
                return ;
            }
            
            if (currentSub) {
                [currentSub mas_remakeConstraints:^(MASConstraintMaker *make) {
                    BOOL hasVertical = [currentSub updateVerticalGravityMaker:make];
                    BOOL hasHorizontal = [currentSub updateHorizontalGravityMaker:make];
                    
                    //这里需要取父视图的布局形式
                    if (self.content.orientation == Orientation_H) {
                        if (!hasVertical) {
                            //不包含垂直方向的布局
                            [currentSub updateVerticalDefaultMaker:make];
                        }
                        if (!hasHorizontal) {
                            //不包含水平布局 需要根据上一个视图做重新布局
                            if (lastSub == self) {
                                make.left.equalTo(self.mas_left).offset(currentSub.pageModel.ylt_layoutMagin.left);
                            } else {
                                make.left.equalTo(lastSub.mas_right).offset(currentSub.pageModel.ylt_layoutMagin.left+lastSub.pageModel.ylt_layoutMagin.right);
                            }
                        }
                    } else {//默认布局垂直方向
                        if (!hasVertical) {
                            //不包含垂直布局 需要根据上一个视图做重新布局
                            if (lastSub == self) {
                                make.top.equalTo(self.mas_top).offset(currentSub.pageModel.ylt_layoutMagin.top);
                            } else {
                                make.top.equalTo(lastSub.mas_bottom).offset(currentSub.pageModel.ylt_layoutMagin.top+lastSub.pageModel.ylt_layoutMagin.bottom);
                            }
                        }
                        if (!hasHorizontal) {
                            //不包含水平方向的布局
                            [currentSub updateHorizontalDefaultMaker:make];
                        }
                    }
                    make.size.mas_equalTo([currentSub size]);
                }];
                lastSub = currentSub;
            }
        }];
    });
}

- (TangramFrameLayout *)content {
    return (TangramFrameLayout *)self.pageModel;
}

@end
