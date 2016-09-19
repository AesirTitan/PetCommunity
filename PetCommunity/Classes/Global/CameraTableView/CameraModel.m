//
//  CellModel.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CameraModel.h"
#import "UserModel.h"

@implementation CameraModel



@end


@implementation CameraTag

+ (NSDictionary *)objectClassInArray{
    return @{@"source" : [CameraSource class]};
}

@end


@implementation CameraSource

+ (NSDictionary *)objectClassInArray{
    return @{@"social_discuz" : [CameraSocial_Discuz class]};
}

@end


@implementation CameraCamera

@end


@implementation CameraAddress_Json

@end


@implementation CameraUrl

@end


@implementation CameraPhotoalbum

@end


@implementation CameraUser


@end


@implementation CameraSocial_Discuz


+ (instancetype)newItemWithUser:(UserSource *)user content:(NSString *)content {
    CameraSocial_Discuz *item = [[CameraSocial_Discuz alloc] init];
    item.user_nickname = user.nickname;
    item.content = content;
    return item;
}
@end


