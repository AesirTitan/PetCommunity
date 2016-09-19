//
//  CameraTableViewCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CameraTableViewCell.h"
#import "ATButtonKit.h"

#import "AttentionButton.h"
#import "ATNetworkManager.h"
#import "CommentView.h"
#import "ContentView.h"
#import "CommentButton.h"
#import "UIButton+Animation.h"
#import "CommentDetailVC.h"

#import "UserProfileViewController.h"
#import "PhotoBrowserVC.h"


@interface CameraTableViewCell ()

// avatar
@property (weak, nonatomic) UIImageView *avatar;
// nickname
@property (weak, nonatomic) UILabel *nickname;
// time
@property (weak, nonatomic) UIButton *time;
// image
@property (weak, nonatomic) UIImageView *image;
// content
@property (weak, nonatomic) UILabel *content;
// share button
@property (weak, nonatomic) UIButton *shareButton;
// comment button
@property (weak, nonatomic) UIButton *commentButton;
// like button
@property (weak, nonatomic) UIButton *likeButton;
// view count
@property (weak, nonatomic) UIButton *viewCount;


@end

@implementation CameraTableViewCell

+ (instancetype)reusableCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"CameraTableViewCell";
    CameraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CameraTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // cell style
        self.contentView.backgroundColor = atColor.white;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.at_shadow(ATShadowCenterLight);
        [self at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
            [self.controller.view endEditing:YES];
            CGPoint location = [sender locationInView:self.contentView];
            // title view
            if (location.y <= CGRectGetMaxY(self.avatar.frame)) {
                UserProfileViewController *vc = [[UserProfileViewController alloc] initWithCameraUser:self.frameModel.model.camera.user];
                [self.controller.navigationController pushViewController:vc animated:YES];
            }
            // image
            else if (CGRectContainsPoint(self.image.frame, location)){
                CGPoint location = [sender locationInView:sender.view];
                location = [sender.view convertPoint:location toView:self.controller.view];
                [PhotoBrowserVC vc:self.controller showBrowserControllerWithImage:self.frameModel.model.camera.image url:self.frameModel.model.camera.url.url_replay point:location];
            }
            // other
            else {
                NSUInteger count = self.controller.navigationController.viewControllers.count;
                if (count <= 1) {
                    CommentDetailVC *vc = [[CommentDetailVC alloc] initWithFrameModel:self.frameModel];
                    [self.controller.navigationController pushViewController:vc animated:YES];
                } else{
                    
                }
                
            }
        }];
        // avatar
        UIImageView *avatar = [[UIImageView alloc] init];
        [self.contentView addSubview:avatar];
        self.avatar = avatar;
        avatar.frame = CGRectMake(sMargin, sMargin, sAvatarWH, sAvatarWH);
        avatar.layer.at_maskToCircle();
        avatar.contentMode = UIViewContentModeScaleAspectFill;
        // nickname
        UILabel *nickname = [[UILabel alloc] init];
        [self.contentView addSubview:nickname];
        self.nickname = nickname;
        nickname.font = FontForNickName();
        // time
        ATDisabledButton *time = [ATDisabledButton buttonWithImage:@"icon_time" tintColor:atColor.lightGray];
        [self.contentView addSubview:time];
        self.time = time;
        // image
        UIImageView *image = [[UIImageView alloc] init];
        [self.contentView addSubview:image];
        self.image = image;
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        // content
        UILabel *content = [[UILabel alloc] init];
        content.numberOfLines = 0;
        content.font = FontForContentText();
        [self.contentView addSubview:content];
        self.content = content;
        // share button
        ATSocialButton *share = [ATSocialButton buttonWithImage:@"icon_share" action:^(UIButton *sender) {
            ATLogFunc;
        }];
        [self.contentView addSubview:share];
        self.shareButton = share;
        // comment
        ATSocialButton *comment = [ATSocialButton buttonWithImage:@"icon_comment" action:^(UIButton *sender) {
            ATLogFunc;
        }];
        [self.contentView addSubview:comment];
        self.commentButton = comment;
        // like
        ATSocialButton *like = [ATSocialButton buttonWithImage:@"icon_like" action:^(UIButton *sender) {
            sender.selected = !sender.selected;
            
        }];
        [self.contentView addSubview:like];
        self.likeButton = like;
        
        // view count
        ATDisabledButton *viewcount = [ATDisabledButton buttonWithImage:@"icon_browse" tintColor:atColor.accent];
        [self.contentView addSubview:viewcount];
        self.viewCount = viewcount;
        viewcount.titleLabel.font = FontForFootnote();
        
    }
    return self;
}


- (void)setFrameModel:(CamerFrameModel *)frameModel{
    _frameModel = frameModel;
    CameraCamera *camera = frameModel.model.camera;
    
    [self.avatar sd_setImageWithURL:URLWithString(camera.user.image) placeholderImage:DefaultImageForAvatar()];
    self.avatar.frame = frameModel.avatarFrame;
    
    self.nickname.text = camera.user.nickname;
    self.nickname.frame = frameModel.nicknameFrame;
    
    [self.time setTitle:camera.time_add forState:UIControlStateNormal];
    self.time.frame = frameModel.timeFrame;
    
    [self.image sd_setImageWithURL:URLWithString(camera.image) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.image.frame = frameModel.imageFrame;
    
    self.content.text = camera.explain;
    self.content.frame = frameModel.contentFrame;
    
    [self.shareButton setTitle:camera.share_count forState:UIControlStateNormal];
    self.shareButton.frame = frameModel.shareButtonFrame;
    
    [self.commentButton setTitle:camera.discuz_count forState:UIControlStateNormal];
    self.commentButton.frame = frameModel.commentButtonFrame;
    
    [self.likeButton setTitle:camera.praise_count forState:UIControlStateNormal];
    self.likeButton.frame = frameModel.likeButtonFrame;
    
    NSString *str = [NSString stringWithFormat:@"浏览%@次",camera.view_count];
    [self.viewCount setTitle:str forState:UIControlStateNormal];
    self.viewCount.frame = frameModel.viewCountFrame;
    
}


@end
