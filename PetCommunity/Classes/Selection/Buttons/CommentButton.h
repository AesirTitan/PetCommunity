//
//  ShareButton.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentButton : UIButton


+ (instancetype)buttonWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action;


- (void)reloadButtonWithImage:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action;

- (void)reloadButtonWithTitle:(NSString *)title action:(void (^)(UIButton *sender))action;



@end
