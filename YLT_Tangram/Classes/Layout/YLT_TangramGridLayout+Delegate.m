//
//  YLT_TangramGridLayout+Delegate.m
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import "YLT_TangramGridLayout+Delegate.h"
#import "YLT_TangramCell.h"
#import "YLT_TangramUtils.h"

@interface YLT_TangramGridLayout (Data)

@property (nonatomic, strong, readonly) NSArray *list;

@end

@implementation YLT_TangramGridLayout (Data)

- (NSArray *)list {
    if (!self.pageData) {
        return @[];
    }
    NSArray *result = @[];
    result = [YLT_TangramUtils valueFromSourceData:self.pageData keyPath:@""];
    if (![result isKindOfClass:[NSArray class]]) {
        result = @[result];
    }
    return result;
}

@end

@implementation YLT_TangramGridLayout (Delegate)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YLT_TangramCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:((TangramGridLayout *)self.pageModel).ylt_identify forIndexPath:indexPath];
    id item = self.list[indexPath.row];
    [cell reloadCellData:item];
    return cell;
}

@end
