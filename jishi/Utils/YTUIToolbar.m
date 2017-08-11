//
//  YTUIToolbar.m
//  小依休
//
//  Created by yant on 15/12/23.
//  Copyright © 2015年 AnSaiJie. All rights reserved.
//

#import "YTUIToolbar.h"

@implementation YTUIToolbar
@dynamic delegate;

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    if (self) {
        self.barStyle = UIBarStyleBlack;
        self.alpha = 1;
        
        UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH - 74, 3, 74, 38)];
        [doneButton setTitleColor:AppThemeColor forState:UIControlStateNormal];
        [doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(ensureWithhiddenKeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneButton];
        
        UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 3, 74, 38)];
        [cancelButton setTitleColor:AppThemeColor forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelWithHiddenKeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
    }
    return self;
}

- (void)ensureWithhiddenKeyboardAction:(id)sender
{
    [self.delegate hiddenKeyboardAndEnsure];
}

- (void)cancelWithHiddenKeyboardAction:(id)sender
{
    [self.delegate hiddenKeyboardAndCancel];
}

@end
