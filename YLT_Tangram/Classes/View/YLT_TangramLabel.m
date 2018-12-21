//
//  YLT_TangramLabel.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramLabel.h"
#import <YLT_Kit/YLT_Kit.h>
#import "YLT_TangramUtils.h"

@interface YLT_TangramLabel () {
}
@property (nonatomic, strong) UILabel *label;
@end

@implementation YLT_TangramLabel

- (void)refreshPage {
    if ([self.pageModel isKindOfClass:[TangramLabel class]]) {
        self.label.text = ((TangramLabel *) self.pageModel).text;
        self.label.ylt_textColor(((TangramLabel *) self.pageModel).textColor.ylt_colorFromHexString);
    }
    if (self.pageData) {
        self.label.text = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.pageModel.keypath];
    }
}

#pragma mark - setter getter

- (UILabel *)label {
    if (!_label) {
        _label = UILabel.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }).ylt_convertToLabel();
    }
    return _label;
}

@end
