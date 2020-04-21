//
//  LHBlueToothManager.m
//  LampHole
//
//  Created by dingdong on 2019/12/21.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHBlueToothManager.h"
#import "BabyBluetooth.h"

@interface LHBlueToothManager()

@property (nonatomic, strong) BabyBluetooth *blueTooth;

@property (strong, nonatomic) NSMutableArray<LHDeviceModel *> *arrayDev;

@end

@implementation LHBlueToothManager

+ (instancetype)shareInstance{
    static id _this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[self.class alloc] init];
        [_this initData];
    });
    return _this;
}

//初始化数据
- (void)initData
{
    self.arrayDev = [[NSMutableArray alloc] init];
}

- (void)initBlueTooth
{
    //初始化BabyBluetooth 蓝牙库
    self.blueTooth = [BabyBluetooth shareBabyBluetooth];
}

//设置蓝牙委托
-(void)babyDelegate{

    //设置扫描到设备的委托
    [self.blueTooth setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
    }];
   
    //过滤器
    //设置查找设备的过滤器
    [self.blueTooth setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备 most common usage is discover for peripheral that name has common prefix
        //if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //    return YES;
        //}
        //return NO;
        //设置查找规则是名称大于1 ， the search rule is peripheral.name length > 1
        if (peripheralName.length >1) {
            return YES;
        }
        return NO;
    }];
}

- (void)startScanDev
{
    //设置蓝牙委托
    [self babyDelegate];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态
    self.blueTooth.scanForPeripherals().begin();
}

//获取当前所有的蓝牙灯具
- (NSArray <LHDeviceModel *> *)scanAllDev
{
    return self.arrayDev;
}

//操作指令
- (void)setDeviceAction:(LHDevActiveProtocol *)activeProtocol
{
    
}

- (NSArray<LHDeviceModel *> *)deleteDevice:(LHDeviceModel *)devModel
{
    for (LHDeviceModel *model in self.arrayDev)
    {
        if ([model.device_id isEqualToString:devModel.device_id]) {
            //删除
            [self.arrayDev removeObject:devModel];
            break;
        }
    }
    
    return self.arrayDev;
}

@end
