//
//  TableFooterButton.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableFooterButton : UIView

+ (instancetype)buttonViewTintColor:(UIColor *)tintColor title:(NSString *)title action:(void(^)(UIButton *sender))action;

- (instancetype)initWithTintColor:(UIColor *)tintColor title:(NSString *)title action:(void(^)(UIButton *sender))action;


@end
