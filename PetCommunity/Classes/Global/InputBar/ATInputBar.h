//
//  ATInputBar.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-07.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATInputBar : UIView


- (void)inputEmoticonAction:(void(^)())action;

- (void)inputDoneAction:(void(^)(NSString *text))action;

- (void)replyWithName:(NSString *)name;

- (void)submitComment;

- (void)adjustView:(UIView *)view;

- (void)didFinishPickImage:(void(^)(UIImage *image))image;
- (void)didFinishPickAudio:(void(^)(NSURL *audio))audio;
- (void)didFinishPickPhoto:(void(^)(UIImage *photo))photo;
- (void)didFinishPickVideo:(void(^)(NSURL *video))video;
- (void)hideMediaPicker;


@end
