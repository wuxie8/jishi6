//
//  IdVerificationViewController.h
//  haitian
//
//  Created by Admin on 2017/4/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "GestureNavBaseVC.h"
typedef void(^backBlock)();

@interface IdVerificationViewController : GestureNavBaseVC
@property(nonatomic, copy)backBlock clickBlock;

@end
