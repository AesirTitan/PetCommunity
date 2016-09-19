//
//  ATBadgeLabel.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBadgeLabel.h"

@implementation ATBadgeLabel


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor md_red];
        self.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor md_red];
    self.textAlignment = NSTextAlignmentCenter;
    self.maskView = [UIView at_roundedViewWithFrame:self.bounds];
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.maskView = [UIView at_roundedViewWithFrame:self.bounds];
    self.hidden = !self.text.integerValue;
    
}



@end
