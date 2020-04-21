//
//  DDDBManager.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDUserDBManager.h"
#import "YTKKeyValueStore.h"

@implementation DDUserDBManager{
    YTKKeyValueStore *_userStore;
}

static NSString* const kTableName_User  = @"table_user";//数据库 表名
static LHUserModel *_loginedUser;

/**  获取单例对象  */
+ (instancetype )shareInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *userPath = [DDDBPathManager pathForUserDB];
        _userStore = [[YTKKeyValueStore alloc] initWithDBWithPath:userPath];
        [_userStore createTableWithName:kTableName_User];
    }
    return self;
}

/**  保存登录对象 */
-(void)saveLoginUser:(LHUserModel *)user{
    NSAssert(user && user.user_id, @"当前登录对象有错误...");
    //赋值登录
    user.loginDBFlag = YES;
    _loginedUser = user;
    [self saveUser:user];
}

/** 退出登录 */
-(void)logout{
    _loginedUser.loginDBFlag = NO;
    _loginedUser = nil;
    NSArray<LHUserModel *> *userArray = [self getUserArray];
    for (LHUserModel *user in userArray) {
        if (user && user.loginDBFlag) {
            user.loginDBFlag = NO;
            user.isLogin = NO;
            [self saveUser:user];
        }
    }
}

/** 保存用户 */
-(BOOL)saveUser:(LHUserModel *)user{
    if (user) {
        NSString *userId = user.user_id;
        [_userStore putString:user.mj_JSONString withId:userId intoTable:kTableName_User];
    }
    return YES;
}

/** 获取登录对象 */
-(LHUserModel *)getLoginUser{
    if (_loginedUser) return _loginedUser;
    NSArray<LHUserModel *> *userArray = [self getUserArray];
    for (LHUserModel *user in userArray) {
        if (user && user.loginDBFlag) {
            _loginedUser = user;
            break;
        }
    }
    return _loginedUser;
}

/**
 获取所有用户
 @return 用户列表
 */
-(NSArray<LHUserModel *> *)getUserArray{
    NSMutableArray<LHUserModel *> *userArrays = [[NSMutableArray alloc] init];
    NSArray<YTKKeyValueItem *> *array = [_userStore getAllItemsFromTable:kTableName_User];
    for (YTKKeyValueItem *item in array) {
        NSArray *itemArray = item.itemObject;
        NSString *value = nil;
        if (itemArray && itemArray.count>0) {
            value = itemArray.firstObject;
        }
        if (value) {
            LHUserModel *user = [LHUserModel mj_objectWithKeyValues:value];
            [userArrays addObject:user];
        }
    }
    return userArrays;
}

/** 清空表 */
-(void)cleanTable{
    [_userStore clearTable:kTableName_User];
}

@end

