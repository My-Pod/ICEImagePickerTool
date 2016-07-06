//
//  ViewController.m
//  ICEImagePickerTool
//
//  Created by WLY on 16/7/6.
//  Copyright © 2016年 ICE. All rights reserved.
//

#import "ViewController.h"
#import "ICEImagePickerTool.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *camera = [UIButton buttonWithType:UIButtonTypeSystem];
    [camera setTitle:@"打开相机" forState:UIControlStateNormal];
    [camera addTarget:self action:@selector(openCamera:) forControlEvents:UIControlEventTouchUpInside];
    camera.frame = CGRectMake(100, 100, 100, 60);
    camera.backgroundColor = [UIColor redColor];
    [self.view addSubview:camera];
    
    
    UIButton *photoAlbum = [UIButton buttonWithType:UIButtonTypeSystem];
    [photoAlbum setTitle:@"打开相册" forState:UIControlStateNormal];
    [photoAlbum addTarget:self action:@selector(openPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    photoAlbum.frame = CGRectMake(100, 300, 100, 60);
    photoAlbum.backgroundColor = [UIColor blueColor];
    [self.view addSubview:photoAlbum];
    
}

- (void)openCamera:(UIButton *)sender {
    ICEImagePickerTool *pick = [ICEImagePickerTool ICEImagePickerTool];
    [pick openCamera:^(NSDictionary *imageInfo) {
        NSLog(@"%@",imageInfo);
    }];
}
- (void)openPhotoAlbum:(UIButton *)sender {
    ICEImagePickerTool *pick = [ICEImagePickerTool ICEImagePickerTool];
    [pick openPhotoAlbum:^(NSDictionary *imageInfo) {
        NSLog(@"%@",imageInfo);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
