//
//  CamerFrameModel.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CamerFrameModel.h"
#import "CameraModel.h"
#import "ATNetworkManager.h"


@implementation CamerFrameModel

- (void)setModel:(CameraSource *)model{
    _model = model;
    // avatar
    self.avatarFrame = CGRectMake(sMargin, sMargin, sAvatarWH, sAvatarWH);
    // nickname
    const CGFloat nicknameX = CGRectGetMaxX(self.avatarFrame) + sMargin;
    const CGFloat nicknameY = CGRectGetMinY(self.avatarFrame);
    const CGFloat nicknameW = kScreenW - nicknameX - sMargin;
    const CGFloat nicknameH = HeightWithTextFontMaxWidth(model.camera.user.nickname, FontForNickName(), nicknameW);
    self.nicknameFrame = CGRectMake(nicknameX, nicknameY, nicknameW, nicknameH);
    // time
    const CGFloat timeY = CGRectGetMaxY(self.nicknameFrame) + 2;
    const CGFloat timeH = HeightWithTextFontMaxWidth(model.camera.time_add, FontForFootnote(), nicknameW);
    self.timeFrame = CGRectMake(nicknameX, timeY, nicknameW, timeH);
    // image
    const CGFloat imageY = CGRectGetMaxY(self.avatarFrame) + sMargin;
    self.imageFrame = CGRectMake(0, imageY, kScreenW, sEstimateImageHeight);
    // contant
    const CGFloat contentY = CGRectGetMaxY(self.imageFrame) + sMargin;
    const CGFloat contentW = kScreenW - sMargin - sMargin;
    const CGFloat contentH = HeightWithTextFontMaxWidth(model.camera.explain, FontForContentText(), contentW);
    
    self.contentFrame = CGRectMake(sMargin, contentY, contentW, contentH);
    // buttons
    const CGFloat socialButtonsY = CGRectGetMaxY(self.contentFrame) + 0.5*sMargin;
    const CGSize socialButtonsSize = CGSizeMake(80, 26);
    const CGFloat commentButtonX = sMargin + socialButtonsSize.width + sMargin;
    const CGFloat likeButtonX = commentButtonX + socialButtonsSize.width + sMargin;
    const CGRect shareButtonFrame = CGRectMake(sMargin, socialButtonsY, socialButtonsSize.width, socialButtonsSize.height);
    const CGRect commentButtonFrame = CGRectMake(commentButtonX, socialButtonsY, socialButtonsSize.width, socialButtonsSize.height);
    const CGRect likeButtonFrame = CGRectMake(likeButtonX, socialButtonsY, socialButtonsSize.width, socialButtonsSize.height);
    
    self.shareButtonFrame = shareButtonFrame;
    self.commentButtonFrame = commentButtonFrame;
    self.likeButtonFrame = likeButtonFrame;
    
    // view count
    const CGFloat viewcountY = CGRectGetMaxY(self.shareButtonFrame) + 0.5*sMargin;
    const CGSize viewcountSize = CGSizeMake(kScreenW - sMargin - sMargin, 15);
    self.viewCountFrame = CGRectMake(sMargin, viewcountY, viewcountSize.width, viewcountSize.height);
    
    // cell height
    self.cellHeight = CGRectGetMaxY(self.viewCountFrame) + sMargin;
    
    
}



@end
