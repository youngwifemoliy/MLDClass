//
//  ImageCompress.h
//  Photo
//
//  Created by Moliy on 2017/3/21.
//  Copyright © 2017年 Moliy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ImageCompress : NSObject

/**
 压缩图片到指定byte

 @param image 图片
 @param maxLength 最大的byte值
 @return 输出图片(UIImage)
 */
+ (UIImage *)compressImage:(UIImage *)image
                    toByte:(NSUInteger)maxLength;
@end
