//
//  PhotoBrowserVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-07.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "PhotoBrowserVC.h"
#import <Photos/Photos.h>
#import "MWPhotoBrowser.h"

@interface PhotoBrowserVC () <MWPhotoBrowserDelegate>

// photos
@property (strong, nonatomic) NSMutableArray<MWPhoto *> *photos;

@end

@implementation PhotoBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)vc:(UIViewController *)vc showBrowserControllerWithImage:(NSString *)image url:(NSString *)url point:(CGPoint)point{
    [[[self alloc] init] vc:vc showBrowserControllerWithImage:image url:url point:point];
}

- (void)vc:(UIViewController *)vc showBrowserControllerWithImage:(NSString *)image url:(NSString *)url point:(CGPoint)point{
    // Single video
    MWPhoto *photo;
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    photo = [MWPhoto photoWithURL:[NSURL URLWithString:image]];
    if (url.length) {
        photo.videoURL = [NSURL URLWithString:url];
    }
    [photos addObject:photo];
    self.photos = [NSMutableArray arrayWithArray:photos];
    
    MWPhotoBrowser *browser = [self _showFromVC:vc point:point];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        browser.view.maskView.transform = CGAffineTransformMakeScale(34, 34);
        browser.view.maskView.center = browser.view.center;
    } completion:^(BOOL finished) {
        [vc presentViewController:browser animated:NO completion:nil];
    }];
    
    
    [browser.view at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [browser dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

+ (void)vc:(UIViewController *)vc showBrowserControllerWithLocalImage:(UIImage *)image description:(NSString *)desc point:(CGPoint)point{
    [[[self alloc] init] vc:vc showBrowserControllerWithLocalImage:image description:desc point:point];
}

- (void)vc:(UIViewController *)vc showBrowserControllerWithLocalImage:(UIImage *)image description:(NSString *)desc point:(CGPoint)point{
    // Photos
    MWPhoto *photo;
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    
    photo = [MWPhoto photoWithImage:image];
    photo.caption = desc;
    [photos addObject:photo];
    self.photos = [NSMutableArray arrayWithArray:photos];
    
    MWPhotoBrowser *browser = [self _showFromVC:vc point:point];
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        browser.view.maskView.transform = CGAffineTransformMakeScale(34, 34);
        browser.view.maskView.center = browser.view.center;
    } completion:^(BOOL finished) {
        
    }];
    
    
    [browser.view at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        CGPoint location = [sender locationInView:sender.view];
        location = [sender.view convertPoint:location toView:vc.view];
        [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            browser.view.maskView.transform = CGAffineTransformMakeScale(0.1, 0.1);
            browser.view.maskView.center = location;
        } completion:^(BOOL finished) {
            [browser.view removeFromSuperview];
        }];
    }];
}



- (MWPhotoBrowser *)_showFromVC:(UIViewController *)vc point:(CGPoint)point{
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.view.backgroundColor = atColor.black;
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = YES;
    browser.alwaysShowControls = YES;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = YES;
    [browser setCurrentPhotoIndex:0];
    
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    mask.backgroundColor = [UIColor whiteColor];
    mask.layer.at_maskToCircle();
    browser.view.maskView = mask;
    browser.view.maskView.center = point;
    [vc.view addSubview:browser.view];
    
    return browser;

}


#pragma mark - private methods

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return 1;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photos.count)
        return self.photos[index];
    return nil;
}



@end
