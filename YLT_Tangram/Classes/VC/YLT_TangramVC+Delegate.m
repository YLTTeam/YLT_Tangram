//
//  YLT_TangramVC+Delegate.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramVC+Delegate.h"
#import "YLT_TangramCell.h"

@implementation YLT_TangramVC (Delegate)

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TangramView *item = [self.pageModels objectAtIndex:indexPath.section];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        NSInteger column = ((TangramGridLayout *) item).column;
        column = (column == 0)?1:column;
        CGSize size = CGSizeZero;
        size.width = (YLT_SCREEN_WIDTH-item.ylt_layoutMagin.left-item.ylt_layoutMagin.right-item.ylt_padding.left-item.ylt_padding.right);
        size.width = (size.width-(column-1)*((TangramGridLayout *)item).itemHorizontalMargin)/column;
        size.height = ((TangramGridLayout *)item).itemHeight;
        size.height = (size.height == 0) ? size.width:size.height;
        return size;
    }
    
    return CGSizeMake(item.layoutWidth.floatValue, item.layoutHeight.floatValue);
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
        if ([layout.dataTag isKindOfClass:[NSArray class]]) {
            return ((NSArray *) layout.dataTag).count;
        }
        //根据页面动态的数据来返回
        return 4;
    }
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TangramView *item = [self.pageModels objectAtIndex:indexPath.section];
    YLT_TangramCell *cell = (YLT_TangramCell *)[collectionView dequeueReusableCellWithReuseIdentifier:item.ylt_identify forIndexPath:indexPath];
    if ([item isKindOfClass:[TangramGridLayout class]]) {
        TangramGridLayout *layout = (TangramGridLayout *)item;
        item = layout.itemName;
    }
    [cell cellFromConfig:item];
    
    return cell;
}

@end
