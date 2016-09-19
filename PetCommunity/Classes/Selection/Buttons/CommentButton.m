//
//  ShareButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CommentButton.h"

@interface CommentButton ()

// action
@property (copy, nonatomic) void (^action)(UIButton *);

@end

@implementation CommentButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius = 3;

    
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    self.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    
    
    
}

+ (instancetype)buttonWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action{
    return [[self alloc] initWithFrame:frame image:image title:title action:action];
}


- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.action = action;
        [self addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)tapped:(UIButton *)sender{
    if (self.action) {
        self.action(sender);
    }
}

- (void)reloadButtonWithImage:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action {
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.action = action;
    [self addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadButtonWithTitle:(NSString *)title action:(void (^)(UIButton *sender))action {
    [self setTitle:title forState:UIControlStateNormal];
    self.action = action;
    [self addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
}



@end
