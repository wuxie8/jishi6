//
//  RegisterVC.h
//  jishi
//
//  Created by Admin on 2017/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "GestureNavBaseVC.h"
typedef void (^back)();

@interface RegisterVC : GestureNavBaseVC

@property(strong, nonatomic)back backblock;

@end
