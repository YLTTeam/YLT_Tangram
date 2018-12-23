//
//  YLT_TangramGridLayout.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramGridLayout.h"
#import "YLT_TangramManager.h"
#import "YLT_TangramCell.h"

@interface YLT_TangramGridLayout ()<UICollectionViewDelegate, UICollectionViewDataSource> {
}
@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation YLT_TangramGridLayout

- (void)refreshPage {
    if ([self.pageModel isMemberOfClass:[TangramGridLayout class]]) {
        [self.mainCollectionView registerClass:[YLT_TangramCell class] forCellWithReuseIdentifier:self.pageModel.ylt_identify];
        [self.mainCollectionView reloadData];
    }
}

- (UICollectionView *)mainCollectionView {
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(120, 120);
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = UIColor.clearColor;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        [self addSubview:_mainCollectionView];
        [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _mainCollectionView;
}

@end
