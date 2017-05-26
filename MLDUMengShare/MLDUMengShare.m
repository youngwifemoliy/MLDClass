//
//  MLDUMengShare.m
//  FootballApp
//
//  Created by Moliy on 2017/5/25.
//  Copyright © 2017年 North. All rights reserved.
//

#define UMengAppKey @"590aac982ae85b4b9d0000e9"
#define WeiboAppkey @"3067827634"
#define weiboSecret @"3e1d887cdcda815e1c54cbaa10e215c4"

#define WXAppID @"wx35ae0d64b9945b87"
#define WXAppSecret @"3fb15027cf3759ecbf8ad94db481ac56"

#define QQAppKey @"1105611036"
#define QQAppSecret @"cDxI9hws694WVJO0"


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
                                       appSecret:weiboSecret
                                     redirectURL:@"https://api.weibo.com/oauth2/default.html"];
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
                                               @(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo)
     {
         // 根据获取的platformType确定所选平台进行下一步操作
         [self shareWebPageToPlatformType:platformType
                       withViewController:viewController];
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

@end
