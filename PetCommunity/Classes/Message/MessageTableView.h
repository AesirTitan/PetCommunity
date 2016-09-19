//
//  MessageTableView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableView : UIView


- (void)addRandomMessage;

- (void)reload;

- (void)cacheMessages;

- (void)updateBadge;

@end
