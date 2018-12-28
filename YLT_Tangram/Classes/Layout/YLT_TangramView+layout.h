//
//  YLT_TangramView+layout.h
//  YLT_Tangram
//
//  Created by John on 2018/12/21.
//

#import <YLT_Tangram/YLT_Tangram.h>

@interface YLT_TangramView (layout)
- (void)updateLayout;
- (void)updateVlayoutWithLastSub:(YLT_TangramView *)sub subTangrams:(TangramFrameLayout *)subTangrams;
- (void)updateHlayoutWithLastSub:(YLT_TangramView *)sub subTangrams:(TangramFrameLayout *)subTangrams;
@end
