//
//  ATSocialButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATSocialButton.h"

@implementation ATSocialButton

- (instancetype)initWithImage:(NSString *)image action:(void (^)(UIButton *sender))action{
    if (self = [super initWithImage:image action:action]) {
        self.titleLabel.font = FontForFootnote();
        self.tintColor = atColor.lightGray;
        [self setTitleColor:atColor.lightGray forState:UIControlStateNormal];
    }
    return self;
}

@end
