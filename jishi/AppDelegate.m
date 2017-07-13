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
#pragma mark 友盟广告统计
#import <AdSupport/ASIdentifierManager.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "OpenUDID.h"
#include <arpa/inet.h>
#include <ifaddrs.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AdSupport/AdSupport.h>
#import "RemindViewController.h"
#import "AppDelegate+JPush.h"
#import "AmountClassificationViewController.h"
#define umeng_appkey @"58ca428499f0c742bf000286"
@interface AppDelegate ()

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.window makeKeyAndVisible];
    [self registerJPush:application options:launchOptions];
    
    UMConfigInstance.appKey=umeng_appkey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setUmSocialAppkey:umeng_appkey];
    
    
    [self configUSharePlatforms];
    
    [AppDelegate requestTrackWithAppkey:umeng_appkey];
    
    
    
    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        //读取用户信息
        Context.currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:DOCUMENT_FOLDER(@"loginedUser")];
    }
    if (Context.currentUser.uid) {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           Context.currentUser.uid,@"user_id",
                           @"1",@"type",
                           nil];
        [[NetWorkManager sharedManager]postJSON:@"&m=business&a=record" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
    self.window.rootViewController = [UIViewController new];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       appcode,@"code",
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
            self.window.rootViewController=[AppDelegate setTabBarController];
            
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}
- (NSString *)getMacAddress {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        free(buf);
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    // MAC地址带冒号
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2),
                           *(ptr+3), *(ptr+4), *(ptr+5)];
    
    
    free(buf);
    
    return [outstring uppercaseString];
}
-(void)configUSharePlatforms
{
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106221516"/*设置QQ平台的appID*/  appSecret:@"JOVBDrWUDt0JIczB" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106221516"/*设置QQ平台的appID*/  appSecret:@"JOVBDrWUDt0JIczB" redirectURL:@"http://mobile.umeng.com/social"];
    //http://www.jishiyu007.com
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置微信的appKey和appSecret */
    /* 设置微信的appKey和appSecret */
    //    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxed7adf75b1686f8d" appSecret:@"db613640a7efb0c0b93241e5ef3f11ec" redirectURL:@"http://mobile.umeng.com/social"];
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
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLG"];
    RemindViewController*remind=[RemindViewController new];
    JishiyuViewController *jishiyu = [[JishiyuViewController alloc] init]; //未处理
    DaikuanViewController *treatVC = [[DaikuanViewController alloc] init]; //已处理
    FastHandleCardViewController *fastVC=[[FastHandleCardViewController alloc]init];
    AmountClassificationViewController *amount=[[AmountClassificationViewController alloc]init];

    MineViewController *mine=[[MineViewController alloc]init];
    //步骤2：将视图控制器绑定到导航控制器上
    BaseNC *nav1C = [[BaseNC alloc] initWithRootViewController:jishiyu];
    BaseNC *nav2C = [[BaseNC alloc] initWithRootViewController:treatVC];
    BaseNC *nav3C = [[BaseNC alloc] initWithRootViewController:fastVC];
    __unused   BaseNC *nav5C=[[BaseNC alloc]initWithRootViewController:remind];
    
    BaseNC *nav4C=[[BaseNC alloc]initWithRootViewController:mine];
    BaseNC *nav6C=[[BaseNC alloc]initWithRootViewController:amount];

    
    
    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    
    //改变tabBar的背景颜色
    UIView *barBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 49)];
    barBgView.backgroundColor = [UIColor whiteColor];
    [tabBarController.tabBar insertSubview:barBgView atIndex:0];
    tabBarController.tabBar.opaque = YES;
    NSArray *titles = @[@"贷款花",@"贷款超市",@"信用卡",@"个人中心"];
    NSArray *images=@[@"jishiyu",@"lending",@"lending",@"Mineing"];
    //    NSArray *images=@[@"jishiyu",@"Mineing"];
    //    NSArray *selectedImages=@[@"jishiyuBlue",@"MineingBlue"];
    //    NSArray *titles = @[@"贷款花",@"个人中心"];
    
    NSArray *selectedImages=@[@"jishiyuBlue",@"lendingBlue",@"lendingBlue",@"MineingBlue"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
        tabBarController.viewControllers=@[nav6C,nav4C];
        titles = @[@"贷款花",@"个人中心"];
        images=@[@"jishiyu",@"Mineing"];
        
        selectedImages=@[@"jishiyuBlue",@"lendingBlue",@"MineingBlue"];
    }
    else{
        tabBarController.viewControllers=@[nav1C,nav2C,nav3C,nav4C];
        titles = @[@"贷款花",@"贷款超市",@"信用卡",@"个人中心"];
        images=@[@"jishiyu",@"lending",@"lending",@"Mineing"];
        selectedImages=@[@"jishiyuBlue",@"lendingBlue",@"lendingBlue",@"MineingBlue"];
    }
    
    tabBarController.selectedIndex = 0; //默认选中第几个图标（此步操作在绑定viewControllers数据源之后）
    //        NSArray *titles = [[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[@"我来贷款王",@"个人中心"]:@[@"曹操贷款王",@"贷款",@"个人中心",@"设置"];
    //          NSArray *images=[[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[@"lending",@"Mineing"]:@[@"jishiyu",@"lending",@"Mineing"];
    //         NSArray *selectedImages=[[NSUserDefaults standardUserDefaults] boolForKey:@"review"]?@[
    //                                                                                                @"lendingBlue",@"MineingBlue"]:@[@"jishiyuBlue",@"lendingBlue",@"MineingBlue"];
    
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
+ (void)requestTrackWithAppkey:(NSString *)appkey
{
    if (!appkey || ![appkey length])
    {
        return;
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    CGFloat width = size_screen.width*scale_screen;
    CGFloat height = size_screen.height*scale_screen;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
        NSString *idfa = [asIM.advertisingIdentifier UUIDString];
        NSString *idfv = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSString *openudid = [OpenUDID value];
        NSString *mac = [self macString];
        NSString *os = @"ios";
        NSString *os_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *resolution = [NSString stringWithFormat:@"%d*%d",(int)height,(int)width];
        NSString *accessString = [self accessString];
        NSString *accessSubType = [self accessSubType];
        NSString *network_operater = [[self carrierString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // NSString *utdid = [UTDevice utdid];
        
        size_t size;
        // Set 'oldp' parameter to NULL to get the size of the data
        // returned so we can allocate appropriate amount of space
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        // Allocate the space to store name
        char *name = malloc(size);
        // Get the platform name
        sysctlbyname("hw.machine", name, &size, NULL, 0);
        // Place name into a string
        NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        // Done with this
        free(name);
        machine=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                      (CFStringRef)machine,
                                                                                      NULL,
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      kCFStringEncodingUTF8));
        mac=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                  (CFStringRef)mac,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8));
        NSString *requestURL = [[NSString alloc] initWithFormat:@"https://ar.umeng.com/stat.htm?ak=%@&device_name=%@&idfa=%@&openudid=%@&idfv=%@&mac=%@&os=%@&os_version=%@&resolution=%@&access=%@&access_subtype=%@&carrier=%@",appkey,machine,idfa,openudid,idfv,mac,os,os_version,resolution,accessString,accessSubType,network_operater];
        
        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (responseData)
        {
            //
            // NSLog(@"ok");
        }
    });
}



+ (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)accessString {
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]) {
        return @"WiFi";
    }
    
    if ([[self deviceModelString] isEqualToString:@"x86_64"]) {
        return @"WiFi";
    }
    
    if ([[self deviceModelString] isEqualToString:@"i386"]) {
        return @"WiFi";
    }
    
    
    BOOL success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    NSMutableArray *netArray = [[NSMutableArray alloc] init];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                [netArray addObject:name];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    
    if ([netArray containsObject:@"en0"]) {
        return @"WiFi";
    } else if ([netArray count] > 0 && ![netArray containsObject:@"en0"]) {
        return @"2G/3G";
    } else {
        return @"";
    }
}

+ (NSString *)carrierString {
    NSString *bundlePath = @"/System/Library/Frameworks/CoreTelephony.framework";
    NSBundle *telephonyNetworkInfoBundle = [NSBundle bundleWithPath:bundlePath];
    
    if (telephonyNetworkInfoBundle == nil) {
        return @"";
    } else{
        CTTelephonyNetworkInfo *netInfo = [[NSClassFromString(@"CTTelephonyNetworkInfo") alloc] init];
        if (netInfo == nil) {
            return @"";
            
        }else{
            CTCarrier *carrier = [netInfo subscriberCellularProvider];
            if (carrier.carrierName) {
                return carrier.carrierName;
            }
            return @"";
        }
        
    }
}
+ (NSString *)deviceModelString {
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    // Done with this
    free(name);
    
    return machine;
}

+ (NSString *)accessSubType
{
    NSString *accessSubType = @"";
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    if ([telephonyInfo respondsToSelector:@selector(currentRadioAccessTechnology)])
    {
        NSString *radioAccess = telephonyInfo.currentRadioAccessTechnology;
        if (![radioAccess isEqualToString:@""] && radioAccess!=nil)
        {
            if ([radioAccess hasPrefix:@"CTRadioAccessTechnology"])
            {
                accessSubType = [radioAccess substringFromIndex:23];
            }
            else
            {
                accessSubType = radioAccess;
            }
        }
    }
    return accessSubType;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
