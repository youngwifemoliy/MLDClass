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

/**初始化友盟*/
- (void)setupShareDataWithTitle:(NSString *)title
                withContentText:(NSString *)contentText
                      withImage:(id)image
                        withUrl:(NSString *)url;

/**展示分享弹窗*/
- (void)showMLDUMengUI:(UIViewController *)viewController;

/**三方登陆*/
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
             withCallBackBlock:(void(^)(UMSocialUserInfoResponse *userInfo))info;
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
