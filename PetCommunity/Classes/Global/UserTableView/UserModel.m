//
//  UserModel.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@end
@implementation UserTag

@end


@implementation UserSource


+ (instancetype)randomUser {
    UserSource *random = [[self alloc] init];
    random.follow_count = arc4random_uniform(240);
    random.fans_count = arc4random_uniform(120);
    random.praise_count = NSStringFromInt32(arc4random_uniform(800) + (int)random.fans_count);
    return random;
}


@end


@implementation UserNewest_Pet

@end


@implementation UserAddress_Json

@end


