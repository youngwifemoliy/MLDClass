//
//  MLDUMengShare.m
//  FootballApp
//
//  Created by Moliy on 2017/5/25.
//  Copyright © 2017年 North. All rights reserved.
//

#define UMengAppKey @"58b3e246734be476b7000d2f"

#define WeiboAppkey @"1503724035"
#define WeiboSecret @"4285acdb0e99927f55ede92e228eedd9"
#define WeiboUrl @"http://www.uhisports.com/"

#define WXAppID @"wx5d7a1e9d4f8edfb9"
#define WXAppSecret @"d4624c36b6795d1d99dcf0547af5443d"

#define QQAppKey @"1104867817"
#define QQAppSecret @"1a8Co08u1GM0CGUN"

#import "MLDUMengShare.h"

@implementation MLDUMengShare

+(instancetype)sharedMLDUMeng
{
    static MLDUMengShare *umengShare = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^
                  {
                      umengShare = [[self alloc] init];
                  });
    return umengShare;
}

- (void)initMLDUMengDidFinishLaunching
{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppKey];
    [self confitUShareSettings];
}

- (void)confitUShareSettings
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:WXAppID
                                       appSecret:WXAppSecret
                                     redirectURL:@"http://www.uhisports.com"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQAppKey/*设置QQ平台的appID*/
                                       appSecret:QQAppSecret
                                     redirectURL:@"http://www.uhisports.com"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:WeiboAppkey
                                       appSecret:WeiboSecret
                                     redirectURL:WeiboUrl];
}

- (void)setupShareDataWithTitle:(NSString *)title
               withContentText:(NSString *)contentText
                  withImage:(id)image
                       withUrl:(NSString *)url
{
    self.shareTitle = title;
    self.shareContentText = contentText;
    self.shareImage = image;
    self.shareUrl = url;
}

- (void)showMLDUMengUI:(UIViewController *)viewController
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),
                                               @(UMSocialPlatformType_QQ),
                                               @(UMSocialPlatformType_WechatSession),
                                               @(UMSocialPlatformType_WechatTimeLine)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
     {
         // 根据获取的platformType确定所选平台进行下一步操作
         if (self.shareUrl)
         {
             [self shareWebPageToPlatformType:platformType
                           withViewController:viewController];
         }
         else
         {
             [self shareImageToPlatformType:platformType
                         withViewController:viewController];
         }
     }];
}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
              withViewController:(UIViewController *)viewController
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"shareIcon"];
    [shareObject setShareImage:self.shareImage];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:viewController
                                           completion:^(id data, NSError *error)
     {
        if (error)
        {
            NSLog(@"************Share fail with error %@*********",error);
        }
        else
        {
            NSLog(@"response data is %@",data);
        }
    }];
}



- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                withViewController:(UIViewController *)viewController
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle
                                                                             descr:self.shareContentText
                                                                         thumImage:self.shareImage];
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType
                                        messageObject:messageObject
                                currentViewController:viewController
                                           completion:^(id data, NSError *error)
     {
        if (error)
        {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }
        else
        {
            if ([data isKindOfClass:[UMSocialShareResponse class]])
            {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }
            else
            {
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
             withCallBackBlock:(void(^)(UMSocialUserInfoResponse *userInfo))info
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType
                                        currentViewController:nil
                                                   completion:^(id result,NSError *error)
    {
        NSLog(@"友盟错误信息: %@",error);
        info(result);
        /*
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        UMSocialUserInfoResponse *resp = result;
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
         */
    }];
}

@end
