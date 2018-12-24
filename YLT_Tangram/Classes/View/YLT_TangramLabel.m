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
    if ([self.content isKindOfClass:[TangramLabel class]]) {
        self.label.text = self.content.text;
        self.label.ylt_textColor(self.content.textColor.ylt_colorFromHexString);
        if (self.pageData && [self.content.text hasPrefix:@"$"]) {
            self.label.text = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.content.text];
        }
    }
}

#pragma mark - setter getter

- (TangramLabel *)content {
    if (!_content) {
        _content = [TangramLabel mj_objectWithKeyValues:self.pageModel.ylt_sourceData];
    }
    return _content;
}

- (UILabel *)label {
    if (!_label) {
        _label = UILabel.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }).ylt_convertToLabel();
    }
    return _label;
}

@end
