//
//  User.m
//  jishi
//
//  Created by Admin on 2017/3/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "User.h"

@implementation User

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.username forKey:@"username"];
   
}

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
       
    }
    return self;
}

@end
