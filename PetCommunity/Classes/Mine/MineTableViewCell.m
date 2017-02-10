//
//  MineTableViewCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell



- (void)setModel:(MineModel *)model{
    
    _model = model;
    self.imageView.image = [UIImage imageNamed:model.image];
    self.textLabel.text = model.title;
    
}

@end
