//
//  NSMutableDictionary+SafeObject.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/10/18.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (SafeObject)

-(void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end

NS_ASSUME_NONNULL_END
