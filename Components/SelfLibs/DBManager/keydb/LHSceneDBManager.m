//
//  LHSceneDBManager.m
//  LampHole
//
//  Created by dingdong on 2019/12/31.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHSceneDBManager.h"
#import "YTKKeyValueStore.h"

@implementation LHSceneDBManager {
    YTKKeyValueStore *_sceneStore;
    NSString *tableName_scene;
}

static NSString* const kTableName_Scene  = @"table_scene";//数据库 表名
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
        
        //表名由：kTableName_Scene + userName组成
        LHUserModel *userModel = [[DDUserDBManager shareInstance] getLoginUser];
        tableName_scene = [NSString stringWithFormat:@"%@_%@", kTableName_Scene, userModel.user_name];
        
        NSString *userPath = [DDDBPathManager pathForUserDB];
        _sceneStore = [[YTKKeyValueStore alloc] initWithDBWithPath:userPath];
        [_sceneStore createTableWithName:tableName_scene];
    }
    return self;
}

/** 保存用户 */
-(BOOL)saveScene:(LHSceneModel *)scene{
    if (scene) {
        NSString *sceneId = scene.sceneID;
        [_sceneStore putString:scene.mj_JSONString withId:sceneId intoTable:tableName_scene];
    }
    return YES;
}

-(NSArray<LHSceneModel *> *)getCurSceneArray
{
//    if ([DDShareCommonHelper isFirstLogin]) {
//        [self setDefaultData];
//    }
    
    NSMutableArray<LHSceneModel *> *sceneArrays = [[NSMutableArray alloc] init];
    NSArray<YTKKeyValueItem *> *array = [_sceneStore getAllItemsFromTable:tableName_scene];
    if (array.count <= 0) {
        [self setDefaultData];
    }
    for (YTKKeyValueItem *item in array) {
        NSArray *itemArray = item.itemObject;
        NSString *value = nil;
        if (itemArray && itemArray.count>0) {
            value = itemArray.firstObject;
        }
        if (value) {
            LHSceneModel *user = [LHSceneModel mj_objectWithKeyValues:value];
            [sceneArrays addObject:user];
        }
    }
    return sceneArrays;
}

- (void)setDefaultData
{
    for (int i = 0; i < 16; i ++)
    {
        
        NSString *sceneName = [NSString stringWithFormat:@"%c", 'A'+i];
        LHSceneModel *model = [[LHSceneModel alloc] init];
        model.sceneName = sceneName;
        model.iconScene = @"";
//        model.iconSceneData = nil;
        model.sceneID = [NSString stringWithFormat:@"%@_%@", @([DDTimeUtils getNowTimeStamp]), @(i)];
        [self saveScene:model];
    }
}

@end
