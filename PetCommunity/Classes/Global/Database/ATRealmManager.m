//
//  ATRealmManager.m
//  PetCommunity
//
//  Created by Aesir Titan on 2016-09-20.
//  Copyright © 2016年 Titan Studio. All rights reserved.
//

#import "ATRealmManager.h"
#import <Realm/Realm.h>
#import "ATNetworkManager.h"


@implementation ATRealmManager

+ (NSMutableArray<CameraSource *> *)hotCamerasWithRange:(NSRange)range{
    NSMutableArray<CameraSource *> *cameras = [NSMutableArray array];
    RLMResults *results = [CameraSource allObjectsInRealm:RLMHotCamera];
    if (results.count) {
        for (NSUInteger i=range.location; i<range.location+range.length; i++) {
            CameraSource *camera = results[i];
            [cameras addObject:camera];
        }
    } else {
        NSArray *arr = @"HotCamera2".plist.mainBundlePath.readArray;
        NSMutableArray *models = [NSMutableArray array];
        [models addObjectsFromArray:[CameraSource mj_objectArrayWithKeyValuesArray:arr]];
        [self cacheHotCameras:models];
        results = [CameraSource allObjectsInRealm:RLMHotCamera];
        if (results.count) {
            for (NSUInteger i=range.location; i<range.location+range.length; i++) {
                CameraSource *camera = results[i];
                [cameras addObject:camera];
            }
        }
    }
    return cameras;
}


+ (void)cacheHotCameras:(NSMutableArray<CameraSource *> *)cameras{
    for (CameraSource *camera in cameras) {
        [RLMHotCamera transactionWithBlock:^{
            [RLMHotCamera addObject:camera];
        }];
    }
}

+ (void)camera:(CameraSource *)camera addComment:(NSString *)text {
    CameraSocial_Discuz *item = [CameraSocial_Discuz newItemWithUser:loginUser content:text];
    [RLMHotCamera transactionWithBlock:^{
        camera.camera.discuz_count = NSStringFromNSUInteger(camera.camera.discuz_count.integerValue+1);
        [camera.social_discuz addObject:item];
    }];
}

+ (void)camera:(CameraSource *)camera setLike:(BOOL)like{
    [RLMHotCamera transactionWithBlock:^{
        if (like) {
            camera.camera.is_praise = 1;
            camera.camera.praise_count = NSStringFromNSUInteger(camera.camera.praise_count.integerValue+1);
        } else{
            camera.camera.is_praise = 2;
            camera.camera.praise_count = NSStringFromNSUInteger(camera.camera.praise_count.integerValue+1);
        }
    }];
}



+ (void)cacheUser:(UserSource *)user {
	[RLMUser transactionWithBlock:^{
        [RLMUser addObject:user];
    }];
}

+ (UserSource *)randomUserFromCache {
    RLMResults *results = [UserSource allObjectsInRealm:RLMUser];
    NSUInteger index = arc4random_uniform((int)results.count);
    return results[index];
}

+ (UserSource *)userWithName:(NSString *)name{
    RLMResults *results = [UserSource objectsInRealm:RLMUser where:@"nickname == %@",name];
    if (results.count) {
        return results[0];
    }else{
        return nil;
    }
}

+ (void)user:(UserSource *)user setFollow:(BOOL)follow{
    [RLMUser transactionWithBlock:^{
        if (follow) {
            user.is_follow = @"1";
        } else{
            user.is_follow = @"2";
        }
    }];
}


+ (NSMutableArray<ChatModel *> *)messagesList{
    NSMutableArray<ChatModel *> *list = [NSMutableArray array];
    RLMResults *results = [ChatModel allObjectsInRealm:RLMUser];
    for (ChatModel *tmp in results) {
        [list addObject:tmp];
    }
    return list;
}

+ (void)addNewChat:(ChatModel *)chat{
    [RLMUser transactionWithBlock:^{
        [RLMUser addObject:chat];
    }];
}

+ (void)deleteChat:(ChatModel *)chat{
    [RLMUser transactionWithBlock:^{
        [RLMUser deleteObject:chat];
    }];
}

+ (ChatModel *)chatWithUser:(UserSource *)user{
    RLMResults *results = [ChatModel allObjectsInRealm:RLMUser];
    for (ChatModel *tmp in results) {
        if ([tmp.user.nickname isEqualToString:user.nickname]) {
            return tmp;
        }
    }
    return nil;
}


+ (void)addRandomMessageToChat:(ChatModel *)chat{
    
    [RLMUser transactionWithBlock:^{
        RLMResults *all = [ChatModel allObjectsInRealm:RLMUser];
        for (ChatModel *tmp in all) {
            if ([tmp isEqual:all]) {
                [tmp addMessage];
            }
        }
    }];
}


+ (void)updateUnreadCount:(NSUInteger)count forChat:(ChatModel *)chat{
    [RLMUser transactionWithBlock:^{
        RLMResults *all = [ChatModel allObjectsInRealm:RLMUser];
        for (ChatModel *tmp in all) {
            if ([tmp isEqual:all]) {
                tmp.unreadCount = count;
            }
        }
    }];
}




@end
