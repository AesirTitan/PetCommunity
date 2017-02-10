//
//  ATNetworkManager.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-27.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableView+Creator.h"
#import "HYBNetworking.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "UIImageView+WebCache.h"
#import "NetworkManager.h"



FOUNDATION_EXTERN NSString *kURLHotCamera;

FOUNDATION_EXTERN NSString *kURLFollowedCamera;


#define kRobotURL @"http://www.tuling123.com/openapi/api"
#define kRobotKey @"d56e4abbb4fc4bdea585f2b91a435026"

#define kNotiReceiveMessage @"kNotiReceiveMessage"

#define loginUserCachePath @"泰坦".cachePath


#define userCachePath(name) [@"UserDetail" stringByAppendingPathComponent:name].cachePath

#define chatCachePath(name) [@"Message" stringByAppendingPathComponent:name].cachePath
