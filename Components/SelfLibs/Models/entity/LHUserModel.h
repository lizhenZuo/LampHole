//
//  LHUserModel.h
//  LampHole
//
//  Created by dingdong on 2019/12/29.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHUserModel : DDBaseModel

@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *user_id; //使用时间戳生成
@property (nonatomic, assign) BOOL loginDBFlag;
@property (nonatomic, assign) BOOL isLogin;

@end

NS_ASSUME_NONNULL_END
