//
//  YLT_TangramLabelCell.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramLabelCell.h"
#import "YLT_TangramManager.h"

@interface YLT_TangramLabelCell () {
}
@property (nonatomic, strong) YLT_TangramLabel *contentLabel;
@end

@implementation YLT_TangramLabelCell

- (void)reloadCellData:(id)data {
    self.contentLabel.pageData = data;
}

- (YLT_TangramLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YLT_TangramLabel alloc] init];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _contentLabel;
}

@end
