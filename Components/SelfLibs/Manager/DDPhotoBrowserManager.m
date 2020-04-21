//
//  DDPhotoBrowserManager.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDPhotoBrowserManager.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import <AVFoundation/AVFoundation.h>

@interface DDPhotoBrowserManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,QBImagePickerControllerDelegate>

@property (strong, nonatomic)UIImagePickerController * imagePicker;
@property (strong, nonatomic)QBImagePickerController *imagePickerController;
@property (copy, nonatomic)DDPhotoBrowserSingle singleBlock;
@property (copy, nonatomic)DDPhotoBrowserMutil mutilBlock;

@property (nonatomic,strong)NSArray<PHAsset *> *assetArray;
@property (nonatomic,strong)NSMutableArray<NSURL *> *imageURLArray;
@property (nonatomic,assign)NSInteger currentIndex;
@property (nonatomic,weak)UIViewController *vc;

@end

@implementation DDPhotoBrowserManager


+ (instancetype)manager:(UIViewController *)vc{
    id instance = [[self alloc] initWithViewController:vc];
    return instance;
}

- (instancetype)initWithViewController:(UIViewController *)vc{
    self = [super init];
    if (self) {
        self.vc = vc;
        [self cleanVarible];
    }
    return self;
}

-(void)dealloc{
    [self cleanVarible];
}

-(void)cleanVarible{
    //    _assetArray = nil;
    //    _imageURLArray = nil;
    //    _currentIndex = 0;
    _singleBlock = nil;
    _mutilBlock = nil;
    _imagePickerController = nil;
    _imagePicker = nil;
}

- (void) initImagePicker:(UIImagePickerControllerSourceType )type {
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = NO;
    _imagePicker.sourceType = type;
}

- (UIViewController *) topViewController {
//    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    return del.window.rootViewController;
    return self.vc;
}

/**
 拍照
 
 @param block 回调Block
 @return bool
 */
- (BOOL) takeCamera:(DDPhotoBrowserSingle)block {
    self.singleBlock = [block copy];
    UIViewController * rootCtl = [self topViewController];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker = nil;
        [self initImagePicker:UIImagePickerControllerSourceTypeCamera];
//        [AppDelegate sharedAppDelegate].orientation = DDUIDeviceOrientationPortrait;
        [rootCtl presentViewController:self.imagePicker animated:YES completion:nil];
        return YES;
    }else {
        return NO;
    }
}

/**
 第三方多选
 
 @param maxNum 最大图片数
 @param block 回调Block
 @return bool
 */
- (BOOL)takePhotoLibraryWithMaxNum:(int)maxNum
                             block:(DDPhotoBrowserMutil)block{
    self.mutilBlock = [block copy];
    UIViewController * rootCtl = [self topViewController];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        [self initQBImagePickerController:QBImagePickerMediaTypeImage maxNum:maxNum];
        [rootCtl presentViewController:self.imagePickerController animated:YES completion:nil];
        return YES;
    }else{
        return NO;
    }
}

/**
 选取相册单张
 
 @param block 回调Block
 @return bool
 */
- (BOOL)takePhotoLibrary:(DDPhotoBrowserSingle)block{
    self.singleBlock = [block copy];
    UIViewController * rootCtl = [self topViewController];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        self.imagePicker = nil;
        [self initImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
//        [AppDelegate sharedAppDelegate].orientation = DDUIDeviceOrientationPortrait;
        [rootCtl presentViewController:self.imagePicker animated:YES completion:nil];
        return YES;
    }else {
        return NO;
    }
}

/**
 *  初始化 第三方 相册图片选择器
 *
 *  @param type   选择类型
 *  @param maxNum 最大个数
 */
-(void)initQBImagePickerController:(QBImagePickerMediaType )type maxNum:(int)maxNum{
    QBImagePickerController *qbImagePickerController = [[QBImagePickerController alloc] init];
    _imagePickerController = qbImagePickerController;
    _imagePickerController.delegate = self;
    _imagePickerController.mediaType = type;
    _imagePickerController.allowsMultipleSelection = YES;
    _imagePickerController.showsNumberOfSelectedAssets = YES;
    _imagePickerController.maximumNumberOfSelection = maxNum;
}


#pragma mark - ......::::::: QBImagePickerControllerDelegate :::::::......
//选择完成
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assetArray{
    if (assetArray.count>0) {
        //
        _assetArray = assetArray;
        _imageURLArray = [[NSMutableArray<NSURL *> alloc] init];
        _currentIndex = 0;
        //
        @weakify(self);
        [DDProgressHUD showWindowLoading:@"图片获取中..."];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @strongify(self);
            [self getAssetImageArray:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.mutilBlock) {
                        self.mutilBlock(self.imageURLArray);
                        self.mutilBlock = nil;
                    }
                    self.assetArray = @[];
                    [DDProgressHUD dismissWindowLoading];
                    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        });
    }
}

-(void)getAssetImageArray:(DDNoParamsBlock)completeBlock{
    PHAsset *asset = [_assetArray objectAtIndex:_currentIndex];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.networkAccessAllowed = YES;
    options.synchronous = YES;
    @weakify(self);
    [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                      options:options
                                                resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                    @strongify(self);
                                                    self.currentIndex ++;
                                                    if(imageData != nil){
                                                        //设置图片
                                                        UIImage *resultImage = [UIImage imageWithData:imageData];
                                                        if (resultImage) {
                                                            if (UIImageOrientationUp != orientation) {
                                                                resultImage = [resultImage fixOrientations];
                                                            }
                                                            NSURL *url = [self storeCacheImage:resultImage];
                                                            resultImage = nil;
                                                            if (url) {
                                                                [self.imageURLArray addObject:url];
                                                            }
                                                        }
                                                    }
                                                    if (self.currentIndex == self.assetArray.count) {
                                                        if (completeBlock) {
                                                            completeBlock();
                                                        }
                                                    }else{
                                                        if (completeBlock) {
                                                            [self getAssetImageArray:[completeBlock copy]];
                                                        }
                                                    }
                                                    
                                                }];
}


//取消选择
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ......::::::: UIImagePickerController :::::::......
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //无权限时，直接返回
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    UIImage *image= [info objectForKey:UIImagePickerControllerOriginalImage];
    //重新更改相片相位
    UIImage *drawImage = [image fixOrientations];//drawContextImage
    NSURL *path = [self storeCacheImage:drawImage];
    //拍照之后传入
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (self.singleBlock){
        //直接回调
        self.singleBlock(path);
        self.singleBlock = nil;
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ......::::::: 图片文件缓存操作 :::::::......
/** 缓存图片，得到图片缓存地址 */
-(NSURL *)storeCacheImage:(UIImage *)image{
    NSData *imageData = image.imageDataCompress;
    if (imageData && imageData.length>0) {
        NSString *fileName = [NSString stringWithUUID];
        NSString *filePath = [[DDPathUtils imageCachePath] stringByAppendingPathComponent:fileName];
        NSString *urlPath = [NSString stringWithFormat:@"file://%@",filePath];
        NSURL *url = [NSURL URLWithString:urlPath];
        NSError *error = nil;
        BOOL isWrited = [imageData writeToURL:url options:NSDataWritingAtomic error:&error];
        if (error || !isWrited) {
            url = nil;
        }
        return url;
    }
    return nil;
}


@end



