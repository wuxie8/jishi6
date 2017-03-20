//
//  LandingDynamicViewControllerViewController.h
//  jishi
//
//  Created by Admin on 2017/3/8.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Register)();

typedef void (^forgot)();

typedef void (^back)();
@interface LandingDynamicViewControllerViewController : UIViewController<UITextFieldDelegate>



@property (nonatomic,copy) Register registerblock;

@property(copy, nonatomic)forgot forgotblock;

@property(strong, nonatomic)back backblock;
@end
