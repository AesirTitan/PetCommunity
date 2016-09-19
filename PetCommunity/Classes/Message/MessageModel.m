//
//  MessageModel.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


+ (instancetype)randomTextMessageToMe {
    MessageModel *message = [MessageModel randomTextMessage];
    message.isFromMe = NO;
    return message;
}

+ (instancetype)randomTextMessageFromMe {
    MessageModel *message = [MessageModel randomTextMessage];
    message.isFromMe = YES;
    return message;
}

+ (instancetype)randomTextMessage{
    MessageModel *message = [MessageModel new];
    message.messageType = MessageTypeText;
    message.content = NSStringFromRandom(ATRandomCapitalizeString, ATUIntegerRangeMake(5, 100));
    return message;
}


// archive
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInteger:self.messageType forKey:@"messageType"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeInteger:self.isFromMe forKey:@"isFromMe"];
}

// unarchive
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.messageType = [aDecoder decodeIntegerForKey:@"messageType"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.isFromMe = [aDecoder decodeIntegerForKey:@"isFromMe"];
    }
    return self;
}



@end
