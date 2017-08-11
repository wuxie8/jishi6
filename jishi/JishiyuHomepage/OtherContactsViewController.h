//
//  OtherContactsViewController.h
//  haitian
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "GestureNavBaseVC.h"

typedef void(^backBlock)();

@interface OtherContactsViewController : GestureNavBaseVC


@property(nonatomic, copy)backBlock clickBlock;
@end
