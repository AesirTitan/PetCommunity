//
//  ATMaterialButton+Creator.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATMaterialButton.h"

@interface ATMaterialButton (Creator)

+ (ATMaterialButton *)buttonWithImage:(NSString *)image title:(NSString *)title action:(void (^)(UIButton *sender))action;
@end
