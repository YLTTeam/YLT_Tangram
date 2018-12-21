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
    if ([self.pageModel isKindOfClass:[TangramImage class]]) {
        self.imageView.ylt_image(((TangramImage *)self.pageModel).src);
    }
    if (self.pageData) {
        self.imageView.ylt_image([YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.pageModel.keypath]);
    }
}

#pragma mark - setter getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = UIImageView.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }).ylt_convertToImageView();
    }
    return _imageView;
}

@end
