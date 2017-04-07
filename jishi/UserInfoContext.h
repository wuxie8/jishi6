//
//  UserInfoContext.h
//  xiaoyixiu
//
//  Created by hanzhanbing on 16/6/17.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"



@interface UserInfoContext : NSObject

//由大适配小的比例，masnory中用到
@property(nonatomic, assign) float autoSizeScaleX;
@property(nonatomic, assign) float autoSizeScaleY;

//由小适配大的比例，CGRectMake1中用到
@property(nonatomic, assign) float rectScaleX;
@property(nonatomic, assign) float rectScaleY;

//当前登录的用户
@property (nonatomic, strong) User *currentUser;

//该账户绑定的子用户
@property (nonatomic, strong) NSMutableArray *subUsers;

@property(assign, nonatomic)BOOL review;

@property (nonatomic, strong)NSString *longitude;//经度
@property (nonatomic, strong)NSString *latitude;//纬度
@property (nonatomic, strong)NSString *city;//城市

+ (UserInfoContext *)sharedContext; //单例

@end
