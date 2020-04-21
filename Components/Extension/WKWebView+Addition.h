//
//  WKWebView+Addition.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/28.
//  Copyright © 2019 ddkt365. All rights reserved.
//
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (Addition)

/// 设置UserAgent,如果保存了，则直接使用
-(void)dd_setCustomUserAgent;

@end

NS_ASSUME_NONNULL_END
