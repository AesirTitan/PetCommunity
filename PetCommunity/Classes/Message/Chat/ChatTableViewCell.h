//
//  ChatTableViewCell.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
#import "ATTableViewCell.h"
#import "ChatModel.h"

@interface ChatTableViewCell : ATTableViewCell

- (void)setupUser:(UserSource *)user message:(MessageModel *)message;

@end
