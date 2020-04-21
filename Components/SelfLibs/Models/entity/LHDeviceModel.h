//
//  LHDeviceModel.h
//  LampHole
//
//  Created by dingdong on 2019/12/21.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "DDBaseModel.h"

typedef NS_ENUM(NSInteger, DEV_LIGHT_TYPE){
    DEV_LIGHT_TYPE_SINGLE_COLOR = 0, //单色
    DEV_LIGHT_TYPE_DOUBLE_COLOR = 1, //双色
    DEV_LIGHT_TYPE_RGBW = 2, //rgbw
    DEV_LIGHT_TYPE_RGBCW = 3, //rgbcw
};

NS_ASSUME_NONNULL_BEGIN

@interface LHDeviceModel : DDBaseModel

@property (nonatomic, strong) NSString *device_id; //设备ID
@property (nonatomic, strong) NSString *device_name; //设备名称
@property (nonatomic, strong) NSString *device_icon; //图片icon
@property (nonatomic, assign) DEV_LIGHT_TYPE lightType; //灯的设置类型
@property (nonatomic, strong) NSString *device_version; //版本
@property (nonatomic, strong) NSString *device_serial_number; //序列号

@end

NS_ASSUME_NONNULL_END
