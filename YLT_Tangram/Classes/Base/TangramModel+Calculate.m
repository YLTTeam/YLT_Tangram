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

@end

@implementation TangramFrameLayout (Calculate)

- (CGFloat)ylt_layoutWidthTotalWeight {
    return [objc_getAssociatedObject(self, @selector(ylt_layoutWidthTotalWeight)) floatValue];
}

- (CGFloat)ylt_layoutHeightTotalWeight {
    return [objc_getAssociatedObject(self, @selector(ylt_layoutHeightTotalWeight)) floatValue];
}

- (CGFloat)ylt_layoutMarginTotal {
    return [objc_getAssociatedObject(self, @selector(ylt_layoutMarginTotal)) floatValue];
}

- (void)setSubTangrams:(NSMutableArray<TangramView *> *)subTangrams {
    @synchronized(subTangrams) {
        __block CGFloat layoutTotalWidth = 0.0;
        __block CGFloat layoutTotalHeight = 0.0;
        __block CGFloat layoutMarginTotal = 0.0;
        if (self.orientation == Orientation_H) {
            layoutMarginTotal += self.ylt_padding.left+self.ylt_padding.right;
        } else {
            layoutMarginTotal += self.ylt_padding.top+self.ylt_padding.bottom;
        }
        [subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.orientation == Orientation_H) {
                obj.layoutWeight = obj.layoutWidth > 0 ? 0 : obj.layoutWeight;
                layoutTotalWidth += obj.layoutWeight;
                layoutMarginTotal += obj.ylt_layoutMagin.left+obj.ylt_layoutMagin.right;
            } else {
                obj.layoutWeight = obj.layoutHeight > 0 ? 0 : obj.layoutWeight;
                layoutTotalHeight += obj.layoutWeight;
                layoutMarginTotal += obj.ylt_layoutMagin.top+obj.ylt_layoutMagin.bottom;
            }
            
        }];
        objc_setAssociatedObject(self, @selector(ylt_layoutWidthTotalWeight), @(layoutTotalWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, @selector(ylt_layoutHeightTotalWeight), @(layoutTotalHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, @selector(ylt_layoutMarginTotal), @(layoutMarginTotal), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, @selector(subTangrams), subTangrams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSMutableArray<TangramView *> *)subTangrams {
    return objc_getAssociatedObject(self, @selector(subTangrams));
}

@end

