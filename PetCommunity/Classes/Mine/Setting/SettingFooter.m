//
//  SettingFooter.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "SettingFooter.h"
#import "MDButton.h"

@implementation SettingFooter

+ (instancetype)footerWithHeight:(CGFloat)height {
    return [[self alloc] initWithHeight:height];
}

- (instancetype)initWithHeight:(CGFloat)height {
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, height)]) {
        [self setupButton];
    }
    return self;
}


// setup button
- (void)setupButton{
    // init and add to superview
    MDButton *btn = [[MDButton alloc] initWithFrame:self.bounds type:MDButtonTypeRaised rippleColor:atColor.theme.darkRatio(0.3)];
    [self addSubview:btn];
    btn.left = 8;
    btn.width = self.width - 16;
    btn.height = 36;
    btn.bottom = self.height - 8;
    btn.backgroundColor = [UIColor md_red];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    btn.layer.at_maskToCircle();
    
}


@end
