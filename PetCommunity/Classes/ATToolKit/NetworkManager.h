//
//  NetworkManager.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-27.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

// url
#define kBaseURL  @"http://chongzaiquan.jingchang.tv/jpet/api.php"
// global
#define kURLSearchCamera  @"/Camera/SearchCameraForCameraMain"
// home
#define kURLCameraList  @"/Camera/getCameraForCameraList"
#define kURLFollowCameraMain  @"/Camera/getFollowCameraForCameraMain"
#define kURLCameraDetail  @"/Camera/getCameraInfoForDetail"
#define kURLCameraComment  @"/Camera/getCameraCommentForList"
#define kURLSocialAction  @"/Social/setActionForSocialCamera"
// mine
#define kURLUserDetail  @"/User/getUserdataForUser"
#define kURLSocialFansList  @"/Social/GetFansListForSocialUser"
#define kURLSocialFollowList  @"/Social/GetFollowListForSocialUser"
#define kURLSystemUser  @"/user/BatchGetUserDataForUserMain"
#define kURLMessage  @"/SystemMessaged/GetLastMessage"
#define kURLSocialGetMyComment  @"/Social/getMyCommentedList"
#define kURLSearchUserWithId  @"/user/GetUserListByUserId"
#define kURLSearchUserWithKeyword  @"/user/SearchUserByKeyword"

#define kURLSocialComment  @"/Social/setDiscuzForSocialDiscuz"

// request
#define kChannelId  @"channel_id"
#define kGuid  @"guid"
#define kPi  @"pi"
#define kTokenCipher  @"token_cipher"
#define kType  @"type"
#define kUserId  @"user_id"
#define kKeyword  @"keyword"

#define kCameraId  @"camera_id"
#define kActionId  @"action_id"
#define kStatus  @"status"
#define kData  @"data"
#define kCategoryId  @"category_id"
#define kContent  @"content"
#define kPID  @"p_id"


extern NSString *kLoginUser;

extern NSString *URLWith(NSString *url);


extern NSMutableDictionary *paramWithDefaultUser();


@interface NetworkManager : NSObject


@end

@interface NSMutableDictionary (Param)

- (NSMutableDictionary *(^)(NSString *key, NSString *value))append;
- (NSMutableDictionary *(^)(NSString *))appendChannelId;
- (NSMutableDictionary *(^)(NSString *))appendGuid;
- (NSMutableDictionary *(^)(NSUInteger))appendPage;
- (NSMutableDictionary *(^)(NSString *))appendTokenCipher;
- (NSMutableDictionary *(^)(NSString *))appendType;

@end
