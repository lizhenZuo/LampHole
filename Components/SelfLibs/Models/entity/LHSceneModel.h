//
//  LHSceneModel.h
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "DDBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHSceneModel : DDBaseModel

@property (nonatomic, strong) NSString *sceneID;
@property (nonatomic, strong) NSString *iconScene;
@property (nonatomic, strong) NSData *iconSceneData;
@property (nonatomic, strong) NSString *sceneName;

@end

NS_ASSUME_NONNULL_END
