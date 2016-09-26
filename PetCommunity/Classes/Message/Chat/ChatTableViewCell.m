//
//  ChatTableViewCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "ATNetworkManager.h"
#import "UserProfileViewController.h"
#import "PhotoBrowserVC.h"

@interface ChatTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UITextView *content;

@property (weak, nonatomic) IBOutlet UIImageView *myAvatar;


@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
// user
@property (strong, nonatomic) UserSource *user;
// message
@property (strong, nonatomic) MessageModel *message;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfImage;

@end

@implementation ChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = atColor.clear;
    self.contentView.backgroundColor = atColor.clear;
    
    // friend avatar
    self.userAvatar.layer.at_maskToCircle();
    [self.userAvatar at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        UserProfileViewController *vc = [[UserProfileViewController alloc] initWithUser:self.user];
        [self.controller.navigationController pushViewController:vc animated:YES];
    }];
    // my avatar
    self.myAvatar.layer.at_maskToCircle();
    self.myAvatar.image = [UIImage imageNamed:@"icon_defaultUser"];
    
    self.content.layer.at_shadow(ATShadowDownLight);
    self.content.textContainerInset = UIEdgeInsetsMake(8, 4, 8, 4);
    self.content.backgroundColor = atColor.white;
    self.content.layer.cornerRadius = 8;
    self.content.textColor = atColor.darkGray;
    
    self.contentImage.clipsToBounds = YES;
    self.contentImage.layer.cornerRadius = 8;
    
    [self.contentImage at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        CGPoint location = [sender locationInView:sender.view];
        location = [sender.view convertPoint:location toView:self.controller.view];
        [PhotoBrowserVC vc:self.controller showBrowserControllerWithLocalImage:self.contentImage.image description:nil point:location];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupUser:(UserSource *)user message:(MessageModel *)message{
    self.user = user;
    self.message = message;
    
    self.userAvatar.hidden = message.isFromMe;
    self.myAvatar.hidden = !message.isFromMe;
    if (message.isFromMe) {
        self.content.backgroundColor = atColor.theme.light;
    } else{
        self.content.backgroundColor = atColor.white;
    }
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:self.user.image] placeholderImage:[UIImage imageNamed:@"icon_defaultUser"]];
    
    switch (message.messageType) {
        case MessageTypeText: {
            self.contentImage.hidden = YES;
            self.content.text = message.content;
            [self.content sizeToFit];
            self.heightOfImage.constant = self.content.height;
            break;
        }
        case MessageTypeImage: {
            self.contentImage.hidden = NO;
            self.contentImage.image = [UIImage imageWithData:message.image];
            CGSize size = self.contentImage.image.size;
            if (size.width && size.height) {
                self.heightOfImage.constant = self.contentImage.width * size.height/size.width;
            }
            
            
            break;
        }
        case MessageTypeAudio: {
            self.contentImage.hidden = NO;
            break;
        }
        case MessageTypeVideo: {
            self.contentImage.hidden = NO;
            break;
        }
    }
    
    
}


@end
