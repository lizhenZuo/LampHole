//
//  DDPhotoSelectUtils.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDPhotoSelectUtils.h"
#import "DDPhotoBrowserManager.h"


@interface DDPhotoSelectUtils()

@property (nonatomic,copy) DDPhotoSelectBlock selectedCompleteBlock;
@property (nonatomic,strong)DDPhotoBrowserManager *photoBrowserManager;
@property (nonatomic,assign)int maxPhotoNum;

@end

@implementation DDPhotoSelectUtils


+(instancetype)photoSelectFromVc:(UIViewController *)vc{
    return [[self.class alloc] initWithVC:vc];
}

- (instancetype)initWithVC:(UIViewController *)vc{
    self = [super init];
    if (self) {
        self.photoBrowserManager = [DDPhotoBrowserManager manager:vc];
    }
    return self;
}

-(void)dealloc{
    self.photoBrowserManager = nil;
    NSLog(@"DDPhotoSelectUtils -> dealloc");
}

/**
 获取单张照片
 
 @param selectedCompleteBlock 回调block
 */
-(void)showSingleImagePick:(DDPhotoSelectBlock)selectedCompleteBlock{
    self.selectedCompleteBlock = selectedCompleteBlock;
    self.maxPhotoNum = 1;
    [self showDialog];
    
}

/**
 获取用户指定个数照片（拍照只有一个）
 
 @param maxPhotoNum 选取图片个数
 @param selectedCompleteBlock 回调block
 */
-(void)showMutilImagePick:(int)maxPhotoNum selectedComplete:(DDPhotoSelectBlock)selectedCompleteBlock{
    self.selectedCompleteBlock = selectedCompleteBlock;
    self.maxPhotoNum = maxPhotoNum;
    [self showDialog];
}

static NSString *const kTextDialog_Camera = @"照相";
static NSString *const kTextDialog_Photo = @"从相册选取";

/**
 创建，并选择图片
 */
-(void)showDialog{
    @weakify(self);
    [[DDTextListDialog shareView:@[kTextDialog_Camera,kTextDialog_Photo]] showDialog:^(NSString *str, NSInteger idx) {
        @strongify(self);
        if ([str isEqualToString:kTextDialog_Camera]) {
            //照相
            [self takeCamera];
        }else if ([str isEqualToString:kTextDialog_Photo]) {
            //从相册选取
            [self takePhoto];
        }
    }];
}

/**
 拍照选图
 */
-(void)takeCamera{
    //[DDAnalyticManager track:DDEventId_Setting_UserInfo_Camera];
    //检查相机
    @weakify(self);
    DDPermissionManager *permissionManager = [DDPermissionManager sharePermissionManager];
    [permissionManager checkCameraPermission:^{
        @strongify(self);
        [self.photoBrowserManager takeCamera:^(NSURL *imageURL) {
            self.selectedCompleteBlock(@[imageURL]);
            
        }];
    } fail:^{
        [permissionManager showNoPermissionDialogWithTips:NSLocalizedString(@"tips_authorization_camera", @"")];
    }];
}



/**
 从相册选图
 */
-(void)takePhoto{
    //[DDAnalyticManager track:DDEventId_Setting_UserInfo_Library];
    //检查相册权限
    @weakify(self);
     DDPermissionManager *permissionManager = [DDPermissionManager sharePermissionManager];
    [permissionManager checkPhotoPermission:^{
        @strongify(self);
        //打开本地相册
        [self.photoBrowserManager takePhotoLibraryWithMaxNum:self.maxPhotoNum
                                                     block:^(NSArray<NSURL *> *imageURLArray) {
                                                         self.selectedCompleteBlock(imageURLArray);
                                                     }];
    } fail:^{
        [permissionManager showNoPermissionDialogWithTips:NSLocalizedString(@"tips_authorization_photo", @"")];
    }];
}

@end

