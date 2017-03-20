//
//  NetWorkUtil.m
//  xiaoyixiu
//
//  Created by hanzhanbing on 16/6/14.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "NetWorkUtil.h"
#import "AppDelegate.h"
@implementation NetWorkUtil

static NetWorkUtil* _instance;
+ (NetWorkUtil *)sharedInstance
{
    static dispatch_once_t predicate ;
    dispatch_once(&predicate , ^{
        _instance = [[NetWorkUtil alloc] init];
    });
    return _instance;
}

+ (NetWorkType )currentNetWorkStatus
{
    NetWorkType nNetWorkType = NET_UNKNOWN; //默认无网
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType= [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            if (netType == 0) {
                //无网
                nNetWorkType = NET_UNKNOWN;
            }
            if (netType == 1) {
                //2G
                nNetWorkType = NET_2G;
            }
            if (netType == 2) {
                //3G
                nNetWorkType = NET_3G;
            }
            if (netType == 3) {
                //4G
                nNetWorkType = NET_4G;
            }
            if (netType == 1 || netType == 2 || netType == 3) {
                //移动网络
                nNetWorkType = NET_WWAN;
            }
            if (netType == 5) {
                //WiFi
                nNetWorkType = NET_WIFI;
            }
        }
    }
    

    return nNetWorkType;
}

- (void)listening
{
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
}

- (void)networkChanged:(NSNotification *)note
{
    if ([NetWorkUtil currentNetWorkStatus]==NET_UNKNOWN) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetDisAppear" object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNetAppear" object:nil];
    }
}

- (void)dealloc
{
    [GLobalRealReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
