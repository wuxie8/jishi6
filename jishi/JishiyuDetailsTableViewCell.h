//
//  JishiyuDetailsTableViewCell.h
//  jishi
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductModel.h"
@interface JishiyuDetailsTableViewCell : UITableViewCell



@property(strong, nonatomic)UIImageView *image;


@property (nonatomic, copy) UILabel *titleLabel;
//申请人数
@property (nonatomic, copy) UILabel *post_hits_Label;

//利率
@property(strong, nonatomic)UILabel *feliv_Label;

@property (nonatomic, strong)ProductModel *model;

@end
