//
//  UserProfileViewController.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"
#import "UserModel.h"
#import "CameraModel.h"
@interface UserProfileViewController : ATBaseViewController

// model
@property (strong, nonatomic) UserSource *user;
// camera user
@property (strong, nonatomic) CameraUser *cameraUser;


- (instancetype)initWithCameraUser:(CameraUser *)cameraUser;

- (instancetype)initWithUser:(UserSource *)user;

@end
