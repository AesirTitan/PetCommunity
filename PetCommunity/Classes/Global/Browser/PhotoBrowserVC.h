//
//  PhotoBrowserVC.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-07.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserVC : UIViewController


+ (void)vc:(UIViewController *)vc showBrowserControllerWithImage:(NSString *)image url:(NSString *)url point:(CGPoint)point;

+ (void)vc:(UIViewController *)vc showBrowserControllerWithLocalImage:(UIImage *)image description:(NSString *)desc point:(CGPoint)point;

@end
