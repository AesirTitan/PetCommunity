//
//  CameraTableViewCell.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraModel.h"
#import "CamerFrameModel.h"


@interface CameraTableViewCell : UITableViewCell

// CamerFrameModel
@property (strong, nonatomic) CamerFrameModel *frameModel;

+ (instancetype)reusableCellWithTableView:(UITableView *)tableView;

@end
