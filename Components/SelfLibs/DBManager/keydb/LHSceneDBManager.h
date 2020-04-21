//
//  LHSceneDBManager.h
//  LampHole
//
//  Created by dingdong on 2019/12/31.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHSceneDBManager : NSObject

/**  获取单例对象  */
+ (instancetype )shareInstance;

/** 保存用户 */
-(BOOL)saveScene:(LHSceneModel *)scene;

/** 获取所有用户 */
-(NSArray<LHSceneModel *> *)getCurSceneArray;

@end

NS_ASSUME_NONNULL_END
