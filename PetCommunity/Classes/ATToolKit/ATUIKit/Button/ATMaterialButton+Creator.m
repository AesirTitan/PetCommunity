//
//  ATMaterialButton+Creator.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATMaterialButton+Creator.h"

@implementation ATMaterialButton (Creator)


+ (ATMaterialButton *)buttonWithImage:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action{
    ATMaterialButton *button = [[ATMaterialButton alloc] initWithFrame:CGRectMake(0, 0, 0.5*kScreenW, 49)];
    button.backgroundColor = atColor.theme;
    button.tintColor = atColor.white;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button at_addTouchUpInsideHandler:action];
    button.layer.cornerRadius = 0;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    return button;
}


@end
