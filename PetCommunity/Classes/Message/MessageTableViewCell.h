//
//  MessageTableViewCell.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
#import "ATTableViewCell.h"

@interface MessageTableViewCell : ATTableViewCell

// model
@property (strong, nonatomic) ChatModel *model;

@end
