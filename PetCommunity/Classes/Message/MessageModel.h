//
//  MessageModel.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject <NSCoding>


typedef NS_ENUM(NSUInteger, MessageType){
    MessageTypeText,
    MessageTypeImage,
    MessageTypeAudio,
    MessageTypeVideo,
};

// content type
@property (assign, nonatomic) MessageType messageType;

// content
@property (copy, nonatomic) NSString *content;

// url
@property (copy, nonatomic) NSString *url;
// image
@property (strong, nonatomic) UIImage *image;
// is from me
@property (assign, nonatomic) BOOL isFromMe;


+ (instancetype)randomTextMessageToMe;
+ (instancetype)randomTextMessageFromMe;




@end
