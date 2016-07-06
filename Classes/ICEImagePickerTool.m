//
//  ICEImagePickerTool.m
//  ICEImagePickerTool
//
//  Created by WLY on 16/7/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ICEImagePickerTool.h"
#import <UIKit/UIKit.h>
#import "ICEPhotoLibrary.h"

//为了管理当前对象的生命周期
typedef  void (^RetainBlock) ();


@interface ICEImagePickerTool () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) GetImageBlock cameraBlock;
@property (nonatomic, copy) GetImageBlock photoAlbumBlock;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, copy) RetainBlock retainBlock;

@end

@implementation ICEImagePickerTool

+ (instancetype)ICEImagePickerTool{
    return [[ICEImagePickerTool alloc] init];
}

- (void)dealloc{
    _cameraBlock = nil;
    _photoAlbumBlock = nil;
}

#pragma mark - 从 相册/相机 获取图片

- (void)p_pushNotifaction:(BOOL)state{
    [[NSNotificationCenter defaultCenter] postNotificationName:ICENotifactionNamePickerControlShowState object:self userInfo:@{@"state" : @(state)}];
}


- (void)p_openCamearOnViewConreoller:(NSDictionary *)parments{
    
    [self p_pushNotifaction:YES];
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        if (_picker) {
            _picker = nil;
        }
        
        self.picker = [[UIImagePickerController alloc] init];
        //设置拍照后的图片可被编辑
        self.picker.allowsEditing = NO;
        //资源类型为照相机
        self.picker.sourceType = sourceType;
        self.picker.delegate = self;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        
        //此处引入保留环, 保证 self 不被释放
        self.retainBlock = ^(){
            NSLog(@"%@",self);
        };
        
#pragma clang diagnostic pop
        
        
        
        [[ICEImagePickerTool presentViewController] presentViewController:self.picker animated:YES completion:^{
        }];
    }else {
        NSLog(@"该设备无摄像头");
    }
    
    
}

- (void)p_showImagePictureOnViewController:(NSDictionary *)parments{
    
    [self p_pushNotifaction:YES];
    if (_picker) {
        _picker = nil;
    }
    
    self.picker = [[UIImagePickerController alloc] init];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    
    //此处引入保留环, 保证 self 不被释放
    self.retainBlock = ^(){
        NSLog(@"%@",self.picker);
    };
    
#pragma clang diagnostic pop
    
    
    //资源类型为图片库
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置选择后的图片可被编辑
    self.picker.allowsEditing = NO;
    self.picker.delegate = self;
    
    [[ICEImagePickerTool presentViewController] presentViewController:self.picker animated:YES completion:^{
    }];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *key = UIImagePickerControllerOriginalImage;
//    拍照时 保存照片
    if (picker.sourceType == 1) {
    
        UIImage *image = info[key] ;
        
        //保存照片
        [ICEPhotoLibrary saveImage:image toAlbum:@"ICE" success:^(NSString *imageURL) {
            self.cameraBlock( @{@"errCode" : @(1), @"errMsg" : @"保存成功",@"imageURL":imageURL});
            _retainBlock = nil; //解除保留环, 释放对象
            
        } failure:^ (NSString *errMsg){
            self.cameraBlock( @{@"errCode" : @(1), @"errMsg" : @"保存失败"});
            _retainBlock = nil; //解除保留环, 释放对象
        }];
        
    }else{
        
        NSURL *url = info[@"UIImagePickerControllerReferenceURL"];
        NSString *urlStr = url.absoluteString;
        self.photoAlbumBlock( @{@"errCode" : @(1), @"errMsg" : @"保存成功",@"imageURL":urlStr});
        _retainBlock = nil; //解除保留环, 释放对象
        
    }
    
    [self p_pushNotifaction:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self p_pushNotifaction:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)openCamera:(GetImageBlock)completion{
    self.cameraBlock = completion;
    [self p_openCamearOnViewConreoller:nil];
}

- (void)openCamera:(NSDictionary *)parments completion:(GetImageBlock)completion{
    self.cameraBlock = completion;
    [self p_openCamearOnViewConreoller:parments];
}

- (void)openPhotoAlbum:(GetImageBlock)completion{
    self.photoAlbumBlock = completion;
    [self p_showImagePictureOnViewController:nil];
}

- (void)openPhotoAlbum:(NSDictionary *)parments completion:(GetImageBlock)completion{
    self.photoAlbumBlock = completion;
    [self p_showImagePictureOnViewController:parments];
}


+ (UIViewController *)presentViewController{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}



@end
