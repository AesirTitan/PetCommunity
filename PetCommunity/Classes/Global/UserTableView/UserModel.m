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



// archive
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.image forKey:@"image"];
    
    [aCoder encodeInteger:self.follow_count forKey:@"follow_count"];
    [aCoder encodeInteger:self.fans_count forKey:@"fans_count"];
    [aCoder encodeObject:self.praise_count forKey:@"praise_count"];
    [aCoder encodeObject:self.is_follow forKey:@"is_follow"];
    
}

// unarchive
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init]){
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        
        self.follow_count = [aDecoder decodeIntegerForKey:@"follow_count"];
        self.fans_count = [aDecoder decodeIntegerForKey:@"fans_count"];
        self.praise_count = [aDecoder decodeObjectForKey:@"praise_count"];
        self.is_follow = [aDecoder decodeObjectForKey:@"is_follow"];
        
    }
    return self;
}




@end


@implementation UserNewest_Pet

@end


@implementation UserAddress_Json

@end


