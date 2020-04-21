//
//  DDDBManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDUserDBManager : NSObject

/**  获取单例对象  */
+ (instancetype )shareInstance;

/** 保存登录对象 */
-(void)saveLoginUser:(LHUserModel *)user;

/** 退出登录  */
-(void)logout;

/** 获取登录对象 */
-(LHUserModel *)getLoginUser;

/** 获取所有用户 */
-(NSArray<LHUserModel *> *)getUserArray;

/** 清空表 */
-(void)cleanTable;


@end
