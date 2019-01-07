//
//  YLT_TangramImage.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramImage.h"
#import "YLT_TangramUtils.h"
#import "YLT_TangramManager.h"

@interface YLT_TangramImage() {
}
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YLT_TangramImage

- (void)refreshPage {
    if ([self.content isKindOfClass:[TangramImage class]]) {
        if (self.content.src.ylt_isValid && ![self.content.src hasPrefix:@"$"]) {
            self.imageView.ylt_image(self.content.src);
        }
        
        if (self.pageData && [self.content.src hasPrefix:@"$"]) {
            NSString *urlstring = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.content.src];
            if ([YLT_TangramManager shareInstance].tangramImageURLString) {
                urlstring = [YLT_TangramManager shareInstance].tangramImageURLString(urlstring);
            }
            self.imageView.ylt_image(urlstring);
        }
    }
}

#pragma mark - setter getter

- (TangramImage *)content {
    return (TangramImage *)self.pageModel;
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
