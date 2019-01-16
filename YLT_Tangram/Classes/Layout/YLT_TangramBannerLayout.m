//
//  YLT_TangramBannerLayout.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/27.
//

#import "YLT_TangramBannerLayout.h"
#import "TangramModel.h"
#import "YLT_TangramCell.h"
#import "YLT_TangramUtils.h"
#import "YLT_TangramManager.h"
#import <YLT_Kit/YLT_Kit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface YLT_TangramBannerLayout () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) NSMutableArray *imgArr;
@property (nonatomic, strong) NSMutableArray <TangramFrameLayout *> *subBannerTangrams;
@end

@implementation YLT_TangramBannerLayout

- (void)refreshPage {
    if ([self.content isKindOfClass:[TangramBannerLayout class]]) {
        self.list = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:self.content.dataTag];
        
        if (self.imgArr.count >= 1) {
            self.bannerView.imageURLStringsGroup = self.imgArr;
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
        [self.mainView addSubview:self.bannerView];
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
        [self.subBannerTangrams removeAllObjects];
        [self.imgArr removeAllObjects];
    }
    
    for (NSDictionary *object in list) {
        TangramFrameLayout *layout = (TangramFrameLayout *)[YLT_TangramUtils typeFromItemname:self.content.itemName];
        [layout.subTangrams enumerateObjectsUsingBlock:^(TangramView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!(obj.ylt_sourceData && [obj.ylt_sourceData isKindOfClass:[NSDictionary class]])) {
                *stop = YES;
            }
            NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:obj.ylt_sourceData];
            NSString *keyPath = @"",*value = @"";
            if ([obj.type isEqualToString:@"TangramLabel"]) {
                TangramLabel *label = [TangramLabel mj_objectWithKeyValues:obj.ylt_sourceData];
                keyPath = label.text ? : @"";
                value = [YLT_TangramUtils valueFromSourceData:object keyPath:keyPath] ? : @"";
                params[@"text"] = value;
            } else if ([obj.type isEqualToString:@"TangramImage"]) {
                TangramImage *image = [TangramImage mj_objectWithKeyValues:obj.ylt_sourceData];
                keyPath = image.src ? : @"";
                value = [YLT_TangramUtils valueFromSourceData:object keyPath:keyPath] ? : @"";
                if ([YLT_TangramManager shareInstance].tangramImageURLString) {
                    value = [YLT_TangramManager shareInstance].tangramImageURLString(value);
                }
                params[@"src"] = value;
            }
            obj.ylt_sourceData = params;
        }];
        [self.imgArr addObject:@""];
        [self.subBannerTangrams addObject:layout];
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

- (NSMutableArray *)imgArr {
    if (!_imgArr) {
        _imgArr = [NSMutableArray new];
    }
    return _imgArr;
}

- (NSMutableArray<TangramFrameLayout *> *)subBannerTangrams {
    if (!_subBannerTangrams) {
        _subBannerTangrams = [NSMutableArray new];
    }
    return _subBannerTangrams;
}

#pragma mark SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    TangramView *layout = self.subBannerTangrams[index];
    NSDictionary *data = self.list[index];
    NSDictionary *clickAction = layout.action;
    if ([clickAction isKindOfClass:[NSString class]]) {
        clickAction = [YLT_TangramUtils valueFromSourceData:data keyPath:(NSString *)clickAction];
        if ([clickAction isKindOfClass:[NSString class]] && clickAction.mj_JSONObject) {
            clickAction = clickAction.mj_JSONObject;
        }
        if ([clickAction isKindOfClass:[NSString class]]) {
            clickAction = @{@"iOS":clickAction};
        }
    } else if ([clickAction isKindOfClass:[NSDictionary class]]) {
    }
    if (clickAction && clickAction.allKeys.count > 0) {
        if ([clickAction isKindOfClass:[NSDictionary class]] && [clickAction.allKeys containsObject:@"iOS"]) {
            NSArray<NSString *> *actionList = [clickAction objectForKey:@"iOS"];
            if ([actionList isKindOfClass:[NSString class]]) {
                actionList = @[(NSString *)actionList];
            }
            [actionList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.ylt_currentVC ylt_routerToURL:obj arg:nil completion:^(NSError *error, id response) {
                }];
            }];
        }
    }
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return [YLT_TangramCell class];
}

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    if (self.subBannerTangrams.count > index) {
        [(YLT_TangramCell *)cell cellFromConfig:self.subBannerTangrams[index]];
    }
}
@end
