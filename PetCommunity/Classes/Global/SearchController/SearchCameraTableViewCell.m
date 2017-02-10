//
//  SearchCameraTableViewCell.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "SearchCameraTableViewCell.h"
#import "CommentDetailVC.h"
#import "ATNetworkManager.h"

@interface SearchCameraTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *userNickname;

@property (weak, nonatomic) IBOutlet UILabel *cameraContent;

@property (weak, nonatomic) IBOutlet UIImageView *cameraImage;

@end

@implementation SearchCameraTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.opaque = YES;
    [self.contentView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        CommentDetailVC *vc = [[CommentDetailVC alloc] initWithFrameModel:self.frameModel];
        [self.controller.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrameModel:(CamerFrameModel *)frameModel{
    _frameModel = frameModel;
    
    self.userNickname.text = frameModel.model.camera.user.nickname;
    self.cameraContent.text = frameModel.model.camera.explain;
    [self.cameraImage sd_setImageWithURL:URLWithString(frameModel.model.camera.image) placeholderImage:DefaultImageForCell()];
}



@end
