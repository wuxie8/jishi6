//
//  GestureNavBaseVC.m
//  xiaoyixiu
//
//  Created by 柯南 on 16/6/13.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "GestureNavBaseVC.h"

@interface GestureNavBaseVC ()

@property(nonatomic, assign)CGFloat viewBottom;     //textField的底部

@end

@implementation GestureNavBaseVC
#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setupForKeyBoard];
}

#pragma mark -键盘相关
//键盘的准备
- (void)setupForKeyBoard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHideAction)];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //键盘显示后添加手势
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self.view addGestureRecognizer:tap];
        [self keyboardWillShow:note];
    }];
    
    //键盘消失后移除手势
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self.view removeGestureRecognizer:tap];
        
        //键盘动画时间
        double duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0,  0 , WIDTH, HEIGHT);
        }];
    }];
}

//键盘消失后view下移
- (void)keyBoardHideAction
{
    [self.view endEditing:YES];
}

//通过note获取键盘高度，键盘动画时间
- (void)keyboardWillShow:(NSNotification *)note
{
    //键盘高度
    CGFloat keyboardH = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //键盘动画时间
    double duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (self.viewBottom + keyboardH < HEIGHT) {
        return;
    }
    else
    {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, - ( keyboardH - (HEIGHT - self.viewBottom)), WIDTH, HEIGHT);
        }];
    }
}

#pragma mark - UITextFieldDelegate
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    CGRect rect = CGRectMake(0.0f, 20.0f, WIDTH, HEIGHT);
//    self.view.frame = rect;
//    [UIView commitAnimations];
//    [textField resignFirstResponder];
//    return YES;
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    CGRect frame = [textField.superview convertRect:textField.frame toView:self.view];
//    int offset = frame.origin.y + 32 - (HEIGHT- 280.0);//键盘高度216
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    if(offset > 0)
//    {
//        CGRect rect = CGRectMake(0.0f, -offset,WIDTH,HEIGHT);
//        self.view.frame = rect;
//    }
//    [UIView commitAnimations];
//}
//
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
//    }];
//}

#pragma mark -UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //将textField的rect转换到self.view上
    CGRect rect = [textView.superview convertRect:textView.frame toView:self.view];
    
    //textField的底部
    self.viewBottom = rect.origin.y + rect.size.height;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
}

@end
