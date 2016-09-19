//
//  ATDisabledButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATDisabledButton.h"

@implementation ATDisabledButton


- (instancetype)initWithImage:(NSString *)image tintColor:(UIColor *)tintColor{
    if (self = [super initWithImage:image tintColor:tintColor]) {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = FontForFootnote();
    }
    return self;
}

@end
