//
//  DDPMeLandscapeCollectionViewCell.h
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/10/16.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHSceneModel.h"
#import "LHGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPMeLandscapeCollectionViewCell : UICollectionViewCell

+ (void)registerNibForCollectionView:(UICollectionView *)collectionView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) LHSceneModel *model;

@property (nonatomic, strong) LHGroupModel *groupModel;

@end

NS_ASSUME_NONNULL_END
