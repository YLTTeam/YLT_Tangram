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
#import <ZipArchive/ZipArchive.h>
#import <YLT_Crypto/YLT_Crypto.h>
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "YLT_TangramUtils.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <MutableDeepCopy/NSArray+mutableDeepCopy.h>
#import <MutableDeepCopy/NSDictionary+mutableDeepCopy.h>

#define TANGRAM_CACHE_KEY @"TANGRAM_CACHE_KEY"

@interface YLT_TangramVC ()

@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSMutableDictionary *cacheDictionary;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) UIImageView *bgImageView;
/**
 刷新字段
 */
@property (nonatomic, strong) NSDictionary *refresh;

/**
 网络请求
 */
@property (nonatomic, strong) NSDictionary<NSString *, NSDictionary *> *pageRequest;

@end

@implementation YLT_TangramVC

@synthesize pageDatas = _pageDatas;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.pageSize = 20;
    self.view.backgroundColor = UIColor.whiteColor;
}

+ (YLT_TangramVC *)tangramWithPages:(NSDictionary *)tangramDatas {
    YLT_TangramVC *result = [[YLT_TangramVC alloc] init];
    result.tangramData = tangramDatas;
    return result;
}

/**
 生成页面
 
 @param requestParams 页面的网络请求
 @return 页面
 */
+ (YLT_TangramVC *)tangramWithRequestParams:(NSDictionary *)requestParams {
    YLT_TangramVC *result = [[YLT_TangramVC alloc] init];
    if ([requestParams.allKeys containsObject:@"path"]) {
        NSString *urlPath = requestParams[@"path"];
        urlPath = [urlPath stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([result.cacheDictionary.allKeys containsObject:urlPath]) {
            NSString *file = result.cacheDictionary[urlPath];
            BOOL isDirectory = NO;
            if ([[NSFileManager defaultManager] fileExistsAtPath:file isDirectory:&isDirectory]) {
                if (isDirectory == NO) {
                    [result loadTemplatePath:[NSURL fileURLWithPath:file]];
                    return result;
                }
            }
        }
        
        NSURLSessionDownloadTask *task = [[AFHTTPSessionManager manager] downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlPath]] progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            NSString *path = [YLT_CACHE_PATH stringByAppendingPathComponent:[response suggestedFilename]];
            return [NSURL fileURLWithPath:path];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            NSString *zippath = filePath.absoluteString;
            NSString *path = filePath.absoluteString;
            if ([zippath hasPrefix:@"file://"]) {
                zippath = [zippath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            }
            if ([zippath hasSuffix:@".zip"]) {
                path = [zippath stringByReplacingOccurrencesOfString:@".zip" withString:@""];
                ZipArchive *archive = [[ZipArchive alloc] init];
                if ([archive UnzipOpenFile:zippath] && [archive UnzipFileTo:path overWrite:YES]) {
                    [archive UnzipCloseFile];
                    path = [NSString stringWithFormat:@"%@/%@", path, [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil] lastObject]];
                }
            }
            
            if ([YLT_TangramManager shareInstance].tangramKey.ylt_isValid) {
                /** 有秘钥，需要进行解密 */
                NSData *data = [NSData dataWithContentsOfFile:path];
                data = [YLT_AESCrypto dencryptData:data keyString:[YLT_TangramManager shareInstance].tangramKey iv:[YLT_TangramManager shareInstance].tangramIv];
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            if (path.ylt_isValid) {
                [result loadTemplatePath:[NSURL fileURLWithPath:path]];
                
                [result.cacheDictionary setObject:path forKey:urlPath];
                [[NSUserDefaults standardUserDefaults] setObject:result.cacheDictionary forKey:TANGRAM_CACHE_KEY];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }];
        [task resume];
    }
    return result;
}

- (void)loadTemplatePath:(NSURL *)fileURL {
    NSDictionary *resp = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:fileURL] options:NSJSONReadingAllowFragments error:nil];
    self.tangramData = resp;
}

- (void)setTangramData:(NSDictionary *)tangramData {
    _tangramData = tangramData;
    if ([tangramData isKindOfClass:[NSDictionary class]]) {
        if ([tangramData.allKeys containsObject:@"itemLayout"]) {
            self.itemLayouts = tangramData[@"itemLayout"];
        }
        if ([tangramData.allKeys containsObject:@"refresh"]) {
            self.refresh = tangramData[@"refresh"];
        }
        if ([tangramData.allKeys containsObject:@"layout"]) {
            NSArray *pages  = [tangramData objectForKey:@"layout"];
            [self realodPages:pages];
        }
        if ([tangramData.allKeys containsObject:@"data"]) {
            self.pageDatas = tangramData[@"data"];
        }
        if ([tangramData.allKeys containsObject:@"url"]) {
            self.pageRequest = [tangramData objectForKey:@"url"];
        }
        if ([tangramData.allKeys containsObject:@"title"]) {
            self.title = tangramData[@"title"];
        }
        if ([tangramData.allKeys containsObject:@"background"]) {
            NSString *colorString = tangramData[@"background"];
            if ([colorString hasPrefix:@"#"]) {
                self.bgImageView.backgroundColor = [colorString ylt_androidColorFromHexString];
            } else {
                self.bgImageView.ylt_image(colorString);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setter getter

- (void)realodPages:(NSArray *)pages {
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
            [self.mainCollectionView registerClass:YLT_TangramCell.class forCellWithReuseIdentifier:pageModel.ylt_identify];
            [self.pageModels addObject:pageModel];
        }
    }];
}

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

- (void)setRefresh:(NSDictionary *)refresh {
    _refresh = refresh;
    self.mainCollectionView.mj_header = nil;
    self.mainCollectionView.mj_footer = nil;
    if (refresh.allKeys.count > 0) {
        if ([self.refresh.allKeys containsObject:@"pageSize"]) {
            self.pageSize = [[self.refresh objectForKey:@"pageSize"] integerValue];
        }
        if ([self.refresh.allKeys containsObject:@"page"]) {
            self.page = [[self.refresh objectForKey:@"page"] integerValue];
        }
        NSString *pageKey = @"page";
        if ([self.refresh.allKeys containsObject:@"pageKey"]) {
            pageKey = [self.refresh objectForKey:@"pageKey"];
        }
        NSString *pageSizeKey = @"pageSize";
        if ([self.refresh.allKeys containsObject:@"pageSizeKey"]) {
            pageSizeKey = [self.refresh objectForKey:@"pageSizeKey"];
        }
        __block NSString *dataTag = nil;
        
        @weakify(self);
        if ([refresh.allKeys containsObject:@"header"]) {
            self.mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                @strongify(self);
                self.page = 1;
                if ([self.refresh.allKeys containsObject:@"page"]) {
                    self.page = [[self.refresh objectForKey:@"page"] integerValue];
                }
                if ([self.refresh.allKeys containsObject:@"page"]) {
                    self.page = [[self.refresh objectForKey:@"page"] integerValue];
                }
                NSDictionary *header = [self.refresh objectForKey:@"header"];
                [self analysisHeader:YES refreshData:header pageKey:pageKey pageSizeKey:pageSizeKey dataTag:dataTag];
            }];
        }
        if ([refresh.allKeys containsObject:@"footer"]) {
            self.mainCollectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                @strongify(self);
                self.page++;
                NSDictionary *footer = [self.refresh objectForKey:@"footer"];
                if ([footer.allKeys containsObject:@"dataTag"]) {
                    /** 用来标志数据的追加位置 */
                    dataTag = footer[@"dataTag"];
                }
                [self analysisHeader:NO refreshData:footer pageKey:pageKey pageSizeKey:pageSizeKey dataTag:dataTag];
            }];
        }
    }
}

- (void)analysisHeader:(BOOL)isHeader refreshData:(NSDictionary *)data pageKey:(NSString *)pageKey pageSizeKey:(NSString *)pageSizeKey dataTag:(NSString *)dataTag {
    if ([data.allKeys containsObject:@"url"] && [[data objectForKey:@"url"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *urls = [data objectForKey:@"url"];
        NSMutableArray *requests = [[NSMutableArray alloc] init];
        [urls enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            TangramRequest *request = [TangramRequest mj_objectWithKeyValues:obj];
            [request.params setObject:@(self.pageSize) forKey:pageSizeKey];
            [request.params setObject:@(self.page) forKey:pageKey];
            request.keyname = key;
            [request.params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSString class]] && [((NSString *) obj) hasPrefix:@"$"]) {
                    [request.params setObject:[YLT_TangramUtils valueFromSourceData:self.pageDatas keyPath:obj] forKey:key];
                }
            }];
            
            [requests addObject:request];
        }];
        
        if ([YLT_TangramManager shareInstance].tangramRequest) {
            @weakify(self);
            [YLT_TangramManager shareInstance].tangramRequest(requests, ^(NSDictionary *result) {
                [self.mainCollectionView.mj_header endRefreshing];
                [self.mainCollectionView.mj_footer endRefreshing];
                @strongify(self);
                [result enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    if (![obj isKindOfClass:[NSError class]]) {
                        if (isHeader) {
                            /** 下拉刷新 直接覆盖原数据 */
                            [self.pageDatas setObject:obj forKey:key];
                        } else {
                            /** 上拉加载更多 追加数据 */
                            id oldObj = [YLT_TangramUtils valueFromSourceData:self.pageDatas keyPath:dataTag];
                            
                            if ([oldObj isKindOfClass:[NSArray class]] && ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]])) {
                                id mutableObj = (id)[obj mutableDeepCopy];
                                NSMutableArray *list = [YLT_TangramUtils valueFromSourceData:mutableObj keyPath:dataTag];
                                if ([list isKindOfClass:[NSMutableArray class]]) {
                                    [[[((NSArray *) oldObj) reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                        [list insertObject:obj atIndex:0];
                                    }];
                                }
                                [self.pageDatas setObject:mutableObj forKey:key];
                            } else {
                                /** 目前不考虑非数组类型的上拉加载更多 */
                                [self.pageDatas setObject:obj forKey:key];
                            }
                        }
                    }
                }];
                [self.mainCollectionView reloadData];
            });
        }
    }
}

- (NSMutableDictionary *)reqParams {
    if (!_reqParams) {
        _reqParams = [[NSMutableDictionary alloc] init];
    }
    return _reqParams;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        [self.view insertSubview:_bgImageView atIndex:0];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _bgImageView;
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
    [self.mainCollectionView reloadData];
}

- (NSMutableDictionary *)pageDatas {
    if (!_pageDatas) {
        _pageDatas = [[NSMutableDictionary alloc] init];
    }
    return _pageDatas;
}

- (NSMutableDictionary *)cacheDictionary {
    if (!_cacheDictionary) {
        _cacheDictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:TANGRAM_CACHE_KEY]];
    }
    return _cacheDictionary;
}

- (NSMutableArray *)pageModels {
    if (!_pageModels) {
        _pageModels = [[NSMutableArray alloc] init];
    }
    return _pageModels;
}

@end
