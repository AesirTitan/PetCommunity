//
//  UserTableViewCell.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-01.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATTableViewCell.h"
#import "UserModel.h"

@interface UserTableViewCell : ATTableViewCell

// user model
@property (strong, nonatomic) UserSource *model;

@end
