//
//  DDPMeLandscapeCollectionViewCell.m
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/10/16.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDPMeLandscapeCollectionViewCell.h"

@interface DDPMeLandscapeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@end

@implementation DDPMeLandscapeCollectionViewCell

static NSString * const cellIdentifier  = @"DDPMeLandscapeCollectionViewCell";

+ (void)registerNibForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[self nibName] bundle:nil]
     forCellWithReuseIdentifier:cellIdentifier];
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:[self nibName] owner:self options:nil] firstObject];
    }
    return cell;
}

-(void)setModel:(LHSceneModel *)model
{
    [self.lblName setText:model.sceneName];
    if (![NSString isEmptyOrNull:model.iconScene]) {
        [self.icon setImage:[UIImage imageNamed:model.iconScene]];
    }else{
        [self.icon setImage:[UIImage imageNamed:@"icon_scene_default"]];
    }
}


- (void)setGroupModel:(LHGroupModel *)groupModel
{
    [self.lblName setText:groupModel.groupName];
}

@end
