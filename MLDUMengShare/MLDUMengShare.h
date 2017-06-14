//
//  MLDUMengShare.h
//  FootballApp
//
//  Created by Moliy on 2017/5/25.
//  Copyright © 2017年 North. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface MLDUMengShare : NSObject


@property (nonatomic,copy) NSString *shareTitle;
@property (nonatomic,copy) NSString *shareContentText;
@property (nonatomic,strong) id shareImage;
@property (nonatomic,copy) NSString *shareUrl;

/**单例*/
+(instancetype)sharedMLDUMeng;
/**初始化友盟*/
- (void)initMLDUMengDidFinishLaunching;

- (void)setupShareDataWithTitle:(NSString *)title
                withContentText:(NSString *)contentText
                      withImage:(id)image
                        withUrl:(NSString *)url;

- (void)showMLDUMengUI:(UIViewController *)viewController;
@end


/*---------app回调需要复制到AppDelegate.m
 // 支持所有iOS系统
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
 //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
 BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url
 sourceApplication:sourceApplication
 annotation:annotation];
 if (!result) {
 // 其他如支付等SDK的回调
 }
 return result;
 }
*/

//--------------分享面板无法弹出
/*
由于 
 1. 创建Xcode项目会默认添加Main.storyboard作为Main Interface(General - Deployment Info)，也就是项目的主Window。
 2. 如果没使用Main.storyboard而又另外在AppDelegate中创建了UIWindow对象，如

self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds]

如果项目中同时出现Main Interface以及代码创建UIWindow会导致分享面板无法正常弹出，解决方法是移除其一即可。如果移除了Main.storyboard，需要clean工程后再重新运行。
*/

