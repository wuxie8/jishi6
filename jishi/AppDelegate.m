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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    UMConfigInstance.appKey=@"58ca428499f0c742bf000286";
     UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        //读取用户信息
        Context.currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:DOCUMENT_FOLDER(@"loginedUser")];
    }
    
    self.window.rootViewController=[AppDelegate setTabBarController];
    // Override point for customization after application launch.
    return YES;
}
+(UITabBarController *)setTabBarController
    {
    
    
        JishiyuViewController *jishiyu = [[JishiyuViewController alloc] init]; //未处理
        DaikuanViewController *treatVC = [[DaikuanViewController alloc] init]; //已处理
        MineViewController *mine=[[MineViewController alloc]init];
        //步骤2：将视图控制器绑定到导航控制器上
        BaseNC *nav1C = [[BaseNC alloc] initWithRootViewController:jishiyu];
        BaseNC *nav2C = [[BaseNC alloc] initWithRootViewController:treatVC];
        BaseNC *nav3C=[[BaseNC alloc]initWithRootViewController:mine];
        
        
        
        UITabBarController *tabBarController=[[UITabBarController alloc]init];
        
        //改变tabBar的背景颜色
        UIView *barBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
        barBgView.backgroundColor = [UIColor whiteColor];
        [tabBarController.tabBar insertSubview:barBgView atIndex:0];
        tabBarController.tabBar.opaque = YES;

        tabBarController.viewControllers=@[nav1C,nav2C,nav3C];
        tabBarController.selectedIndex = 0; //默认选中第几个图标（此步操作在绑定viewControllers数据源之后）
        NSArray *titles = @[@"及时雨",@"贷款",@"我",@"设置"];
        NSArray *images=@[@"jishiyu",@"lending",@"Mineing"];
        NSArray *selectedImages=@[@"jishiyuBlue",@"lendingBlue",@"MineingBlue"];
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
