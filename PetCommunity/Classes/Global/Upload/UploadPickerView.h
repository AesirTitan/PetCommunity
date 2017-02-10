//
//  UploadPickerView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadPickerView : UIView


- (void)tappedAlbumView:(void(^)())action;

- (void)tappedPhotoView:(void(^)())action;

- (void)tappedVideoView:(void(^)())action;

- (void)tappedCancel:(void(^)())action;

@end
