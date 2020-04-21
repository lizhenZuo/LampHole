//
//  DDRunLoopManager.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/6/17.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDRunLoopManager.h"

@interface DDRunLoopManager()

@end

@implementation DDRunLoopManager

+ (NSThread *)_ddThread {
    static NSThread *thread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(_ddThreadMain:) object:nil];
        if ([thread respondsToSelector:@selector(setQualityOfService:)]) {
            thread.qualityOfService = NSQualityOfServiceBackground;
        }
        [thread start];
    });
    return thread;
}

+ (void)_ddThreadMain:(id)object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"com.dingdong.iphone.aiTeacher.DDRunLoopManager"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}

/**
 获取LoopThread
 @return NSThread
 */
+ (NSThread *)ddLoopThread{
    return [self _ddThread];
}

/**
 添加一个执行器
 @param runLoopBlk DDNoParamsBlock
 */
+(void)addRunLoopBlock:(DDNoParamsBlock)runLoopBlk{
    [self performSelector:@selector(handleAction:) onThread:[self _ddThread] withObject:runLoopBlk  waitUntilDone:YES modes:@[NSDefaultRunLoopMode]];
}

/**
 调用处理
 @param runLoopBlk DDNoParamsBlock
 */
+(void)handleAction:(DDNoParamsBlock)runLoopBlk{
    if (runLoopBlk) {
        runLoopBlk();
    }
}

@end
