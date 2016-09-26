//
//  LoginUser.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-06.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "LoginUser.h"
#import "ATNetworkManager.h"

LoginUser *loginUser = nil;

static NSString *sUserId = @"307935";
static NSString *sUserName = @"泰坦";

@implementation LoginUser

+ (void)load{
    loginUser = [self sharedInstance];
}

+ (instancetype)sharedInstance{
    if (!loginUser) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            RLMResults *results = [UserSource objectsInRealm:RLMUser where:@"user_id == %@", sUserId];
            if (results.count) {
                loginUser = results[0];
            }
            // do something...
            if (!loginUser) {
                loginUser = [LoginUser randomUser];
                loginUser.user_id = sUserId;
                loginUser.nickname = sUserName;
                [ATRealmManager cacheUser:loginUser];
            }
        });
    }
    return loginUser;
}


@end
