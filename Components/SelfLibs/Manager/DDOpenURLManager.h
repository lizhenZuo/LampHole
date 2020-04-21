//
//  DDOpenURLManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/11/8.
//  Copyright © 2018 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDOpenURLManager : NSObject

+ (instancetype)shareInstance;

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @param url     第三方sdk的打开本app的回调的url
 *  @param options 回调的参数
 *
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 */
-(BOOL)handleOpenURL:(NSURL *)url options:(NSDictionary*)options;

@end
