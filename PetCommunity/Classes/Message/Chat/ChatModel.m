//
//  ChatModel.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ChatModel.h"
#import "ATNetworkManager.h"


@implementation ChatModel


- (void)addMessage{
    [self.messages addObject:[MessageModel randomTextMessageToMe]];
    self.unreadCount++;
}

+ (instancetype)new{
    ChatModel *chat = [super new];
    chat.messages = [NSMutableArray array];
    return chat;
}

+ (instancetype)messageWithRandom {
    return [[self alloc] initWithRandom];
}

- (instancetype)initWithRandom {
    if (self = [super init]) {
        
        // random user
        NSArray<NSString *> *allUserPath = @"UserDetail".cachePath.subpaths(@"plist");
        if (!allUserPath.count) {
            return nil;
        }
        NSUInteger index = (NSUInteger)arc4random_uniform((int)allUserPath.count);
        
        UserSource *user = allUserPath[index].readArchivedPlist;
        self.user = user;
        if (!self.user.nickname.length) {
            self.user.nickname = @"未知用户";
        }
        
        ChatModel *chat = chatCachePath(user.nickname).readArchivedPlist;
        self.messages = chat.messages;
        if (!self.messages) {
            self.messages = [NSMutableArray array];
            [self.messages insertObject:[MessageModel randomTextMessageToMe] atIndex:0];
        }
        self.unreadCount = chat.unreadCount;
        
    }
    return self;
}



// archive
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.messages forKey:@"messages"];
    [aCoder encodeInteger:self.unreadCount forKey:@"unreadCount"];
}

// unarchive
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.messages = [aDecoder decodeObjectForKey:@"messages"];
        self.unreadCount = [aDecoder decodeIntegerForKey:@"unreadCount"];
    }
    return self;
}



@end
