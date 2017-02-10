//
//  PushDetailVC.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushDetailVC : NSObject

+ (void)mineVC:(UIViewController *)viewController pushViewControllerWithIndexPath:(NSIndexPath *)indexPath;

+ (void)settingVC:(UIViewController *)viewController pushViewControllerWithIndexPath:(NSIndexPath *)indexPath;


@end
