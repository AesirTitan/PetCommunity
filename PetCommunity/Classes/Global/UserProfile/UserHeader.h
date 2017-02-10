//
//  UserHeader.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "CameraModel.h"

@interface UserHeader : UIView

// model
@property (strong, nonatomic) UserSource *user;
// camera user
@property (strong, nonatomic) CameraUser *cameraUser;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;


- (void)updateUI;


@end
