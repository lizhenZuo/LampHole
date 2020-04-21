//
//  DDRunLoopManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/6/17.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDRunLoopManager : NSObject
/**
 获取LoopThread
 @return NSThread
 */
+ (NSThread *)ddLoopThread;

/**
 添加一个执行器
 @param runLoopBlk DDNoParamsBlock
 */
+(void)addRunLoopBlock:(DDNoParamsBlock)runLoopBlk;

@end

NS_ASSUME_NONNULL_END
