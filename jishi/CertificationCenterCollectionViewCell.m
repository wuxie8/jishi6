//
//  CertificationCenterCollectionViewCell.m
//  jishi
//
//  Created by Admin on 2017/8/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CertificationCenterCollectionViewCell.h"

@implementation CertificationCenterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGSize size=frame.size;
        self.bankimageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, size.width-40,  size.width-40)];
        self.bankimageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.bankimageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bankimageView.frame), size.width, 40)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor blackColor];
//        self.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.titleLabel];
        
        
    }
    return self;
}



@end
