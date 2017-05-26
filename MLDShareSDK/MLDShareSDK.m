//
//  MLDShareSDK.m
//  FootballApp
//
//  Created by Moliy on 2017/5/25.
//  Copyright © 2017年 North. All rights reserved.
//
#define ShareSKDAppKey @"1e28ccd36237e"
#define WeiboAppkey @"3067827634"
#define weiboSecret @"3e1d887cdcda815e1c54cbaa10e215c4"

#define WXAppID @"wx35ae0d64b9945b87"
#define WXAppSecret @"3fb15027cf3759ecbf8ad94db481ac56"

#define QQAppKey @"1105611036"
#define QQAppSecret @"cDxI9hws694WVJO0"

#import "MLDShareSDK.h"

@implementation MLDShareSDK
+(instancetype)sharedMLDShareSDK
{
    static MLDShareSDK *shareSKD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^
    {
        shareSKD = [[self alloc] init];
    });
    return shareSKD;
}

- (void)initShareSDKWithDidFinishLaunching
{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:ShareSKDAppKey
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
    {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
    }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
    {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:WeiboAppkey
                                          appSecret:weiboSecret
                                        redirectUri:@"https://api.weibo.com/oauth2/default.html"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:WXAppID
                                      appSecret:WXAppSecret];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQAppKey
                                     appKey:QQAppSecret
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
    }];
}

- (void)shareSDKTitle:(NSString *)title
          withContent:(NSString *)contentText
              withUrl:(NSString *)url
             withView:(UIView *)view
{

    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareSDKIcon.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray)
    {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:contentText
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:view //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end)
        {
            switch (state)
            {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        }];
    }
}
@end
