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


@end
