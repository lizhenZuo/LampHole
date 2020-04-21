//
//  DDPermissionManager.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDPermissionManager.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreTelephony/CTCellularData.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
//#import <CoreLocation/CoreLocation.h>
// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

typedef void(^DDPermissionHandlerBlock)(BOOL granted);

@interface DDPermissionManager()<CLLocationManagerDelegate,UNUserNotificationCenterDelegate>

@property (nonatomic, strong) CTCellularData *cellularData;
@property (nonatomic, strong) NSMutableArray<YYWeakProxy<DDPermissionManagerNetDelegate> *> *netPermissionArray;
@end

@implementation DDPermissionManager{
    DDPermissionHandlerBlock _locationCompletionHandler;
}


+ (instancetype)sharePermissionManager{
    static id _sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.netPermissionArray =  [NSMutableArray<YYWeakProxy<DDPermissionManagerNetDelegate> *> array];
    }
    return self;
}

-(void)dealloc{
    NSLog(@"DDPermissionManager -> dealloc");
}

+(BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

/**
 检查麦克风权限

 @param successBlock 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkMicrophonePermission:(DDPermissBlock)successBlock fail:(DDPermissBlock)failBlock{
    AVAuthorizationStatus status = [self getMicrophonePermission];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            @weakify(self);
            [self requestMicrophonePermission:^(BOOL granted) {
                @strongify(self);
                if(granted){
                    [self handleSuccesHandler:successBlock];
                }else{
                    [self handleFailBlock:failBlock];
                }
            }];
            break;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:{
            [self handleFailBlock:failBlock];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
           [self handleSuccesHandler:successBlock];
            break;
        }
            
        default:
            break;
    }
    return self;
}


/**
 检查相机权限

 @param successBlock 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkCameraPermission:(DDPermissBlock)successBlock fail:(DDPermissBlock)failBlock{
    AVAuthorizationStatus status = [self getCameraPermission];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            @weakify(self);
            [self requestCameraPermission:^(BOOL granted) {
                @strongify(self);
                if(granted && [self.class isCameraAvailable]){
                    [self handleSuccesHandler:successBlock];
                }else{
                    [self handleFailBlock:failBlock];
                }
            }];
            break;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:{
            [self handleFailBlock:failBlock];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            [self handleSuccesHandler:successBlock];
            break;
        }
            
        default:
            break;
    }
    return self;
}


/**
 检查相册权限

 @param successBlock 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkPhotoPermission:(DDPermissBlock)successBlock fail:(DDPermissBlock)failBlock{
    
    PHAuthorizationStatus status = [self getPhotoPermission];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            @weakify(self);
            [self requestPhotoPermission:^(BOOL granted) {
                @strongify(self);
                if(granted){
                    [self handleSuccesHandler:successBlock];
                }else{
                    [self handleFailBlock:failBlock];
                }
            }];
            break;
        }
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:{
            [self handleFailBlock:failBlock];
            break;
        }
        case PHAuthorizationStatusAuthorized:{
            [self handleSuccesHandler:successBlock];
            
            break;
        }
            
        default:
            break;
    }
    return self;
}


///**
// 检查联系人权限
//
// @param successBlock 成功回调
// @param failBlock 失败回调
// @return 对象
// */
//-(instancetype)checkContactPermission:(DDPermissBlock)successBlock fail:(DDPermissBlock)failBlock{
//    @weakify(self);
//    ABAuthorizationStatus status = [self getContactPermission];
//    switch (status) {
//        case kABAuthorizationStatusNotDetermined:{
//            [self requestContactPermission:^(BOOL granted) {
//                if(granted){
//                   [self handleSuccesHandler:successBlock];
//                }else{
//                    [self handleFailBlock:failBlock];
//                  }
//            }];
//            break;
//        }
//        case kABAuthorizationStatusRestricted:
//        case kABAuthorizationStatusDenied:{
//            [self handleFailBlock:failBlock];
//            break;
//        }
//        case kABAuthorizationStatusAuthorized:{
//            [self handleSuccesHandler:successBlock];
//
//            break;
//        }
//
//        default:
//            break;
//    }
//    return self;
//}

///**
// 获取联系人权限
//
// @param completionHandler 回调
// */
//-(void)requestContactPermission:(DDPermissionHandlerBlock)completionHandler{
//    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
//    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//        if (granted) {
//            DDKTLogVerbose(@"Authorized");
//            CFRelease(addressBook);
//            completionHandler(YES);
//        }else{
//            DDKTLogVerbose(@"Denied or Restricted");
//            completionHandler(NO);
//        }
//    });
//}

/**
 检查定位权限
 
 @param successBlock 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkLocationPermission:(DDPermissBlock)successBlock fail:(DDPermissBlock)failBlock{
    CLAuthorizationStatus status = [self getLocationPermission];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            [self handleSuccesHandler:successBlock];
            break;
        }
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:{
             [self handleFailBlock:failBlock];
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            [self handleSuccesHandler:successBlock];
            
            break;
        }
            
        default:
            break;
    }
    return self;
}


/**
 检查通知权限
 
 @param successBlock 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkNotificationPermission:(DDPermissBlock)successBlock fail:(DDPermissBlock)failBlock{
    if ([[UIDevice currentDevice].systemVersion floatValue] > 10.0) {
        if (@available(iOS 10.0, *)) {
            UNAuthorizationOptions status = (UNAuthorizationOptions)[self getNotificationPermission];
            if(UNAuthorizationOptionNone == status){
                [self handleFailBlock:failBlock];
            }else{
                [self handleSuccesHandler:successBlock];
            }
        }
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType status = [self getNotificationPermission];
        if(UIUserNotificationTypeNone == status){
            [self handleFailBlock:failBlock];
        }else{
            [self handleSuccesHandler:successBlock];
        }
    }
    return self;
}

/**
 获取麦克风权限当前状态
 */
-(AVAuthorizationStatus)getMicrophonePermission{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
}

/**
 获取相机权限当前状态
 */
-(AVAuthorizationStatus)getCameraPermission{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
}

/**
 获取相册权限当前状态
 */
-(PHAuthorizationStatus)getPhotoPermission{
    return  [PHPhotoLibrary authorizationStatus];
}


/**
 获取定位权限当前状态
 */
-(CLAuthorizationStatus)getLocationPermission{
    return [CLLocationManager authorizationStatus];
}


/**
 获取当前通知权限的装填
 */
-(UIUserNotificationType)getNotificationPermission{
    return [[UIApplication sharedApplication] currentUserNotificationSettings].types;
}

///**
// 获取通讯录权限
// */
//-(ABAuthorizationStatus)getContactPermission{
//    return ABAddressBookGetAuthorizationStatus();
//}


#pragma -mark 获取系统权限


/**
 获取麦克风权限
 
 @param completionHandler 回调
 */
-(void)requestMicrophonePermission:(DDPermissionHandlerBlock)completionHandler{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:completionHandler];
}



/**
 获取相机权限
 
 @param completionHandler 回调
 */
-(void)requestCameraPermission:(DDPermissionHandlerBlock)completionHandler{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:completionHandler];
}



/**
 获取相册权限
 
 @param completionHandler 回调
 */
-(void)requestPhotoPermission:(DDPermissionHandlerBlock)completionHandler{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            completionHandler(YES);
        }else{
            completionHandler(NO);
        }
    }];
}



/**
 获取位置权限
 */
-(void)requestLocationPermission:(DDPermissionHandlerBlock)completionHandler{
    _locationCompletionHandler = completionHandler;
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    [manager requestAlwaysAuthorization];//使用的时候获取定位信息
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Authorized");
            _locationCompletionHandler(YES);
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"AuthorizedWhenInUse");
            _locationCompletionHandler(YES);
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            _locationCompletionHandler(NO);
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            _locationCompletionHandler(NO);
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            _locationCompletionHandler(NO);
            break;
        default:
            break;
    }
}

/**
 失败回调（统一封装）
 
 @param failBlock 失败回调
 */
-(void)handleFailBlock:(DDPermissBlock)failBlock{
    dispatch_sync_on_main_queue(^{
        if (failBlock) {
            failBlock();
        }
    });
}

/**
 权限获取成功响应（统一封装）
 
 @param successBlock 成功回调
 */
-(void)handleSuccesHandler:(DDPermissBlock)successBlock{
    dispatch_sync_on_main_queue(^{
        if(successBlock){
            successBlock();
        }
    });
}

/**
 显示权限对话框

 @param tips 提示内容
 */
-(void)showNoPermissionDialogWithTips:(NSString *)tips{
    [self showNoPermissionDialogWithTitle:@"提示" tips:tips leftTips:@"取消" rightTips:@"设置" cancel:nil];
}


/**
 显示权限对话框

 @param title 标题
 @param tips 提示内容
 @param leftTips 左按钮字段
 @param rightTips 右按钮字段
 @param cancelBlock 取消按钮点击回调
 */
-(void)showNoPermissionDialogWithTitle:(NSString *)title tips:(NSString *)tips leftTips:(NSString *)leftTips rightTips:(NSString *)rightTips cancel:( void(^ _Nullable)(void))cancelBlock{
    @weakify(self);
    [self showNoPermissionDialogWithTitle:title
                                     tips:tips
                                 leftTips:leftTips
                                rightTips:rightTips
                                  confirm:^{
                                      @strongify(self);
                                      [self.class openPermissionSetting];
                                  } cancel:cancelBlock];
}

/**
 显示权限对话框
 
 @param title 标题
 @param tips 提示内容
 @param leftTips 左按钮字段
 @param rightTips 右按钮字段
 @param confirmBlock 确认按钮点击回调
 @param cancelBlock 取消按钮点击回调
 */
-(void)showNoPermissionDialogWithTitle:(NSString *)title
                                  tips:(NSString *)tips
                              leftTips:(NSString *)leftTips
                             rightTips:(NSString *)rightTips
                               confirm:( void(^ _Nullable)(void))confirmBlock
                                cancel:( void(^ _Nullable)(void))cancelBlock{
//    DDOKCancelDialog *dialog = [DDOKCancelDialog alertWithTitle:title
//                                                       subTitle:tips
//                                                     leftlTitle:leftTips
//                                                    rightlTitle:rightTips];
//    [dialog showDialog:^{
//        if (confirmBlock) {
//            confirmBlock();
//        }
//    } leftBlock:^{
//        if (cancelBlock) {
//            cancelBlock();
//        }
//    }];
}
/**
 打开系统设置
 @return 能否打开
 */
+(BOOL)openPermissionSetting{
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end

