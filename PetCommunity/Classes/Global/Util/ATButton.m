//
//  ATButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATButton.h"

@implementation ATButton

+ (instancetype)buttonWithImage:(NSString *)image action:(void (^)(UIButton *sender))action{
    return [[self alloc] initWithImage:image action:action];
}


- (instancetype)initWithImage:(NSString *)image action:(void (^)(UIButton *sender))action{
    if (self = [super init]) {
        // image
        UIImage *imageNormal = [UIImage imageNamed:image];
        UIImage *imageHL = [UIImage imageNamed:[image stringByAppendingString:@"_HL"]];
        UIImage *imageSL = [UIImage imageNamed:[image stringByAppendingString:@"_SL"]];
        [self setImage:imageNormal forState:UIControlStateNormal];
        
        if (imageHL) {
            [self setImage:imageHL forState:UIControlStateHighlighted];
        }
        if (imageSL) {
            [self setImage:imageSL forState:UIControlStateSelected];
        }
        
        // action
        [self at_addTouchUpInsideHandler:^(UIButton * _Nonnull sender) {
            if (action) {
                action(sender);
            }
            [sender.imageView at_animatedScale:1.3 duration:0.7 completion:nil];
        }];
        
        // layout
        [self _layout];
        
    }
    return self;
}

+ (instancetype)buttonWithImage:(NSString *)image tintColor:(UIColor *)tintColor {
    return [[self alloc] initWithImage:image tintColor:tintColor];
}

- (instancetype)initWithImage:(NSString *)image tintColor:(UIColor *)tintColor {
    if (self = [super init]) {
        // image
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
        
        // title
        [self setTitleColor:tintColor forState:UIControlStateNormal];
        
        // layout
        [self _layout];
        
    }
    return self;
}


- (void)_layout{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    
    
    self.titleLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4);
    
    
}

@end
