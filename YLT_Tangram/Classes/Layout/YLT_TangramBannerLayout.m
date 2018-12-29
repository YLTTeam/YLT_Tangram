//
//  YLT_TangramBannerLayout.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/27.
//

#import "YLT_TangramBannerLayout.h"
#import "TangramModel.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface YLT_TangramBannerLayout () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) NSMutableArray *titleArr;
@end

@implementation YLT_TangramBannerLayout

- (void)refreshPage {
    if ([self.content isKindOfClass:[TangramBannerLayout class]]) {
        self.list = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.content.dataTag];
        self.bannerView.imageURLStringsGroup = self.imgArr;
        if (self.imgArr.count > 1) {
            self.bannerView.autoScrollTimeInterval = self.content.duration > 0 ? self.content.duration : 5;
            self.bannerView.currentPageDotColor = [self.content.selectedColor ylt_colorFromHexString];
            self.bannerView.pageDotColor = [self.content.normalColor ylt_colorFromHexString];
        }
    }
}

- (TangramBannerLayout *)content {
    return (TangramBannerLayout *)self.pageModel;
}

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.bannerView];
        [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

#pragma mark setter
- (void)setList:(NSArray *)list {
    if ([list isKindOfClass:[NSError class]] || ![list isKindOfClass:[NSArray class]]) {
        return;
    }
    _list = list;
    if (list.count > 0) {
        [self.imgArr removeAllObjects];
    }
    __block NSString *imageTag = @"";
    __block NSString *textTag = @"";
    TangramFrameLayout *layout = (TangramFrameLayout *)[YLT_TangramUtils typeFromPageData:self.content.itemName];
    [layout.subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.type isEqualToString:@"TangramLabel"]) {
            TangramLabel *label = [TangramLabel mj_objectWithKeyValues:obj.ylt_sourceData];
            textTag = label.text;
        } else if ([obj.type isEqualToString:@"TangramImage"]) {
            TangramImage *image = [TangramImage mj_objectWithKeyValues:obj.ylt_sourceData];
            imageTag = image.src;
        }
    }];
    
    for (NSDictionary *obj in list) {
        NSString *image = [YLT_TangramUtils valueFromSourceData:obj keyPath:imageTag];
        NSString *text = [YLT_TangramUtils valueFromSourceData:obj keyPath:textTag];
        if (image) {
            if ([YLT_TangramManager shareInstance].tangramImageURLString) {
                image = [YLT_TangramManager shareInstance].tangramImageURLString(image);
            }
            [self.imgArr addObject:image];
        }
        if (text) {
            [self.titleArr addObject:text];
        }
    }
}

#pragma mark getter

- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
        _bannerView.autoScrollTimeInterval = 5.0;
        _bannerView.pageControlBottomOffset = 5.0;
        _bannerView.pageDotColor = [UIColor clearColor];
        _bannerView.currentPageDotColor = [UIColor clearColor];
    }
    return _bannerView;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray new];
    }
    return _titleArr;
}

- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray new];
    }
    return _imgArr;
}

#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.list.count > index && self.selectItem) {
        self.selectItem(self.list[index]);
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}
@end
