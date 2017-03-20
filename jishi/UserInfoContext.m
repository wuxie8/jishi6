//
//  UserInfoContext.m
//  xiaoyixiu
//
//  Created by hanzhanbing on 16/6/17.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "UserInfoContext.h"

@implementation UserInfoContext

- (instancetype)init
{
    self  = [super init];
    if (self) {
        
        if (CGRectGetHeight(SCREEN_BOUNDS) <736) {
            _autoSizeScaleX = CGRectGetWidth(SCREEN_BOUNDS) / 414  ;
            _autoSizeScaleY =  CGRectGetHeight(SCREEN_BOUNDS) / 736 ;
        }
        else
        {
            _autoSizeScaleX = 1.0f;
            _autoSizeScaleY = 1.0f;
        }
        
        if(CGRectGetHeight(SCREEN_BOUNDS) > 568){
            _rectScaleX = SCREEN_BOUNDS.size.width/320;
            _rectScaleY = SCREEN_BOUNDS.size.height/568;
        }else{
            _rectScaleX = 1.0;
            _rectScaleY = 1.0;
        }
    }
    return self;
}

+ (UserInfoContext *)sharedContext
{
    static UserInfoContext *sharedContextInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedContextInstance = [[UserInfoContext alloc] init];
    });
    return sharedContextInstance;
}

@end
