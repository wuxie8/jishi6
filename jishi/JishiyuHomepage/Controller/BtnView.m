//
//  BtnView.m
//  热门标签的自动换行
//
//  Created by shrek on 16/3/23.
//  Copyright © 2016年 shrek. All rights reserved.
//

#import "BtnView.h"

@implementation BtnView

+(UIView *)creatBtnWithArray:(NSArray *)titleArr frame:(CGRect)rect
{
    
    UIView *view=[[UIView alloc]initWithFrame:rect];
    
    view.backgroundColor = [UIColor whiteColor];
    int width = 0;
    int height = 0;
    int number = 0;
    int han = 0;
//    NSArray *titleArr = @[@"医德高尚",@"非常耐心"];
    
    //创建button
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 300 + i;
        [button setTitleColor:AppBlue forState:UIControlStateNormal];
    
        
        CGSize titleSize = [titleArr[i] boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        titleSize.width += 5;
        
     //自动的折行
        han = han +titleSize.width+10;
        if (han > view.frame.size.width) {
            han = 0;
            han = han + titleSize.width;
            height++;
            width = 0;
            width = width+titleSize.width;
            number = 0;
            button.frame = CGRectMake(10, 20*height, titleSize.width, 15);
        }else{
            button.frame = CGRectMake(width+(number*10),20*height, titleSize.width, 15);
            width = width+titleSize.width;
        }
        number++;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:AppBlue forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button.layer setBorderWidth:1];
        button.layer.borderColor=AppBlue.CGColor;
       
        if (height<2) {
            [view addSubview:button];
            
        }
      
    }
    if (height==0) {
        for (UIButton *btn in view.subviews) {
            CGRect rect=btn.frame;
            
            rect.size.height=30;
            btn.frame=rect;
        }
    }
   
    
    return view;
    
    
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
