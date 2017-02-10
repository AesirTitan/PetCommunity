//
//  CamerFrameModel.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CameraSource;

@interface CamerFrameModel : NSObject

// avatar frame
@property (assign, nonatomic) CGRect avatarFrame;
// nickname frame
@property (assign, nonatomic) CGRect nicknameFrame;
// time frame
@property (assign, nonatomic) CGRect timeFrame;

// image frame
@property (assign, nonatomic) CGRect imageFrame;
// content frame
@property (assign, nonatomic) CGRect contentFrame;

// share button
@property (assign, nonatomic) CGRect shareButtonFrame;
// comment button
@property (assign, nonatomic) CGRect commentButtonFrame;
// like button
@property (assign, nonatomic) CGRect likeButtonFrame;
// view count
@property (assign, nonatomic) CGRect viewCountFrame;

// model
@property (strong, nonatomic) CameraSource *model;
// cell height
@property (assign, nonatomic) CGFloat cellHeight;

@end
