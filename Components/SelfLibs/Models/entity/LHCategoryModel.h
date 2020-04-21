//
//  LHCategoryModel.h
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHCategoryModel : DDBaseModel

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, assign) NSInteger nums;

@end

NS_ASSUME_NONNULL_END
