//
//  LHBlueToothManager.h
//  LampHole
//
//  Created by dingdong on 2019/12/21.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHDeviceModel.h"
#import "LHDevActiveProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHBlueToothManager : NSObject

+ (instancetype)shareInstance;

//获取当前所有的蓝牙灯具
- (NSArray <LHDeviceModel *> *)scanAllDev;

//操作指令
- (void)setDeviceAction:(LHDevActiveProtocol *)activeProtocol;

//删除当前列表的某个设备
- (NSArray *)deleteDevice:(LHDeviceModel *)devModel;

@end

NS_ASSUME_NONNULL_END
