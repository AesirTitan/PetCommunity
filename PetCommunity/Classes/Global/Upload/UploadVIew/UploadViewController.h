//
//  UploadViewController.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"
#import "UploadPickerView.h"
@interface UploadViewController : ATBaseViewController

// picker
@property (weak, nonatomic) UploadPickerView *picker;

- (instancetype)initWithPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;



@end
