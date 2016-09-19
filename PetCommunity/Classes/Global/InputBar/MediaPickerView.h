//
//  MediaPickerView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-07.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaPickerView : UIView

@property (weak, nonatomic) IBOutlet UIView *sendImage;
@property (weak, nonatomic) IBOutlet UIView *sendAudio;
@property (weak, nonatomic) IBOutlet UIView *sendPhoto;
@property (weak, nonatomic) IBOutlet UIView *sendVideo;


- (void)didFinishPickImage:(void(^)(UIImage *image))image;
- (void)didFinishPickAudio:(void(^)(NSURL *audio))audio;
- (void)didFinishPickPhoto:(void(^)(UIImage *photo))photo;
- (void)didFinishPickVideo:(void(^)(NSURL *video))video;


@end
