//
//  CommentCell.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-17.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraModel.h"
#import "ATTableViewCell.h"
@interface CommentCell : ATTableViewCell

// model
@property (strong, nonatomic) CameraSocial_Discuz *model;

// model
@property (strong, nonatomic) UserSource *user;

- (void)tappedCell:(void(^)(NSString *nickname))action;

@end
