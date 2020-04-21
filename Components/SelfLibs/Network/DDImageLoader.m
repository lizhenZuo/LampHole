//
//  DDImageLoader.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/31.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDImageLoader.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/SDWebImage.h>

@implementation DDImageLoader

+ (instancetype)sharedInstance{
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


/**
 加载图片
 
 @param url 图片地址
 @param imageView 显示图片的控件
 @param phImageName 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
            phImageName:(NSString *)phImageName{
    UIImage *phdImage = nil;
    if (phImageName && phImageName.length>0) {
        phdImage = [UIImage imageNamed:phImageName];
    }
    [self loadImageWithURL:url imageView:imageView phImage:phdImage];
}

/**
 加载图片
 
 @param url 图片地址
 @param imageView 显示图片的控件
 @param phdImage 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
                phImage:(UIImage *)phdImage{
    [self loadImageWithURL:url imageView:imageView phImage:phdImage success:nil error:nil];
}

/**
 加载图片
 @param url 图片地址
 @param imageView 显示图片的控件
 @param phImageName  默认图片名称
 @param successBlk 成功回调
 @param errorBlk 错误回调
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
            phImageName:(NSString *)phImageName
                success:(DDImageLoaderSuccessBlk)successBlk
                  error:(DDNoParamsBlock)errorBlk{
    UIImage *phdImage = nil;
    if (phImageName && phImageName.length>0) {
        phdImage = [UIImage imageNamed:phImageName];
    }
    [self loadImageWithURL:url imageView:imageView phImage:phdImage success:successBlk error:errorBlk];
}

/**
 加载图片
 
 @param url 图片地址
 @param imageView 显示图片的控件
 @param phdImage  默认图片
 @param successBlk 成功回调
 @param errorBlk 错误回调
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
                phImage:(UIImage *)phdImage
                success:(DDImageLoaderSuccessBlk)successBlk
                  error:(DDNoParamsBlock)errorBlk{
    
    NSAssert(imageView != nil, @"imageView不能为nil...");
    NSURL *imageURL = [NSURL URLWithString:url];
    if (imageView == nil || imageURL == nil) {
        if (phdImage != nil) {
            [imageView setImage:phdImage];
            if (errorBlk) {
                errorBlk();
            }
        }
        return;
    }
    SDWebImageOptions options = SDWebImageRetryFailed;
    @weakify(imageView);
    @weakify(self);
    [imageView sd_setImageWithURL:imageURL
                 placeholderImage:phdImage
                          options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                              @strongify(imageView);
                              @strongify(self);
                              if (error || image==nil) {
                                  if (errorBlk) {
                                      errorBlk();
                                  }
                              }else{
                                  if (successBlk) {
                                      successBlk(image);
                                  }
                                  //防止上滑出现交替动画
                                  if (cacheType != SDImageCacheTypeMemory) {
                                      [self showAnimation:imageView];
                                  }
                              }
                          }];
    
}

/**
 显示动画
 @param imageView UIImageView
 */
-(void)showAnimation:(UIImageView *)imageView{
    @weakify(imageView);
    imageView.alpha = 0.7;
    [UIView transitionWithView:imageView
                      duration:0.1f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        @strongify(imageView);
                        imageView.alpha = 1.0;
                    } completion:nil];
}

/**
 加载图片
 
 @param url 图片地址
 @param button 显示图片的控件
 @param phImageName 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
                 button:(UIButton *)button
            phImageName:(NSString *)phImageName{
    UIImage *phdImage = nil;
    if (phImageName && phImageName.length>0) {
        phdImage = [UIImage imageNamed:phImageName];
    }
    [self loadImageWithURL:url button:button phImage:phdImage success:nil error:nil];
}

/**
 加载图片
 
 @param url 图片地址
 @param button 显示图片的控件
 @param phdImage 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
                 button:(UIButton *)button
                phImage:(UIImage *)phdImage{
    [self loadImageWithURL:url button:button phImage:phdImage success:nil error:nil];
}


/**
 加载图片
 @param url 图片地址
 @param button 显示图片的控件
 @param phImageName 默认图片
 @param successBlk 成功回调
 @param errorBlk 错误回调
 */
-(void)loadImageWithURL:(NSString *)url
                 button:(UIButton *)button
            phImageName:(NSString *)phImageName
                success:(DDImageLoaderSuccessBlk)successBlk
                  error:(DDNoParamsBlock)errorBlk{
    UIImage *phdImage = nil;
    if (phImageName && phImageName.length>0) {
        phdImage = [UIImage imageNamed:phImageName];
    }
    [self loadImageWithURL:url button:button phImage:phdImage success:successBlk error:errorBlk];
}

/**
 加载本地图片(gif,png,jpg本地路径图片)
 @param resName 资源名称
 @param imageView 显示图形
 */
-(void)loadImageResourceName:(NSString *)resName
                   imageView:(UIImageView *)imageView{
    NSURL *url = [[NSBundle mainBundle] URLForResource:resName withExtension:nil];
    if (url) {
        NSString *path = url.absoluteString;
        [self loadImageWithURL:path imageView:imageView phImageName:nil];
    }
}

/**
 加载本地图片(gif,png,jpg本地路径图片)
 @param resName 资源名称
 @param button 显示图形
 */
-(void)loadImageResourceName:(NSString *)resName
                      button:(UIButton *)button{
    NSURL *url = [[NSBundle mainBundle] URLForResource:resName withExtension:nil];
    if (url) {
        NSString *path = url.absoluteString;
        [self loadImageWithURL:path button:button phImageName:nil];
    }
}

/**
 加载图片
 @param url 图片地址
 @param button 显示图片的控件
 @param phdImage 默认图片
 @param successBlk 成功回调
 @param errorBlk 错误回调
 */
-(void)loadImageWithURL:(NSString *)url
                 button:(UIButton *)button
                phImage:(UIImage *)phdImage
                success:(DDImageLoaderSuccessBlk)successBlk
                  error:(DDNoParamsBlock)errorBlk{
    NSAssert(button != nil, @"imageView不能为nil...");
    NSURL *imageURL = [NSURL URLWithString:url];
    if (button == nil || imageURL == nil) {
        if (phdImage != nil) {
            [button setImage:phdImage forState:UIControlStateNormal];
            if (errorBlk) {
                errorBlk();
            }
        }
        return;
    }
    SDWebImageOptions options= SDWebImageRetryFailed;
    [button sd_setImageWithURL:imageURL
                      forState:UIControlStateNormal
              placeholderImage:phdImage
                       options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                           if (error || image==nil) {
                               if (errorBlk) {
                                   errorBlk();
                               }
                           }else{
                               if (successBlk) {
                                   successBlk(image);
                               }
                           }
                       }];
}



/**
 下载图片
 @param urlString 下载地址
 @param successBlk 成功回调
 @param failBlk 失败回调
 */
-(void)downloadWithURL:(NSString *)urlString success:(DDImageLoaderSuccessBlk)successBlk fail:(DDNoParamsBlock)failBlk{
    NSURL *url = [NSURL URLWithString:urlString];
    [[SDWebImageManager sharedManager].imageLoader requestImageWithURL:url
                                                               options:SDWebImageHighPriority|SDWebImageRetryFailed
                                                               context:nil
                                                              progress:nil
                                                             completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                                                                 if (error || image==nil) {
                                                                     if (failBlk) {
                                                                         failBlk();
                                                                     }
                                                                 }else{
                                                                     if (successBlk) {
                                                                         successBlk(image);
                                                                     }
                                                                 }
                                                             }];
}

/**
 清除某个图片缓存
 
 @param key 链接地址
 */
-(void)removeImageForKey:(NSString *)key{
    [[SDWebImageManager sharedManager].imageCache removeImageForKey:key cacheType:SDImageCacheTypeAll completion:nil];
}

/**
 清除某个图片缓存列表
 
 @param keys 需要清除的列表
 @param completeBlock   回调
 */
-(void)removeImagesForKeys:(NSArray<NSString *> *)keys completeBlock:(DDNoParamsBlock)completeBlock{
    if (keys==nil && keys.count==0) {
        if (completeBlock) {
            completeBlock();
        }
        return;
    }
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        //
        for (NSString *key in keys.objectEnumerator) {
            [self removeImageForKey:key];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    });
}

/**
 清除所有缓存
 */
+(void)clearMemory{
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeMemory completion:^{
        NSLog(@"内存图片清除成功");
    }];
}

/**
 清除所有图片缓存
 */
+(void)cleanDisk{
    [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeDisk completion:^{
        NSLog(@"磁盘图片清除成功");
    }];
}

@end


