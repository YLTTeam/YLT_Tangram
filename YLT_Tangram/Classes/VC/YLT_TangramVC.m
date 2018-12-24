//
//  YLT_TangramVC.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramVC.h"
#import "YLT_TangramCell.h"
#import "YLT_TangramVC+Delegate.h"

@interface YLT_TangramVC ()

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation YLT_TangramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
}

+ (YLT_TangramVC *)tangramWithPages:(NSArray<NSDictionary *> *)pages
                          withDatas:(NSMutableArray *)datas {
    YLT_TangramVC *result = [[YLT_TangramVC alloc] init];
    result.list = datas;
    [pages enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            Class cls = TangramView.class;
            if ([obj.allKeys containsObject:@"type"]) {
                Class tempCls = NSClassFromString([obj objectForKey:@"type"]);
                if (tempCls != NULL) {
                    cls = tempCls;
                }
            }
            TangramView *pageModel = [cls ylt_objectWithKeyValues:obj];
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

- (NSMutableArray *)pageModels {
    if (!_pageModels) {
        _pageModels = [[NSMutableArray alloc] init];
    }
    return _pageModels;
}

@end
