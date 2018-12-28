//
//  TangramModel+Calculate.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "TangramModel+Calculate.h"
#import "YLT_TangramView.h"
#import <objc/runtime.h>
@implementation TangramView (Calculate)

@dynamic ylt_padding;
@dynamic ylt_layoutMagin;

- (UIEdgeInsets)ylt_padding {
    return UIEdgeInsetsMake((self.paddingTop==0)?self.padding:self.paddingTop, (self.paddingLeft==0)?self.padding:self.paddingLeft, (self.paddingBottom==0)?self.padding:self.paddingBottom, (self.paddingRight==0)?self.padding:self.paddingRight);
}

- (UIEdgeInsets)ylt_layoutMagin {
    return UIEdgeInsetsMake((self.layoutMarginTop==0)?self.layoutMargin:self.layoutMarginTop, (self.layoutMarginLeft==0)?self.layoutMargin:self.layoutMarginLeft, (self.layoutMarginBottom==0)?self.layoutMargin:self.layoutMarginBottom, (self.layoutMarginRight==0)?self.layoutMargin:self.layoutMarginRight);
}

- (NSString *)ylt_identify {
    return self.identify.ylt_isValid?self.identify:NSStringFromClass(self.class);
}

- (void)setLayoutWeightWidth:(CGFloat)layoutWeightWidth {
    objc_setAssociatedObject(self, @selector(layoutWeightWidth), @(layoutWeightWidth), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)layoutWeightWidth {
    id value = objc_getAssociatedObject(self, @selector(layoutWeightWidth));
    return [value doubleValue];
}

- (void)setLayoutWeightHeight:(CGFloat)layoutWeightHeight {
    objc_setAssociatedObject(self, @selector(layoutWeightHeight), @(layoutWeightHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)layoutWeightHeight {
    id value = objc_getAssociatedObject(self, @selector(layoutWeightHeight));
    return [value doubleValue];
}

@end

@implementation TangramFrameLayout (Calculate)
- (void)setSubTangrams:(NSMutableArray<TangramView *> *)subTangrams {
    @synchronized(subTangrams) {
        __block CGFloat layoutTotalH = 0.0;
        __block CGFloat layoutTotalV = 0.0;
        [subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.orientation == Orientation_H ) {
                obj.layoutWeightHeight = obj.layoutHeight > 0 ? 0 : obj.layoutWeight;
                layoutTotalH += obj.layoutWeightHeight;
            } else if (self.orientation == Orientation_V) {
                obj.layoutWeightWidth = obj.layoutWidth > 0 ? 0 : obj.layoutWeight;
                 layoutTotalV += obj.layoutWeightWidth;
            }
        }];
        self.layoutTotalV = layoutTotalV;
        self.layoutTotalH = layoutTotalH;
        objc_setAssociatedObject(self, @selector(subTangrams), subTangrams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSMutableArray<TangramView *> *)subTangrams {
    return objc_getAssociatedObject(self, @selector(subTangrams));
}

- (void)setLayoutTotalH:(CGFloat)layoutTotalH {
    objc_setAssociatedObject(self, @selector(layoutTotalH), @(layoutTotalH), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)layoutTotalH {
    id value = objc_getAssociatedObject(self, @selector(layoutTotalH));
    return [value doubleValue];
}

- (void)setLayoutTotalV:(CGFloat)layoutTotalV {
    objc_setAssociatedObject(self, @selector(layoutTotalV), @(layoutTotalV), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)layoutTotalV {
    id value = objc_getAssociatedObject(self, @selector(layoutTotalV));
    return [value doubleValue];
}
@end

