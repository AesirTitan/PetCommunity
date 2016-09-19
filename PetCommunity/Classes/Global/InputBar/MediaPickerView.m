//
//  MediaPickerView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-07.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MediaPickerView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface MediaPickerView () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

// image picker
@property (strong, nonatomic) UIImagePickerController *picker;

// image
@property (copy, nonatomic) void (^imageBlock)(UIImage *);
// image
@property (copy, nonatomic) void (^audioBlock)(NSURL *);
// image
@property (copy, nonatomic) void (^photoBlock)(UIImage *);
// image
@property (copy, nonatomic) void (^videoBlock)(NSURL *);

@end

@implementation MediaPickerView


typedef NS_ENUM(NSUInteger,PickType){
    PickTypePhotoLibrary,
    PickTypeCamera,
    PickTypeVideo,
};

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.sendAudio.layer.at_maskToCircle();
    self.sendImage.layer.at_maskToCircle();
    self.sendPhoto.layer.at_maskToCircle();
    self.sendVideo.layer.at_maskToCircle();
    
    [self.sendAudio at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self showPickerWith:PickTypePhotoLibrary];
    }];
    [self.sendImage at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self showPickerWith:PickTypePhotoLibrary];
    }];
    [self.sendPhoto at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self showPickerWith:PickTypeCamera];
    }];
    [self.sendVideo at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self showPickerWith:PickTypeVideo];
    }];
    
}


- (void)showPickerWith:(PickType)type{
    
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
    
    // image
    if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeImage]) {
        // send image
        if (self.imageBlock) {
            self.imageBlock(info[UIImagePickerControllerEditedImage]);
        }
        // cache
    }
    
    // video
    else if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeMovie]){
        // send video
        if (self.videoBlock) {
            self.videoBlock(info[UIImagePickerControllerMediaURL]);
        }
        // cache
        BOOL canbesaved =  UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([info[UIImagePickerControllerMediaURL] path]);
        if (canbesaved) {
            // 将movie保存到相册
            UISaveVideoAtPathToSavedPhotosAlbum([info[UIImagePickerControllerMediaURL] path], self, @selector(videoSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
            
        }
    }else{
        NSLog(@"%@",info[UIImagePickerControllerMediaType]);
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)_showPicker{
    [self.controller presentViewController:self.picker animated:YES completion:nil];
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



- (void)didFinishPickImage:(void(^)(UIImage *))image {
    self.imageBlock = image;
}

- (void)didFinishPickAudio:(void(^)(NSURL *))audio {
    self.audioBlock = audio;
}

- (void)didFinishPickPhoto:(void(^)(UIImage *))photo {
    self.photoBlock = photo;
}

- (void)didFinishPickVideo:(void(^)(NSURL *))video {
    self.videoBlock = video;
}


#pragma mark - private methods


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSLog(@"图片保存成功");
    }else{
        NSLog(@"图片保存不成功,error:%@",error);
    }
}

- (void)videoSavedToPhotosAlbum:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        NSLog(@"视频保存成功");
    }else{
        NSLog(@"视频保存不成功,error:%@",error);
    }
}






@end
