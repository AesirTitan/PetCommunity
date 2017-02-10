//
//  CommentDetailVC.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"
#import "CameraModel.h"
#import "CamerFrameModel.h"

@interface CommentDetailVC : ATBaseViewController

// CamerFrameModel
@property (strong, nonatomic) CamerFrameModel *frameModel;


- (instancetype)initWithFrameModel:(CamerFrameModel *)frameModel;



@end
