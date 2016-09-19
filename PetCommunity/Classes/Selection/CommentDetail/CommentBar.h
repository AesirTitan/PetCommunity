//
//  CommentBar.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentBar : UIView



- (void)inputEmoticonAction:(void(^)())action;

- (void)inputDoneAction:(void(^)(NSString *text))action;

- (void)replyWithName:(NSString *)name;

- (void)submitComment;

- (void)adjustView:(UIView *)view;

@end
