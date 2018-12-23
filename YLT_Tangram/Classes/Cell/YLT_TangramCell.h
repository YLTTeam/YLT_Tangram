//
//  YLT_TangramCell.h
//  AFNetworking
//
//  Created by 项普华 on 2018/12/20.
//

#import <UIKit/UIKit.h>
#import "TangramModel.h"

@interface YLT_TangramCell : UICollectionViewCell

- (void)cellFromConfig:(TangramView *)config;

- (void)reloadCellData:(id)data;

@end
