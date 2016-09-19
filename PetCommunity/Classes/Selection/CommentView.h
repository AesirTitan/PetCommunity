//
//  CommentView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-17.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraModel.h"

@interface CommentView : UIView

// camera
@property (strong, nonatomic) CameraSource *source;


+ (instancetype)viewWithFrame:(CGRect)frame andAddToView:(UIView *)view;

@end
