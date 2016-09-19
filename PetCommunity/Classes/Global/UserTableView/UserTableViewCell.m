//
//  UserTableViewCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-01.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UserTableViewCell.h"

@interface UserTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userNickname;
@property (weak, nonatomic) IBOutlet UILabel *userBrowseCount;


@end

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = NO;
    self.layer.at_shadow(ATShadowCenterLight);
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.userAvatar.layer.at_maskToCircle();
    
    // default
    self.userAvatar.backgroundColor = atColor.lightGray;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(UserSource *)model{
    _model = model;
    
    
    
}


@end
