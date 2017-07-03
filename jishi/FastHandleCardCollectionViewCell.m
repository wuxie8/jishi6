//
//  FastHandleCardCollectionViewCell.m
//  haitian
//
//  Created by Admin on 2017/4/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "FastHandleCardCollectionViewCell.h"

@implementation FastHandleCardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.bankimageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-30, frame.size.height/8, 60,  frame.size.height/4)];
        self.bankimageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.bankimageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-40, frame.size.height/2, 80, frame.size.height/4-10)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.titleLabel];
        
        
        self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, frame.size.height/4*3-10, frame.size.width-20*2, frame.size.height/4)];
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
//        self.detailLabel.font=[UIFont systemFontOfSize:8];
        self.detailLabel.adjustsFontSizeToFitWidth=YES;
        self.detailLabel.textColor = [UIColor  blackColor];
        
        [self.contentView addSubview:self.detailLabel];
        
    }
    return self;
}


@end
