//
//  UIButton+Animation.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-19.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UIButton+Animation.h"

@implementation UIButton (Animation)

- (void)scale:(CGFloat)scale duration:(NSTimeInterval)duration{
    self.imageView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:duration delay:0.0f usingSpringWithDamping:0.3f initialSpringVelocity:0.2f options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        
    }];
}


@end
