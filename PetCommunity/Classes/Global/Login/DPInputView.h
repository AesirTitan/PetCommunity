//
//  DPInputView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPInputView : UITextField

+ (instancetype)at_passwordViewWithPlaceholder:(NSString *)placeholder textChanged:(void (^)(NSString *text))textChanged;

@end
