//
//  AVAudioSession+DDAudioSession.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/9/20.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "AVAudioSession+DDAudioSession.h"

@implementation AVAudioSession (DDAudioSession)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSEL = @selector(setCategory:withOptions:error:);
        SEL swizzledSEL = @selector(dd_setCategory:withOptions:error:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSEL);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
        
        BOOL didAddMethod = class_addMethod(class, originalSEL , method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end
