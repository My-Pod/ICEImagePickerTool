//
//  ICEImagePickerTool.h
//  ICEImagePickerTool
//
//  Created by WLY on 16/7/6.
//  Copyright © 2016年 ICE. All rights reserved.
//
/**
 *  封装打开相册和相机的方法. 使用通知监听相册或者相机的弹出或者隐藏
 */

#import <Foundation/Foundation.h>

#define ICENotifactionNamePickerControlShowState @"ICENotifactionNamePickerControlShowState"

/**
 *  获取图片的回调
 *
 *  @param imageInfo @{@"errCod" : @(0/1), @"errMsg" : @"保存成功" , @"image" : image};
 */
typedef void (^GetImageBlock) (NSDictionary *imageInfo);


@interface ICEImagePickerTool : NSObject

/**
 *  类方法
 */
+ (instancetype)ICEImagePickerTool;



/**
 *  打开相册并获取照片 (默认的方式 , 等价于parments为空, 此时,不裁剪, 不设置其他参数)
 *
 *  @param completion 选择图片后的回调
 */
- (void)openPhotoAlbum:(GetImageBlock)completion;


/**
 *  打开相机, 拍照并获取图片 (不保存)
 *
 *  @param completion 拍照后返回照片
 */
- (void)openCamera:(GetImageBlock)completion;

/**
 *  打开相册
 *
 *  @param parments   对相册的一些参数
 *  @param completion 选择图片后的回调
 */
- (void)openPhotoAlbum:(NSDictionary *)parments
            completion:(GetImageBlock)completion;


/**
 *  打开相机, 拍照并获取照片
 *
 *  @param parments   对相册设置的一些参数
 *  @param completion 保存后的回调
 */
- (void)openCamera:(NSDictionary *)parments
        completion:(GetImageBlock)completion;




@end
