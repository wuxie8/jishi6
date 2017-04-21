//
//  AppDelegate.m
//  jishi
//
//  Created by Admin on 2017/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "JishiyuViewController.h"
#import "DaikuanViewController.h"
#import "MineViewController.h"
#import "BaseNC.h"
#import "UMMobClick/MobClick.h"
#import <UMSocialCore/UMSocialCore.h>
#import "FastHandleCardViewController.h"
#define umeng_appkey @"58f9cb23ae1bf80811002194"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
      [self.window makeKeyAndVisible];
    
    UMConfigInstance.appKey=umeng_appkey;
     UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:umeng_appkey];


    [self configUSharePlatforms];
    

  

    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        //读取用户信息
        Context.currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:DOCUMENT_FOLDER(@"loginedUser")];
    }
   self.window.rootViewController = [UIViewController new];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       code,@"code",
                       @"1.0.0",@"version",
                      @"1",@"page",
                       nil];
    [[NetWorkManager sharedManager]postNoTipJSON:exchange parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"status"]boolValue]) {
            
          
            if ([UtilTools isBlankString:dic[@"review"]]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"review"];
            }else
            {
                [[NSUserDefaults standardUserDefaults] setBool:[dic[@"review"]boolValue] forKey:@"review"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.window.rootViewController=[AppDelegate setTabBarController];
                
            });
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    

    
  
    // Override point for customization after application launch.
    return YES;
}
-(void)configUSharePlatforms
{
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106092936"/*设置QQ平台的appID*/  appSecret:@"nr3dKzomEQBAoU7E" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106092936"/*设置QQ平台的appID*/  appSecret:@"nr3dKzomEQBAoU7E" redirectURL:@"http://mobile.umeng.com/social"];

    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置微信的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];

}
//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


+(UITabBarController *)setTabBarController
    {
    
    
        JishiyuViewController *jishiyu = [[JishiyuViewController alloc] init]; //未处理
       DaikuanViewController *treatVC = [[DaikuanViewController alloc] init]; //已处理
        FastHandleCardViewController *fastVC=[[FastHandleCardViewController alloc]init];
        MineViewController *mine=[[MineViewController alloc]init];
        //步骤2：将视图控制器绑定到导航控制器上
     BaseNC *nav1C = [[BaseNC alloc] initWithRootViewController:jishiyu];
     BaseNC *nav2C = [[BaseNC alloc] initWithRootViewController:treatVC];
        BaseNC *nav4C = [[BaseNC alloc] initWithRootViewController:fastVC];

        BaseNC *nav3C=[[BaseNC alloc]initWithRootViewController:mine];
     
        
        
        UITabBarController *tabBarController=[[UITabBarController alloc]init];
        
        //改变tabBar的背景颜色
        UIView *barBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
        barBgView.backgroundColor = [UIColor whiteColor];
        [tabBarController.tabBar insertSubview:barBgView atIndex:0];
        tabBarController.tabBar.opaque = YES;
       
        tabBarController.viewControllers=[[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[nav2C,nav4C,nav3C]:@[nav1C,nav2C,nav3C];
//        tabBarController.viewControllers=@[nav1C,nav2C,nav3C];
        tabBarController.selectedIndex = 0; //默认选中第几个图标（此步操作在绑定viewControllers数据源之后）
        NSArray *titles = [[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[@"仓鼠贷",@"快速办卡",@"个人中心"]:@[@"仓鼠贷",@"贷款",@"个人中心",@"设置"];
          NSArray *images=[[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[@"lending",@"FastHandleCard",@"Mineing"]:@[@"jishiyu",@"lending",@"Mineing"];
         NSArray *selectedImages=[[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[
                                                                                                @"lendingBlue",@"FastHandleCardHeight",@"MineingBlue"]:@[@"jishiyuBlue",@"lendingBlue",@"MineingBlue"];
//         NSArray *images=@[@"jishiyu",@"lending",@"Mineing"];
//         NSArray *selectedImages=@[@"jishiyuBlue",@"lendingBlue",@"MineingBlue"];
//               NSArray *titles = @[@"简单借款秒借版",@"个人中心",@"设置"];
//        NSArray *images=@[@"lending",@"Mineing"];
//         NSArray *selectedImages=@[@"lendingBlue",@"MineingBlue"];
       
        //绑定TabBar数据源
        for (int i = 0; i<tabBarController.tabBar.items.count; i++) {
            UITabBarItem *item = (UITabBarItem *)tabBarController.tabBar.items[i];
            item.title = titles[i];
                    item.image = [[UIImage imageNamed:[images objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    item.selectedImage = [[UIImage imageNamed:[selectedImages objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            tabBarController.tabBar.tintColor = [UIColor blueColor];
        }
        return  tabBarController;
    }

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
