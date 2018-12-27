//
//  YLT_TangramView+OrientationV.m
//  YLT_Tangram
//
//  Created by John on 2018/12/27.
//

#import "YLT_TangramView+OrientationV.h"

@implementation YLT_TangramView (OrientationV)
- (void)updateOrientationVLayout {
    if (!self.superview) {
        NSAssert(NO, @"superview is nil");
        return;
    }
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pageModel.layoutLeft);
        make.size.mas_equalTo(CGSizeMake(self.pageModel.layoutWidth, self.pageModel.layoutHeight));
        make.centerY.equalTo(self.superview);
    }];
}
@end
