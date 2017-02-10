//
//  CommentCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-17.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "UserProfileViewController.h"

@interface CommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *content;

// void(^)(NSString *nickname)
@property (copy, nonatomic) void(^tappedCell)(NSString *nickname);

@end

@implementation CommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userImage.clipsToBounds = YES;
    self.userImage.layer.cornerRadius = 0.5 * fmin(self.userImage.frame.size.width, self.userImage.frame.size.height);
    [self.userImage at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        UserProfileViewController *vc = [[UserProfileViewController alloc] initWithUser:self.user];
        [self.controller.navigationController pushViewController:vc animated:YES];
    }];
    [self at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        if (self.tappedCell) {
            self.tappedCell(self.model.user_nickname);
        }
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(CameraSocial_Discuz *)model{
    _model = model;
    
    if (model.user_image) {
        [self.userImage sd_setImageWithURL:[NSURL URLWithString:model.user_image]];
    } else{
        self.userImage.image = [UIImage imageNamed:@"icon_defaultUser"];
    }
    
    if (model.user_nickname) {
        self.userName.text = model.user_nickname;
    }
    
    if (model.time_add) {
        self.time.text = model.time_add;
    } else{
        self.time.text = @"刚刚";
    }
    self.content.text = model.content;
    
}

- (void)tappedCell:(void(^)(NSString *nickname))action {
    self.tappedCell = action;
}


@end
