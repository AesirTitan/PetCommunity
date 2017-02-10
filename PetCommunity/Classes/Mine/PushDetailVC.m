//
//  PushDetailVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "PushDetailVC.h"
// mine vc
#import "MyPetViewController.h"
#import "MyAlbumViewController.h"
#import "MyDraftViewController.h"
#import "MyCollectionViewController.h"
#import "SettingViewController.h"
// setting vc
#import "BlackListViewController.h"
#import "FeedbackViewController.h"
#import "ResetPswViewController.h"
#import "VersionViewController.h"
#import "ProtocolViewController.h"
#import "AboutViewController.h"



@implementation PushDetailVC

+ (void)mineVC:(UIViewController *)viewController pushViewControllerWithIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            MyPetViewController *vc = [[MyPetViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            MyAlbumViewController *vc = [[MyAlbumViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MyDraftViewController *vc = [[MyDraftViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            MyCollectionViewController *vc = [[MyCollectionViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            SettingViewController *vc = [[SettingViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        }
    }
}

+ (void)settingVC:(UIViewController *)viewController pushViewControllerWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BlackListViewController *vc = [[BlackListViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            FeedbackViewController *vc = [[FeedbackViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            ResetPswViewController *vc = [[ResetPswViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            VersionViewController *vc = [[VersionViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            ProtocolViewController *vc = [[ProtocolViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            AboutViewController *vc = [[AboutViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        }
    }
}


@end
