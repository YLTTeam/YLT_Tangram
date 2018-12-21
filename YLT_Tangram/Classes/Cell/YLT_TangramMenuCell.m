//
//  YLT_TangramMenuCell.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramMenuCell.h"
#import "YLT_TangramLabel.h"
#import "YLT_TangramImage.h"
#import "YLT_TangramManager.h"

@interface YLT_TangramMenuCell() {
}
@property (nonatomic, strong) YLT_TangramLabel *contentLabel;
@property (nonatomic, strong) YLT_TangramImage *contentImage;

@end

@implementation YLT_TangramMenuCell

- (void)reloadCellData:(NSDictionary *)data {
    TangramView *model = [YLT_TangramManager typeFromPageData:data];
    NSLog(@"%@", model.ylt_sourceData);
    
    
//    self.contentLabel.pageData = data;
//    self.contentImage.pageData = data;
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

- (YLT_TangramImage *)contentImage {
    if (!_contentImage) {
        _contentImage = [[YLT_TangramImage alloc] init];
        [self addSubview:_contentImage];
        [_contentImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _contentImage;
}

@end
