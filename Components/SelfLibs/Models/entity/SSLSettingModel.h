//
//  SSLSettingModel.h
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSLSettingModel : DDBaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, assign) BOOL isCanEdit;

@end

NS_ASSUME_NONNULL_END
