//
//  ContentView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraModel.h"

@interface ContentView : UIView

// camera
@property (strong, nonatomic) CameraCamera *camera;

+ (instancetype)viewWithFrame:(CGRect)frame andAddToView:(UIView *)view;

@end
