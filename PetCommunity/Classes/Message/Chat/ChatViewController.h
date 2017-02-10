//
//  ChatViewController.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"
#import "ChatModel.h"

@interface ChatViewController : ATBaseViewController

// chat model
@property (strong, nonatomic) ChatModel *model;

- (instancetype)initWithChatModel:(ChatModel *)model;


@end
