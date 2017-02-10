//
//  MineModel.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MineModel;

@interface MineModelGroup : NSObject

// group
@property (strong, nonatomic) MineModel *mineModel;

@end

@interface MineModel : NSObject

// title
@property (copy, nonatomic) NSString *title;
// image
@property (copy, nonatomic) NSString *image;

@end
