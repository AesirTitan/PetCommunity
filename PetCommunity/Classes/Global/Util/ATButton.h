//
//  ATButton.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-08.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATButton : UIButton

+ (instancetype)buttonWithImage:(NSString *)image action:(void (^)(UIButton *sender))action;
- (instancetype)initWithImage:(NSString *)image action:(void (^)(UIButton *sender))action;

+ (instancetype)buttonWithImage:(NSString *)image tintColor:(UIColor *)tintColor;
- (instancetype)initWithImage:(NSString *)image tintColor:(UIColor *)tintColor;

@end
