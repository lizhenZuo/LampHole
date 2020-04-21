//
//  DDDBPathManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDDBPathManager : NSObject

/**  获得用户数据库文件的路径 */
+ (NSString *)pathForUserDB;

/**  获得app公共缓存数据库 */
+ (NSString *)pathForPublicCacheDB;

/**  获得用户数据库文件的路径WCDB */
+ (NSString *)pathForUserWCDB;

/** 获取情景模式数据库文件的路径 */
+ (NSString *)pathForSceneDB;

@end
