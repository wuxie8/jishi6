//
//  OptionBarController.h
//  SuperMarket
//
//  Created by hanzhanbing on 16/7/15.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionBarController : UIViewController

@property (nonatomic,assign)BOOL showLineView;//分割线
@property (nonatomic,strong)NSArray *controllersArr;
@property (nonatomic,strong)UIColor *linecolor;

typedef void(^SegmentClickBlock)(NSInteger currentIndex);
@property(nonatomic, copy)SegmentClickBlock clickBlock;

- (instancetype)initWithSubViewControllers:(NSArray *)controllersArr andParentViewController:(UIViewController *)viewController andshowSeperateLine:(BOOL) showSeperateLine;

@end
