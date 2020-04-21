//  所有图片网络加载
//  DDImageLoader.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/31.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DDImageLoaderSuccessBlk)(UIImage *image);

@interface DDImageLoader : NSObject


+ (instancetype)sharedInstance;


/**
 加载图片
 
 @param url 图片地址
 @param imageView 显示图片的控件
 @param phImageName 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
            phImageName:(NSString *)phImageName;

/**
 加载图片
 
 @param url 图片地址
 @param imageView 显示图片的控件
 @param phdImage 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
                phImage:(UIImage *)phdImage;

/**
 加载图片
 @param url 图片地址
 @param imageView 显示图片的控件
 @param placeholderName  默认图片名称
 @param successBlk 成功回调
 @param errorBlk 错误回调
 */
-(void)loadImageWithURL:(NSString *)url
              imageView:(UIImageView *)imageView
            phImageName:(NSString *)placeholderName
                success:(DDImageLoaderSuccessBlk)successBlk
                  error:(DDNoParamsBlock)errorBlk;

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
                  error:(DDNoParamsBlock)errorBlk;

/**
 加载图片
 
 @param url 图片地址
 @param button 显示图片的控件
 @param phImageName 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
                 button:(UIButton *)button
            phImageName:(NSString *)phImageName;

/**
 加载图片
 
 @param url 图片地址
 @param button 显示图片的控件
 @param phdImage 默认图片
 */
-(void)loadImageWithURL:(NSString *)url
                 button:(UIButton *)button
                phImage:(UIImage *)phdImage;

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
                  error:(DDNoParamsBlock)errorBlk;

/**
 加载本地图片(gif,png,jpg本地路径图片)
 @param resName 资源名称
 @param imageView 显示图形
 */
-(void)loadImageResourceName:(NSString *)resName
                   imageView:(UIImageView *)imageView;

/**
 加载本地图片(gif,png,jpg本地路径图片)
 @param resName 资源名称
 @param button 显示图形
 */
-(void)loadImageResourceName:(NSString *)resName
                      button:(UIButton *)button;

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
                  error:(DDNoParamsBlock)errorBlk;

/**
 下载图片
 @param urlString 下载地址
 @param successBlk 成功回调
 @param failBlk 失败回调
 */
-(void)downloadWithURL:(NSString *)urlString
               success:(DDImageLoaderSuccessBlk)successBlk
                  fail:(DDNoParamsBlock)failBlk;
/**
 清除某个图片缓存
 
 @param key 链接地址
 */
-(void)removeImageForKey:(NSString *)key;

/**
 清除某个图片缓存列表
 
 @param keys 需要清除的列表
 @param completeBlock   回调
 */
-(void)removeImagesForKeys:(NSArray<NSString *> *)keys completeBlock:(DDNoParamsBlock)completeBlock;

/**
 清除所有缓存
 */
+(void)clearMemory;

/**
 清除所有图片缓存
 */
+(void)cleanDisk;
@end


