//
//  TableFooterButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "TableFooterButton.h"
#import "MDButton.h"

@interface TableFooterButton ()

@end

@implementation TableFooterButton

+ (instancetype)buttonViewTintColor:(UIColor *)tintColor title:(NSString *)title action:(void(^)(UIButton *sender))action{
    return [[self alloc] initWithTintColor:tintColor title:title action:action];
}

- (instancetype)initWithTintColor:(UIColor *)tintColor title:(NSString *)title action:(void(^)(UIButton *sender))action{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, 56)]) {
        MDButton *btn = [[MDButton alloc] initWithFrame:self.bounds type:MDButtonTypeRaised rippleColor:tintColor.darkRatio(0.3)];
        [self addSubview:btn];
        // frame
        btn.left = 8;
        btn.width = self.width - 16;
        btn.height = 40;
        btn.bottom = self.height - 8;
        // color
        btn.backgroundColor = tintColor;
        // font
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        // title
        [btn setTitle:title forState:UIControlStateNormal];
        // mask
        btn.layer.at_maskToCircle();
        // action
        [btn at_addTouchUpInsideHandler:action];
        
    }
    return self;
}

@end
