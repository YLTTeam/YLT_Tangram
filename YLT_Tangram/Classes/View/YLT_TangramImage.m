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
//        UIViewContentModeScaleToFill,
//        UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//        UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
//        UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
//        UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
//        UIViewContentModeTop,
//        UIViewContentModeBottom,
//        UIViewContentModeLeft,
//        UIViewContentModeRight,
//        UIViewContentModeTopLeft,
//        UIViewContentModeTopRight,
//        UIViewContentModeBottomLeft,
//        UIViewContentModeBottomRight,
        switch (self.content.scaleType) {
            case ScaleType_Center: {
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
                break;
            case ScaleType_Fit_xy: {
                self.imageView.contentMode = UIViewContentModeScaleToFill;
            }
                break;
            case ScaleType_Matrix: {
            }
                break;
            case ScaleType_Fit_start: {
                self.imageView.contentMode = UIViewContentModeTopLeft;
            }
                break;
            case ScaleType_Fit_end: {
                self.imageView.contentMode = UIViewContentModeBottomRight;
            }
                break;
            case ScaleType_Fit_center: {
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
                break;
            case ScaleType_Center_crop: {
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
                break;
            case ScaleType_Center_inside: {
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
                break;
            default: {
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
                break;
        }
        
        
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
