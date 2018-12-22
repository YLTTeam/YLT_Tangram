//
//  YLT_TangramView+layout.m
//  YLT_Tangram
//
//  Created by John on 2018/12/21.
//

#import "YLT_TangramView+layout.h"

@implementation YLT_TangramView (layout)
//更新约束
- (void)updateLayout {
    [self updateSize];
}

- (void)updateSize {
    NSLog(@"width %lf height %lf",self.superview.ylt_size.width,self.superview.ylt_size.height);
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
        }else if (self.pageModel.layoutGravity == LayoutGravity_Bottom + LayoutGravity_Left) {
            [self marginLeftBottom];
        }else if (self.pageModel.layoutGravity == LayoutGravity_H_center) {
            [self marginY];
        }else if (self.pageModel.layoutGravity == LayoutGravity_V_center){
            [self marginX];
        }else if (self.pageModel.layoutGravity == LayoutGravity_V_center + LayoutGravity_H_center){
            [self marginCenter];
        }else if (self.pageModel.layoutGravity == (LayoutGravity_Top + LayoutGravity_Bottom + LayoutGravity_Left + LayoutGravity_Right)) {
            [self marginCenter];
        }
    }else{
        //TODO :正常约束，带有优先级...(方案太多，考虑中...0.0)
        [self marginLayout];
    }
}
#pragma mark marginLayout 无对齐方式的约束
- (void)marginLayout {
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    /**
     0表示margin值约束为0，1 表示margin > 0的情况
     0000; 1种
     0001,0010,0100,1000;如果存在1位的，则有 1 * 4种方案
     1100，1010，1001，0101，0110，0011;存在两位的，则有3 * 2 ，6种方案
     1110,1101,1011,0111;4 种
     1111；1种
     */
    if (self.pageModel.layoutMarginTop == 0 &&
        self.pageModel.layoutMarginBottom == 0 &&
        self.pageModel.layoutMarginLeft == 0 &&
        self.pageModel.layoutMarginRight == 0) {
        //如果都为0，则默认从左上边约束，有待商量 0000 左上约束为主
        //TODO:该方案有待商榷
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight > 0){
        //0001,右上约束为主
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight == 0){
        //0010 左上约束为主
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight == 0){
        //0100 左下约束为主
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            if ([self size].height > 0) {
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            }
        }];
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight == 0){
        //1000 左上约束为主
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
        //TODO:以上仅有一个约束调整为主 即为0,0,0,1 随机组合约束
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight == 0){
        //约束条件，即为上下，由于缺少左右约束，即为left加主约束
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight == 0){
        //1010 该情况，同上约束保持一致
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight > 0){
        //1001
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight > 0){
        //0101
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight == 0){
        //0110
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight > 0){
        //0011
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
        //TODO: 以上为配置的6种模型0,0,1,1 随机组合
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight == 0){
//        1110,
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft == 0 &&
              self.pageModel.layoutMarginRight > 0){
        //1101
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom == 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight > 0){
        //1011
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }else if (self.pageModel.layoutMarginTop == 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight > 0){
        //0111;
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            }
        }];
    }else if (self.pageModel.layoutMarginTop > 0 &&
              self.pageModel.layoutMarginBottom > 0 &&
              self.pageModel.layoutMarginLeft > 0 &&
              self.pageModel.layoutMarginRight > 0){
        ///1111
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if ([self size].height > 0) {
                //如果有设置该size， 直接以left top 为主
                make.size.mas_equalTo([self size]);
            }else{
                make.width.mas_equalTo([self size].width);
                make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
            }
        }];
    }
}
#pragma mark layoutGravity layout 设置有对齐方式的约束
- (void)marginLeft {
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    //左
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //以上宽高，全部计算完毕,进行设置约束
    //考虑之前设定的top，bottom
    if ((self.pageModel.layoutMarginTop == 0 && self.pageModel.layoutMarginBottom == 0) ||
        (self.pageModel.layoutMarginTop > 0 && self.pageModel.layoutMarginBottom > 0)) {
        // 上下与父视图默认为0 获取默认都> 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginBottom == 0 && self.pageModel.layoutMarginTop > 0) {
        // margin-bottom 0 ;marginTop > 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginBottom > 0 && self.pageModel.layoutMarginTop == 0){
        // margin-bottom > 0 ;marginTop == 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.top);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.top.mas_equalTo(0);
            }
        }];
    }
}

- (void)marginRight {
    //右
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //以上宽高，全部计算完毕,进行设置约束
    //考虑之前设定的top，bottom
    if ((self.pageModel.layoutMarginTop == 0 && self.pageModel.layoutMarginBottom == 0) ||
        (self.pageModel.layoutMarginTop > 0 && self.pageModel.layoutMarginBottom > 0)) {
        // 上下与父视图默认为0 获取默认都> 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginBottom == 0 && self.pageModel.layoutMarginTop > 0) {
        // margin-bottom 0 ;marginTop > 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginBottom > 0 && self.pageModel.layoutMarginTop == 0){
        // margin-bottom > 0 ;marginTop == 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.top);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.top.mas_equalTo(0);
            }
        }];
    }
}

- (void)marginTop {
    //上
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //以上宽高，全部计算完毕,进行设置约束
    //考虑之前设定的top，bottom
    if ((self.pageModel.layoutMarginLeft == 0 && self.pageModel.layoutMarginRight == 0) ||
        (self.pageModel.layoutMarginLeft > 0 && self.pageModel.layoutMarginRight > 0)) {
        // 左右与父视图默认为0 获取默认都> 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginLeft == 0 && self.pageModel.layoutMarginRight > 0) {
        // margin-left 0 ;marginRight > 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginLeft > 0 && self.pageModel.layoutMarginRight == 0){
        // margin-left > 0 ;marginRight == 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.bottom.mas_equalTo(0);
            }
        }];
    }
}

- (void)marginBottom {
    //下
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //以上宽高，全部计算完毕,进行设置约束
    //考虑之前设定的top，bottom
    if ((self.pageModel.layoutMarginLeft == 0 && self.pageModel.layoutMarginRight == 0) ||
        (self.pageModel.layoutMarginLeft > 0 && self.pageModel.layoutMarginRight > 0)) {
        // 左右与父视图默认为0 获取默认都> 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.pageModel.layoutMarginLeft);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.top.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginLeft == 0 && self.pageModel.layoutMarginRight > 0) {
        // margin-left 0 ;marginRight > 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-self.pageModel.ylt_layoutMagin.right);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.top.mas_equalTo(0);
            }
        }];
    }else if (self.pageModel.layoutMarginLeft > 0 && self.pageModel.layoutMarginRight == 0){
        // margin-left > 0 ;marginRight == 0
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
            if (height > 0) {
                make.height.mas_equalTo(height);
            }else{
                make.top.mas_equalTo(0);
            }
        }];
    }
}

- (void)marginLeftTop {
    //左上
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        if (height > 0) {
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        }
    }];
}

- (void)marginLeftBottom{
    //左下
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        if (height > 0) {
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        }
    }];
}

- (void)marginRightTop{
    //右上
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        if (height > 0) {
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.bottom.mas_equalTo(-self.pageModel.ylt_layoutMagin.bottom);
        }
    }];
}

- (void)marginRightBottom{
    //右下
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        if (height > 0) {
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
        }
    }];
}

- (void)marginCenter {
    //中心
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (height > 0) {
            make.center.equalTo(self.superview);
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.centerX.equalTo(self.superview);
            make.top.bottom.mas_equalTo(0);
        }
    }];
}

- (void)marginY {
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pageModel.ylt_layoutMagin.left);
        if (height > 0) {
            make.centerY.equalTo(self.superview);
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.top.bottom.mas_equalTo(0);
        }
    }];
}

- (void)marginX {
    if (!self.superview) {
        NSAssert(NO, @"superView is nil");
        return;
    }
    CGFloat width = [self size].width;
    CGFloat height = [self size].height;
    //直接考虑height
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superview);
        if (height > 0) {
            make.top.mas_equalTo(self.pageModel.ylt_layoutMagin.top);
            make.size.mas_equalTo([self size]);
        }else{
            make.width.mas_equalTo(width);
            make.top.bottom.mas_equalTo(0);
        }
    }];
}
//TODO:原本以
- (CGSize)size {
    if (!self.superview) {
        return CGSizeZero;
    }
    CGFloat width = 0.0;
    float mariginMax = self.superview.ylt_size.width - self.pageModel.ylt_layoutMagin.left -self.pageModel.ylt_layoutMagin.right;
    
    if (self.pageModel.layoutWidth.floatValue > 0) {
        //直接取layoutMargin,超出屏幕部分，去除
        width = self.pageModel.layoutWidth.floatValue >= mariginMax ? mariginMax:self.pageModel.layoutWidth.floatValue;
    }
    //当宽度依旧为0,取最小值
    if (width == 0.0) {
        width = self.pageModel.minWidth;
    }
    
    //考虑高度
    CGFloat height = 0.0;
    if (self.pageModel.layoutHeight.floatValue > 0) {
        height = self.pageModel.layoutHeight.floatValue;
    }
    if (height == 0.0) {
        height = self.pageModel.minHeight;
    }
    
    //根据比例来计算宽高,当高为0 切宽不为0的时候
    if (height == 0 && width > 0){
        //当高度为0，宽度不为0的时候，根据比例来计算宽高比
        height = width * self.pageModel.autoDimX;
    }else if (height > 0 && width == 0){
        width = height * self.pageModel.autoDimY;
    }else{
        //其他不考虑
    }
    //当满足上述条件之后，width依旧为0，则直接设置最大限度width
    width = width == 0 ? mariginMax : width;
    return CGSizeMake(width, height);
}
@end
