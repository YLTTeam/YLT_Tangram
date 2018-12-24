//
//  YLT_TangramImage.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramImage.h"
#import "YLT_TangramUtils.h"

@interface YLT_TangramImage() {
}
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YLT_TangramImage

- (void)refreshPage {
    if ([self.content isKindOfClass:[TangramImage class]]) {
        self.imageView.ylt_image(self.content.src);
        if (self.pageData && [self.content.src hasPrefix:@"$"]) {
            self.imageView.ylt_image([YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.content.src]);
        }
    }
    self.imageView.backgroundColor = UIColor.clearColor;
}

#pragma mark - setter getter

- (TangramImage *)content {
    if (!_content) {
        _content = [TangramImage mj_objectWithKeyValues:self.pageModel.ylt_sourceData];
    }
    return _content;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = UIImageView.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }).ylt_convertToImageView();
    }
    return _imageView;
}

@end
