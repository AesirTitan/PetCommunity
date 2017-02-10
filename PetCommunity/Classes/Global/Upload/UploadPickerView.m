//
//  UploadPickerView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UploadPickerView.h"
#import "UploadViewController.h"
#import <MediaPlayer/MediaPlayer.h> 
#import <MobileCoreServices/MobileCoreServices.h>  



@interface UploadPickerView () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
// image picker
@property (strong, nonatomic) UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIView *albumView;

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (weak, nonatomic) IBOutlet UIView *cancelView;

@property (weak, nonatomic) IBOutlet UIImageView *cancelImage;

// cancel
@property (copy, nonatomic) void (^albumAction)();

// cancel
@property (copy, nonatomic) void (^photoAction)();

// cancel
@property (copy, nonatomic) void (^videoAction)();

// cancel
@property (copy, nonatomic) void (^cancelAction)();

// UploadViewController
@property (strong, nonatomic) UploadViewController *uploadVC;

// touch location
@property (assign, nonatomic) CGPoint location;

@end

@implementation UploadPickerView

typedef NS_ENUM(NSUInteger,PickType){
    PickTypePhotoLibrary,
    PickTypeCamera,
    PickTypeVideo,
};

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupBlurView];
    [self setupMaskView];
    [self setupTapAction];
    
    self.cancelImage.transform = CGAffineTransformMakeRotation(-0.5*M_PI);
    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.cancelImage.transform = CGAffineTransformMakeRotation(-0.25*M_PI);
        self.maskView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
   
}

// setup blur view
- (void)setupBlurView{
    // init and add to superview
    // blur view
    UIVisualEffect *ve = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *vev = [[UIVisualEffectView alloc] initWithFrame:self.bounds];
    vev.effect = ve;
    [self insertSubview:vev atIndex:0];
    
}

// setup mask view
- (void)setupMaskView{
    // init and add to superview
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 270, 270)];
    mask.backgroundColor = [UIColor whiteColor];
    mask.layer.at_maskToCircle();
    mask.centerX = self.centerX;
    mask.centerY = self.height - 24.5;
    mask.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.maskView = mask;
}

// setup tap action
- (void)setupTapAction{
    // init and add to superview
    
    [self.albumView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        if (self.albumAction) {
            self.albumAction();
        }
        self.location = [sender locationInView:self];
        [self showPickerWith:PickTypePhotoLibrary];
    }];
    [self.photoView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        if (self.photoAction) {
            self.photoAction();
        }
        self.location = [sender locationInView:self];
        [self showPickerWith:PickTypeCamera];
    }];
    [self.videoView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        if (self.videoAction) {
            self.videoAction();
        }
        self.location = [sender locationInView:self];
        [self showPickerWith:PickTypeVideo];
    }];
    
    [self.cancelView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        if (self.cancelAction) {
            self.cancelAction();
        }
        [self animatedHideView];
    }];
    [self at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self animatedHideView];
    }];
    
}


- (void)tappedAlbumView:(void(^)())action {
    self.albumAction = action;
}

- (void)tappedPhotoView:(void(^)())action {
    self.photoAction = action;
}

- (void)tappedVideoView:(void(^)())action {
    self.videoAction = action;
}

- (void)tappedCancel:(void(^)())action {
    self.cancelAction = action;
}

- (void)animatedHideView{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.cancelImage.transform = CGAffineTransformIdentity;
        self.maskView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)showPickerWith:(PickType)type{
    CGPoint point = self.location;
    point.y += kScreenH - self.height;
    self.location = point;
    
    switch (type) {
        case PickTypePhotoLibrary: {
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.picker.mediaTypes = @[(NSString *)kUTTypeImage,(NSString *)kUTTypeMovie];
            break;
        }
        case PickTypeCamera: {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.mediaTypes = @[(NSString *)kUTTypeImage];
            self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            break;
        }
        case PickTypeVideo: {
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.mediaTypes = @[(NSString *)kUTTypeMovie];
            self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            self.picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            break;
        }
    }
    [self _showPicker];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.picker dismissViewControllerAnimated:NO completion:nil];
    UploadViewController *vc = [[UploadViewController alloc] initWithPickingMediaWithInfo:info];
    vc.picker = self;
    [self.controller.navigationController pushViewController:vc animated:YES];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}


- (void)_showPicker{
    [self.controller.view addSubview:self.picker.view];
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    mask.backgroundColor = [UIColor whiteColor];
    mask.layer.at_maskToCircle();
    self.picker.view.maskView = mask;
    self.picker.view.maskView.center = self.location;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.picker.view.maskView.transform = CGAffineTransformMakeScale(34, 34);
        self.picker.view.maskView.center = self.controller.view.center;
    } completion:^(BOOL finished) {
        [self.controller presentViewController:self.picker animated:NO completion:nil];
    }];
}

- (UIImagePickerController *)picker{
    if (!_picker) {
        // create it
        _picker = [[UIImagePickerController alloc]init];
        // do something...
        _picker.view.backgroundColor = atColor.theme;
        _picker.delegate = self;
        _picker.allowsEditing = YES;
        
    }
    return _picker;
}

@end
