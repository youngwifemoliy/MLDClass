//
//  MLDShareSDK.h
//  FootballApp
//
//  Created by Moliy on 2017/5/25.
//  Copyright © 2017年 North. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

//人人SDK头文件
#import <RennSDK/RennSDK.h>

@interface MLDShareSDK : NSObject

/**单例*/
+(instancetype)sharedMLDShareSDK;

/**didFinish初始化*/
- (void)initShareSDKWithDidFinishLaunching;

/**
 分享页面调用

 @param title 标题
 @param contentText 内容
 @param url 分享地址
 @param view ipad的View
 */
- (void)shareSDKTitle:(NSString *)title
          withContent:(NSString *)contentText
              withUrl:(NSString *)url
             withView:(UIView *)view;
@end
