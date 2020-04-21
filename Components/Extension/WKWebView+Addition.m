//
//  WKWebView+Addition.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/28.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "WKWebView+Addition.h"

@implementation WKWebView (Addition)

CGFloat const DDWebViewRequstTimeOut = 60.f;
static NSString *const kDDCompanyFirstDomain = @"ddkt365.com";
static NSString *const kDDSchemePrefix = @"ea";

/// 设置UserAgent,如果保存了，则直接使用
-(void)dd_setCustomUserAgent{
    NSString *jsMethodStr = @"navigator.userAgent";
    //保存的key
    NSString *keyUserAgent = [NSString stringWithFormat:@"%@-%@",jsMethodStr,kAppReleaseVersionBuilder];
    //保存的agent
    NSString *storeUserAgent = [[NSUserDefaults standardUserDefaults] stringForKey:keyUserAgent];
    if (storeUserAgent.length > 0) {
        //设置UserAgent
        self.customUserAgent = storeUserAgent;
    }else{
        @weakify(self);
        [self evaluateJavaScript:jsMethodStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            @strongify(self);
            //1）获取默认userAgent：
            NSString *systemUserAgent = result;
            //v2.2.6 userAgent 设备类型  1、iPhone 2、iPad 3、Android Phone 4、Android Pad
            NSString *customAgent = [NSString stringWithFormat:@"ddkt365(ap/%@/%@)",DDisiPad?@"2":@"1",kAppReleaseVersionBuilder];
            //生成新的UserAgent
            NSString *customUserAgent = [NSString stringWithFormat:@"%@ %@",systemUserAgent,customAgent];
            //设置UserAgent
            self.customUserAgent = customUserAgent;
            NSDictionary *dictNU = [NSDictionary dictionaryWithObjectsAndKeys:customUserAgent,keyUserAgent, nil];
            [[NSUserDefaults standardUserDefaults] registerDefaults:dictNU];
        }];
    }
}

@end
