//
//  LPSettingTableViewCell.h
//  LampHole
//
//  Created by dingdong on 2019/12/26.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) LHUserModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
