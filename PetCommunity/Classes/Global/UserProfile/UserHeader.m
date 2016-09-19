//
//  UserHeader.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UserHeader.h"
#import "ATNetworkManager.h"

@interface UserHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *followCount;

@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width_line;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height_line;

@property (weak, nonatomic) IBOutlet UIView *follow;

@property (weak, nonatomic) IBOutlet UIView *fans;
@property (weak, nonatomic) IBOutlet UIView *like;

@end

@implementation UserHeader


- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initUI];
}

// init UI
- (void)_initUI{
    // constant
    self.height_line.constant = 0.5;
    self.width_line.constant = 0.5;
    // segmented
    self.segmented.tintColor = atColor.theme;
    // button
    [self.follow at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {
        
    } animatedScale:1.2 duration:0.6];
    [self.fans at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {
        
    } animatedScale:1.2 duration:0.6];
    [self.like at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {
        
    } animatedScale:1.2 duration:0.6];
    
}

- (void)setCameraUser:(CameraUser *)cameraUser{
    _cameraUser = cameraUser;
    [self updateUI];
}


- (void)setUser:(UserSource *)user{
    _user = user;
    [self updateUI];
}



- (void)updateUI{
    
    // image
    if (self.cameraUser.image) {
        [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.cameraUser.image]];
    } else if (self.user.image){
        [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.user.image]];
    } else{
        self.userImage.image = [UIImage imageNamed:@"icon_defaultUser"];
    }
    
    self.followCount.text = NSStringFromNSInteger(self.user.follow_count);
    self.fansCount.text = NSStringFromNSInteger(self.user.fans_count);
    self.likeCount.text = self.user.praise_count;
}

@end
