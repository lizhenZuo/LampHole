//
//  DDTextListDialogTableViewCell.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/21.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDTextListDialogTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight:(NSString *)model;
/** 是否为最后一个 */
@property (nonatomic,assign)BOOL isLast;

@property (nonatomic,strong)NSString *model;

@end

NS_ASSUME_NONNULL_END
