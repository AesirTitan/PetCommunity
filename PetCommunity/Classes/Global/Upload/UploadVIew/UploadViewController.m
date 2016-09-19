//
//  UploadViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UploadViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface UploadViewController () <UITextViewDelegate>

// scroll view
@property (strong, nonatomic) UIScrollView *scrollView;
// input view
@property (strong, nonatomic) UITextView *textView;
// image view
@property (strong, nonatomic) UIImageView *imageV;
// type
@property (copy, nonatomic) NSString *mediaType;
// image
@property (strong, nonatomic) UIImage *image;
// url
@property (strong, nonatomic) NSURL *url;

@end

@implementation UploadViewController

- (instancetype)initWithPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (self = [super init]) {
        self.mediaType = info[UIImagePickerControllerMediaType];
        if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeImage]) {
            self.image = info[UIImagePickerControllerEditedImage];
            
        }else if ([info[UIImagePickerControllerMediaType] isEqualToString:(NSString *)kUTTypeMovie]){
            self.url = info[UIImagePickerControllerMediaURL];
        }else{
            NSLog(@"%@",info[UIImagePickerControllerMediaType]);  
        }
        
    }
    return self;
}
// self.image = info[UIImagePickerControllerEditedImage];
/* 此处info 有六个值
 * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
 * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
 * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
 * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
 * UIImagePickerControllerMediaURL;       // an NSURL
 * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
 * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
 */
// save image to doc
// [self saveImage:self.image withName:@"currentImage.png"];


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigation];
    [self setupScrollView];
    [self setupImageView];
    [self setupInputView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.picker removeFromSuperview];
}


// setup navigation
- (void)setupNavigation{
    // title
    self.navigationItem.title = @"发布";
    // right button
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem at_itemWithTitle:@"确定" style:UIBarButtonItemStyleDone action:^(id  _Nonnull sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"upload" object:@"发布成功！"];
        
        if ([self.mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        } else if ([self.mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            BOOL canbesaved =  UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([self.url path]);
            if (canbesaved) {
                // 将movie保存到相册
                UISaveVideoAtPathToSavedPhotosAlbum(self.url.path, self, @selector(videoSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
                
            }
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

// setup scroll view
- (void)setupScrollView{
    // init and add to superview
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    // style
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, kScreenH - 64);
    
}

// setup image view
- (void)setupImageView{
    // init and add to superview
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, kScreenW - 16, 240)];
    [self.scrollView addSubview:self.imageV];
    // style
    self.imageV.image = self.image;
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.clipsToBounds = YES;
    self.imageV.userInteractionEnabled = YES;
    
    [self.imageV at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        ATLogOBJ(@"tapped");
    }];
    [self.imageV at_addPinchGesture:nil handler:^(UIPinchGestureRecognizer * _Nonnull sender) {
        ATLogOBJ(@"pinch");
        sender.view.transform = CGAffineTransformScale(sender.view.transform, sender.scale, sender.scale);
        sender.scale = 1;
    }];
    [self.imageV at_addRotationGesture:nil handler:^(UIRotationGestureRecognizer * _Nonnull sender) {
        ATLogOBJ(@"rotation");
        sender.view.transform = CGAffineTransformRotate(sender.view.transform, sender.rotation);
        sender.rotation = 0;
    }];
    
}


// setup input view
- (void)setupInputView{
    // init and add to superview
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(8, self.imageV.bottom + 8, kScreenW - 16, self.scrollView.contentSize.height - self.imageV.bottom - 8)];
    [self.scrollView addSubview:self.textView];
    self.textView.delegate = self;
    self.textView.editable = YES;
    self.textView.text = @"说点什么吧！";
    self.textView.font = [UIFont systemFontOfSize:14];
   
    
    //    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 8, kScreenW - 16, 120)];
    //    [self.scrollView addSubview:self.textField];
    //    // style
    //    self.textField.placeholder = @"说点什么吧！";
    //    self.textField.font = [UIFont systemFontOfSize:14];
    
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"说点什么吧！"]) {
        textView.text = @"";
    }
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    imageName.docPath.save(imageData);
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    // 将图片写入文件
//    
//    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - 异步回调



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
