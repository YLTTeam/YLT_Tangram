//
//  YLT_TangramView+OrientationH.m
//  YLT_Tangram
//
//  Created by John on 2018/12/27.
//

#import "YLT_TangramView+OrientationH.h"

@implementation YLT_TangramView (OrientationH)
- (void)updateOrientationHLayout {
    if (!self.superview) {
        NSAssert(NO, @"superview is nil");
        return;
    }
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pageModel.layoutTop);
        make.size.mas_equalTo(CGSizeMake(self.pageModel.layoutWidth, self.pageModel.layoutHeight));
        make.centerX.equalTo(self.superview);
    }];
}
@end
