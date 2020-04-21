//
//  DDBaseTableViewTableViewCell.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/17.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDBaseTableViewCellClassDelegate <NSObject>

/// 注册
/// @param tableView UITableView
+ (void)registerNibForTableView:(UITableView *)tableView;

/// 从缓存中获取
/// @param tableView UITableView
/// @param indexPath forIndexPath
+ (instancetype)cellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath;

/// 获取cell的计算高度
/// @param model NSObject
+(CGFloat)cellHeight:(id)model;

@end


@interface DDBaseTableViewCell : UITableViewCell<DDBaseTableViewCellClassDelegate>


@end

NS_ASSUME_NONNULL_END
