//
//  AttentionButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "AttentionButton.h"



@implementation AttentionButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = atColor.theme.CGColor;
    
}




@end
