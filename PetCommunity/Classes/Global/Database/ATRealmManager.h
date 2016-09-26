//
//  ATRealmManager.h
//  PetCommunity
//
//  Created by Aesir Titan on 2016-09-20.
//  Copyright © 2016年 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraModel.h"
#import "UserModel.h"
#import "ChatModel.h"

#define RLMHotCamera [RLMRealm realmWithURL:[NSURL URLWithString:@"hotCamera.realm".cachePath]]

#define RLMUser [RLMRealm realmWithURL:[NSURL URLWithString:@"user.realm".cachePath]]


@interface ATRealmManager : NSObject

+ (void)cacheHotCameras:(NSMutableArray<CameraSource *> *)cameras;
+ (NSMutableArray<CameraSource *> *)hotCamerasWithRange:(NSRange)range;
+ (void)camera:(CameraSource *)camera addComment:(NSString *)text;
+ (void)camera:(CameraSource *)camera setLike:(BOOL)like;



+ (void)cacheUser:(UserSource *)user;
+ (UserSource *)randomUserFromCache;



+ (NSMutableArray<ChatModel *> *)messagesList;
+ (void)addNewChat:(ChatModel *)chat;
+ (UserSource *)userWithName:(NSString *)name;
+ (ChatModel *)chatWithUser:(UserSource *)user;
+ (void)deleteChat:(ChatModel *)chat;
+ (void)addRandomMessageToChat:(ChatModel *)chat;
+ (void)updateUnreadCount:(NSUInteger)count forChat:(ChatModel *)chat;
+ (void)user:(UserSource *)user setFollow:(BOOL)follow;






@end
