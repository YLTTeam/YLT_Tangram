//
//  YLT_TangramVC+Delegate.m
//  YLT_Tangram
//
//  Created by 项普华 on 2018/12/19.
//

#import "YLT_TangramVC+Delegate.h"

@implementation YLT_TangramVC (Delegate)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.pages.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id item = [self.pages objectAtIndex:section];
    if ([item isKindOfClass:[NSArray class]]) {
        return [(NSArray *)item count];
    }
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    id item = [self.pages objectAtIndex:indexPath.section];
    if ([item isKindOfClass:[NSArray class]]) {
        item = [(NSArray *)item objectAtIndex:indexPath.row];
    }
    TangramView *data = item;
    
    return cell;
}

@end
