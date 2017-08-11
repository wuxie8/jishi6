//
//  AppDelegate+JPush.h
//  SuperMarketStroe
//
//  Created by 柯南 on 16/9/21.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"

static NSString *pushAppKey = @"22cad97195dbc8ca77e227ed";
static NSString *pushChannel = @"douqianhua";
static BOOL isProduction = YES;

@interface AppDelegate (JPush)<JPUSHRegisterDelegate>
/**
 *  激光推送单类
 *
 *  @param application   应用
 *  @param launchOptions 需要传入的launchOptions
 */
-(void)registerJPush:(UIApplication *)application options:(NSDictionary *)launchOptions;
@end
