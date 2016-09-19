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

@implementation LoginUser

+ (void)load{
    loginUser = [self sharedInstance];
}

+ (instancetype)sharedInstance{
    if (!loginUser) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            loginUser = loginUserCachePath.readArchivedPlist;
            // do something...
            if (!loginUser) {
                loginUser = [LoginUser randomUser];
                loginUser.nickname = @"泰坦";
                loginUserCachePath.saveArchivedPlist(loginUser);
            }
        });
    }
    return loginUser;
}


@end
