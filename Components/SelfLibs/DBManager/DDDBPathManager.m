//
//  DDDBPathManager.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDDBPathManager.h"

@implementation DDDBPathManager

//数据库文件
static NSString *const kDocumentUserDBFileName = @"user.db";// 数据库
static NSString *const kDocumentCacheDBFileName = @"public_cache.db";//app公共缓存数据库
static NSString *const kDatabaseRootPathName = @"aiteacherdb";//数据库 filename
static NSString *const kDocument_WCDBName = @"wcdb_user.db";// 数据库
static NSString *const kDocumentSceneDBFileName = @"scene.db"; //情景模式

+ (DDDBPathManager *)shareInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

/**
 获取数据库目录名称，所有app的数据库都在此目录
 */
+ (NSString *)pathForDBDirectory{
    [DDPathUtils createDirectoryAtDocument:kDatabaseRootPathName];
    return [DDPathUtils getFileDocumentPath:kDatabaseRootPathName];
}

/**
 获取db的文件的路径
 
 @param pathName db名称
 @return db文件地址
 */
+ (NSString *)pathForDBName:(NSString *)pathName {
    if (!pathName || pathName < 0) {
        pathName = 0 ;
    }
    NSString *dbDir = [self pathForDBDirectory];
    NSString *path = [dbDir stringByAppendingPathComponent:pathName];
    return path;
}

/**
 取得用户数据库文件的路径
 
 @return 用户数据库
 */
+ (NSString *)pathForUserDB{
    return [self pathForDBName:kDocumentUserDBFileName];
}

/**
 app公共缓存数据库
 
 @return app公共缓存数据库
 */
+ (NSString *)pathForPublicCacheDB{
    return [self pathForDBName:kDocumentCacheDBFileName];
}

/**  获得用户数据库文件的路径WCDB */
+ (NSString *)pathForUserWCDB{
     return [self pathForDBName:kDocument_WCDBName];
}

/** 获取情景模式数据库文件的路径 */
+ (NSString *)pathForSceneDB{
    return [self pathForDBName:kDocumentSceneDBFileName];
}

@end
