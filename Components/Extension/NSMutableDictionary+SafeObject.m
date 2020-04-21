//
//  NSMutableDictionary+SafeObject.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/10/18.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "NSMutableDictionary+SafeObject.h"

@implementation NSMutableDictionary (SafeObject)

-(void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey{
    //NSAssert(anObject!=nil, @"输入的值不能为空...");
    if (anObject != nil) {
       [self setObject:anObject forKey:aKey];
    }
}

@end
