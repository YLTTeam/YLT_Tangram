//
//  YLT_TangramView+layout.m
//  YLT_Tangram
//
//  Created by John on 2018/12/21.
//

#import "YLT_TangramView+layout.h"
#import "YLT_TangramView+OrientationH.h"
#import "YLT_TangramView+OrientationV.h"
@implementation YLT_TangramView (layout)
//更新约束
- (void)updateLayout {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.superview) {
            self.superview.backgroundColor = [UIColor ylt_randomColor];
            self.backgroundColor = [UIColor ylt_randomColor];
        }
        [self updateSize];
    });
}

- (void)updateSize {
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    if (self.pageModel.layoutGravity > 0) {
        if (self.pageModel.layoutGravity == LayoutGravity_Left) {
            [self marginLeft];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Right) {
            [self marginRight];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Top) {
            [self marginTop];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Bottom) {
            [self marginBottom];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Top + LayoutGravity_Left) {
            [self marginLeftTop];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Top + LayoutGravity_Right) {
            [self marginRightTop];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Bottom + LayoutGravity_Left) {
            [self marginLeftBottom];
        }else if (self.pageModel.layoutGravity == LayoutGravity_Bottom + LayoutGravity_Right) {
            [self marginRightBottom];
        }else if (self.pageModel.layoutGravity == LayoutGravity_H_center) {
            [self marginH];
        }else if (self.pageModel.layoutGravity == LayoutGravity_V_center){
            [self marginV];
        }else if (self.pageModel.layoutGravity == LayoutGravity_V_center + LayoutGravity_H_center){
            [self marginVH];
        }else if (self.pageModel.layoutGravity == (LayoutGravity_Top + LayoutGravity_Bottom + LayoutGravity_Left + LayoutGravity_Right)) {
            [self marginVH];
        }
    } else {
        //TODO :正常约束，带有优先级...(方案太多，考虑中...0.0)
        if (self.pageModel.orientation == Orientation_H) {
            //垂直布局
            [self updateOrientationHLayout];
        } else if (self.pageModel.orientation == Orientation_V) {
            //水平布局
            [self updateOrientationVLayout];
        } else {
            [self marginLayout];
        }
    }
}
#pragma mark marginLayout 无对齐方式的约束
- (void)marginLayout {
    /**
     0表示margin值约束为0，1 表示margin > 0的情况
     0000; 1种
     0001,0010,0100,1000;如果存在1位的，则有 1 * 4种方案
     1100，1010，1001，0101，0110，0011;存在两位的，则有3 * 2 ，6种方案
     1110,1101,1011,0111;4 种
     1111；1种
     */
    if (self.pageModel.ylt_layoutMagin.top == 0 &&
        self.pageModel.ylt_layoutMagin.bottom == 0 &&
        self.pageModel.ylt_layoutMagin.left == 0 &&
        self.pageModel.ylt_layoutMagin.right == 0) {
        //0000
        [self marginTopBottomLeftRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //0001,右上约束为主
        [self marginTopBottomLeftZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //0010 左上约束为主
        [self marginTopBottomRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //0100 左下约束为主
        [self marginTopLeftRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //1000 左上约束为主
        [self marginBottomLeftRightZero];
        
        //TODO:以上仅有一个约束调整为主 即为0,0,0,1 随机组合约束
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //1100
        [self marginLeftRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //1010 该情况，同上约束保持一致
        [self marginBottomRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //1001
        [self marginBottomLeftZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //0101 右下约束为主
        [self marginTopLeftZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //0110
        [self marginTopRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //0011
        [self marginTopBottomZero];
        //TODO: 以上为配置的6种模型0,0,1,1 随机组合
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right == 0){
        //        1110,
        [self marginRightZero];
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left == 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //1101
        [self marginLeftZero];
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom == 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //1011
        [self marginBottomZero];
    }else if (self.pageModel.ylt_layoutMagin.top == 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        //0111;
        [self marginTopZero];
    }else if (self.pageModel.ylt_layoutMagin.top > 0 &&
              self.pageModel.ylt_layoutMagin.bottom > 0 &&
              self.pageModel.ylt_layoutMagin.left > 0 &&
              self.pageModel.ylt_layoutMagin.right > 0){
        ///1111
        [self marginZero];
    }
}
#pragma mark layoutGravity layout 设置有对齐方式的约束
///左对齐
- (void)marginLeft {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.size.mas_equalTo([self size]);
        if (self.pageModel.ylt_layoutMagin.bottom > 0 &&
            self.pageModel.ylt_layoutMagin.top == 0) {
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        } else {
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        }
    }];
}
///右对齐
- (void)marginRight {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.size.mas_equalTo([self size]);
        if (self.pageModel.ylt_layoutMagin.bottom > 0 &&
            self.pageModel.ylt_layoutMagin.top == 0) {
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        } else {
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        }
    }];
}
///上对齐
- (void)marginTop {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
        if (self.pageModel.ylt_layoutMagin.right > 0 &&
            self.pageModel.ylt_layoutMagin.left == 0) {
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        } else {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        }
    }];
}
///下对齐
- (void)marginBottom {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        make.size.mas_equalTo([self size]);
        if (self.pageModel.ylt_layoutMagin.right > 0 &&
            self.pageModel.ylt_layoutMagin.left == 0) {
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        } else {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        }
    }];
}
///左上对齐
- (void)marginLeftTop {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
///左下对齐
- (void)marginLeftBottom{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        make.size.mas_equalTo([self size]);
    }];
}
///右上对齐
- (void)marginRightTop{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
///右下对齐
- (void)marginRightBottom{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        make.size.mas_equalTo([self size]);
    }];
}

#pragma mark 水平约束
- (void)marginV {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superview);
        //考虑上对齐还是下对齐
        if (self.pageModel.ylt_layoutMagin.top == 0 && self.pageModel.ylt_layoutMagin.bottom > 0) {
            //水平 下约束为主
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            make.size.mas_equalTo([self size]);
        } else {
            //水平 上下约束为主
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            make.size.mas_equalTo([self size]);
        }
    }];
}
#pragma mark 垂直约束
- (void)marginH {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.superview);
        //考虑左右优先级
        if (self.pageModel.ylt_layoutMagin.left == 0 && self.pageModel.ylt_layoutMagin.right > 0) {
            //水平 下约束为主
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            make.size.mas_equalTo([self size]);
        } else {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.size.mas_equalTo([self size]);
        }
    }];
}
#pragma mark 中心约束
- (void)marginVH {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.superview);
        make.size.mas_equalTo([self size]);
    }];
}
#pragma mark 左上约束为主
//考虑约束 0000 左上约束为主
- (void)marginTopBottomLeftRightZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 0011
- (void)marginTopBottomZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 0010 左上约束为主
- (void)marginTopBottomRightZero {
    //该值取的为左上约束，跟0000约束保持一致
    [self marginTopBottomLeftRightZero];
}
//考虑约束 1000 左上约束为主
- (void)marginBottomLeftRightZero {
    [self marginTopBottomLeftRightZero];
}
//考虑约束 1100 上下约束
- (void)marginLeftRightZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 1010 //左上约束为主
- (void)marginBottomRightZero {
    [self marginTopBottomLeftRightZero];
}
//考虑约束 1110
- (void)marginRightZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 1011 左上约束为主
- (void)marginBottomZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
// 考虑约束 1111 左上约束为主
- (void)marginZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
#pragma mark 右上约束为主
//考虑约束 0001, 右上约束为主
- (void)marginTopBottomLeftZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //右上约束为主
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 1101 右上约束为主
- (void)marginLeftZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 1001 右上约束为主
- (void)marginBottomLeftZero {
    [self marginTopBottomLeftZero];
}
#pragma mark 左下约束为主
//考虑约束 0100 左下约束为主
- (void)marginTopLeftRightZero {
    //左下约束为主
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        make.size.mas_equalTo([self size]);
    }];
}
//考虑约束 0110 左下约束为主
- (void)marginTopRightZero {
    [self marginTopLeftRightZero];
}
//考虑约束 0111 左下约束为主
- (void)marginTopZero {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        //左上约束为主
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        make.size.mas_equalTo([self size]);
    }];
}
#pragma mark 右下约束为主
//考虑约束 0101 右下约束为主
- (void)marginTopLeftZero {
    //左下约束为主
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
        make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        make.size.mas_equalTo([self size]);
    }];
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
    } else if (height > 0 && width == 0){
        width = height * self.pageModel.layoutRation;
    } else if (height == 0 && width == 0) {
        //直接填充
        width = [self maxWidth];
        height = [self maxHeight];
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
