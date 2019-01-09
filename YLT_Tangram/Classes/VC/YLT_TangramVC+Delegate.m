//
//  YLT_TangramVC+Delegate.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramVC+Delegate.h"
#import "YLT_TangramCell.h"
#import "YLT_TangramUtils.h"

@implementation YLT_TangramVC (Delegate)

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    TangramView *item = [self.pageModels objectAtIndex:section];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        return UIEdgeInsetsMake(item.ylt_layoutMagin.top, item.ylt_layoutMagin.left, item.ylt_layoutMagin.bottom, item.ylt_layoutMagin.right);
    }
    return UIEdgeInsetsZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TangramView *item = [self.pageModels objectAtIndex:indexPath.section];
    return [YLT_TangramUtils tangramSizePageModel:item];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    TangramView *item = [self.pageModels objectAtIndex:section];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        return ((TangramGridLayout *)item).itemVerticalMargin;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    TangramView *item = [self.pageModels objectAtIndex:section];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        return ((TangramGridLayout *)item).itemHorizontalMargin;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.pageModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TangramView *item = [self.pageModels objectAtIndex:section];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        TangramGridLayout *layout = (TangramGridLayout *)item;
        NSArray *list = [YLT_TangramUtils valueFromSourceData:self.pageDatas keyPath:layout.dataTag];
        if ([list isKindOfClass:[NSArray class]]) {
            return list.count;
        }
        //根据页面动态的数据来返回
        return 0;
    }
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TangramView *item = [self.pageModels objectAtIndex:indexPath.section];
    NSDictionary *pageData = self.pageDatas;
    YLT_TangramCell *cell = (YLT_TangramCell *)[collectionView dequeueReusableCellWithReuseIdentifier:item.ylt_identify forIndexPath:indexPath];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        TangramGridLayout *layout = (TangramGridLayout *)item;
        item = [YLT_TangramUtils typeFromItemname:layout.itemName];
        NSArray *list = [YLT_TangramUtils valueFromSourceData:self.pageDatas keyPath:layout.dataTag];
        if ([list isKindOfClass:[NSArray class]]) {
            pageData = list[indexPath.row];
        }
    } 
    [cell cellFromConfig:item];
    if (pageData && pageData.allKeys.count > 0) {
        [cell reloadCellData:pageData];
    }
    return cell;
}

@end
