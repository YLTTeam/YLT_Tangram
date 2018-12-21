//
//  TangramModel+Calculate.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "TangramModel+Calculate.h"
#import "YLT_TangramView.h"

@implementation TangramView (Calculate)

@dynamic ylt_padding;
@dynamic ylt_layoutMagin;

- (UIEdgeInsets)ylt_padding {
    return UIEdgeInsetsMake((self.paddingTop==0)?self.padding:self.paddingTop, (self.paddingLeft==0)?self.padding:self.paddingLeft, (self.paddingBottom==0)?self.padding:self.paddingBottom, (self.paddingRight==0)?self.padding:self.paddingRight);
}

- (UIEdgeInsets)ylt_layoutMagin {
    return UIEdgeInsetsMake((self.layoutMarginTop==0)?self.layoutMargin:self.layoutMarginTop, (self.layoutMarginLeft==0)?self.layoutMargin:self.layoutMarginLeft, (self.layoutMarginBottom==0)?self.layoutMargin:self.layoutMarginBottom, (self.layoutMarginRight==0)?self.layoutMargin:self.layoutMarginRight);
}

- (NSString *)ylt_templateKey {
    return self.identify.ylt_isValid?self.identify:NSStringFromClass(self.class);
}

@end


@implementation TangramGridLayout (Calculate)

@dynamic ylt_reuseClass;

- (Class)ylt_reuseClass {
    Class cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@Cell", self.itemName]);
    if (cls != NULL) {
        return cls;
    }
    cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@Cell", self.classname]);
    if (cls != NULL) {
        return cls;
    }
    cls = NSClassFromString([NSString stringWithFormat:@"YLT_%@", self.classname]);
    if (cls != NULL) {
        return cls;
    }
    return YLT_TangramView.class;
}

@end
