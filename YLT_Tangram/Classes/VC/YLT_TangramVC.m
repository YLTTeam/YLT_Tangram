//
//  YLT_TangramVC.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramVC.h"
#import "YLT_TangramCell.h"
#import "YLT_TangramManager.h"
#import "YLT_TangramVC+Delegate.h"

@interface YLT_TangramVC ()

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation YLT_TangramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

+ (YLT_TangramVC *)tangramWithPages:(NSArray<NSDictionary *> *)pages
                           requests:(NSDictionary<NSString *, NSDictionary *> *)pageRequests
                          withDatas:(NSMutableDictionary *)datas {
    YLT_TangramVC *result = [[YLT_TangramVC alloc] init];
    result.pageRequest = pageRequests;
    result.pageDatas = datas;
    [pages enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            Class cls = TangramView.class;
            if ([obj.allKeys containsObject:@"type"]) {
                Class tempCls = NSClassFromString([obj objectForKey:@"type"]);
                if (tempCls != NULL) {
                    cls = tempCls;
                }
            }
            TangramView *pageModel = [cls mj_objectWithKeyValues:obj];
            [result.mainCollectionView registerClass:YLT_TangramCell.class forCellWithReuseIdentifier:pageModel.ylt_identify];
            [result.pageModels addObject:pageModel];
        }
    }];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setter getter

- (void)setPageRequest:(NSDictionary<NSString *,NSDictionary *> *)pageRequest {
    _pageRequest = pageRequest;
    __block NSMutableArray<TangramRequest *> *requests = [[NSMutableArray alloc] init];
    [pageRequest enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        if (key.ylt_isValid) {
            TangramRequest *request = [TangramRequest mj_objectWithKeyValues:obj];
            request.keyname = key;
            [requests addObject:request];
        }
    }];
    
    if ([YLT_TangramManager shareInstance].tangramRequest) {
        @weakify(self);
        [YLT_TangramManager shareInstance].tangramRequest(requests, ^(NSDictionary *result) {
            @strongify(self);
            [self.pageDatas addEntriesFromDictionary:result];
            [self.mainCollectionView reloadData];
        });
    }
}

- (NSMutableDictionary *)reqParams {
    if (!_reqParams) {
        _reqParams = [[NSMutableDictionary alloc] init];
    }
    return _reqParams;
}

- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.backgroundColor = UIColor.clearColor;
        [self.view addSubview:_mainCollectionView];
        [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _mainCollectionView;
}

- (void)setPageDatas:(NSMutableDictionary *)pageDatas {
    if (!_pageDatas) {
        _pageDatas = [[NSMutableDictionary alloc] init];
    }
    [_pageDatas removeAllObjects];
    if (pageDatas) {
        [_pageDatas addEntriesFromDictionary:pageDatas];
    }
}

- (NSMutableArray *)pageModels {
    if (!_pageModels) {
        _pageModels = [[NSMutableArray alloc] init];
    }
    return _pageModels;
}

@end
