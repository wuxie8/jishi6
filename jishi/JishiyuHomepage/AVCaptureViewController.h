//
//  AVCaptureViewController.h
//  实时视频Demo
//
//  Created by zhongfeng1 on 2017/2/16.
//  Copyright © 2017年 zhongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVCaptureViewController : UIViewController

typedef void (^ImageBackBlock) (UIImage *image,NSString *direction);

@property (nonatomic,copy) ImageBackBlock refundBlock; //退款

@property(strong, nonatomic)NSString*direction;

@end

