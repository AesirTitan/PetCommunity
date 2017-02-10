//
//  MessageTableViewCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "ChatViewController.h"
#import "ATNetworkManager.h"

@interface MessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;

@property (weak, nonatomic) IBOutlet UILabel *userNickname;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;

// unread count
@property (assign, nonatomic) NSUInteger unreadCount;

@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userAvatar.layer.at_maskToCircle();
    self.unreadCount = 1;
    [self.contentView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        ChatViewController *vc = [[ChatViewController alloc] initWithChatModel:self.model];
        self.unreadCount = 0;
        [self.controller.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setUnreadCount:(NSUInteger)unreadCount{
    _unreadCount = unreadCount;
    self.badgeLabel.text = NSStringFromNSUInteger(unreadCount);
    [RLMUser transactionWithBlock:^{
        self.model.unreadCount = unreadCount;
    }];
}

- (void)setModel:(ChatModel *)model{
    _model = model;
    
    self.unreadCount = model.unreadCount;
    self.userNickname.text = model.user.nickname;
    [self.userAvatar sd_setImageWithURL:[NSURL URLWithString:model.user.image]];
    self.content.text = [model.messages lastObject].content;
    self.time.text = @"刚刚";
    
}

@end
