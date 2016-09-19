//
//  MineHeader.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MineHeader.h"
#import "UIImageView+WebCache.h"
#import "UserProfileViewController.h"

@interface MineHeader ()


@property (weak, nonatomic) IBOutlet UIView *detail;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userId;

@property (weak, nonatomic) IBOutlet UIView *follow;
@property (weak, nonatomic) IBOutlet UILabel *followCount;

@property (weak, nonatomic) IBOutlet UIView *fans;
@property (weak, nonatomic) IBOutlet UILabel *fansCount;

@property (weak, nonatomic) IBOutlet UIView *like;

@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height_line;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width_line;


@end

@implementation MineHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = atColor.theme;
    self.userImage.layer.at_maskToCircle();
    self.height_line.constant = 0.5;
    self.width_line.constant = 0.5;
    self.layer.at_shadow(ATShadowDownLight);
    [self setupEvent];
    
}

- (void)setUser:(UserSource *)user{
    _user = user;
    if (user) {
//        self.userName.text = self.user.nickname;
        if (user.image) {
            [self.userImage sd_setImageWithURL:[NSURL URLWithString:self.user.image]];
        }
//        self.userId.text = self.user.user_id;
        
        self.followCount.text = NSStringFromNSInteger(self.user.follow_count);
        self.fansCount.text = NSStringFromNSInteger(self.user.fans_count);
        self.likeCount.text = self.user.praise_count;
    }
    
}



// setup event
- (void)setupEvent{
    [self.detail at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {
        UserProfileViewController *vc = [[UserProfileViewController alloc] initWithUser:self.user];
        [self.controller.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.follow at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {

    } animatedScale:1.2 duration:0.6];
    [self.fans at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {

    } animatedScale:1.2 duration:0.6];
    [self.like at_addTapGesture:nil handler:^(UITapGestureRecognizer * _Nonnull sender) {

    } animatedScale:1.2 duration:0.6];

}



@end
