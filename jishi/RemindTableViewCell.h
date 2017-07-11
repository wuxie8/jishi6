//
//  RemindTableViewCell.h
//  haitian
//
//  Created by Admin on 2017/5/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemindModel.h"
@interface RemindTableViewCell : UITableViewCell

@property(strong, nonatomic)UIImageView *image;

@property (nonatomic, strong) UILabel *imageNameLabel;


@property (nonatomic, strong) UILabel *dateLabel;
//申请人数
@property (nonatomic, strong) UILabel *dateDetailsLabel;

//还款
@property(strong, nonatomic)UILabel *reimbursementLabel;

//金额
@property(strong, nonatomic)UILabel *amountLabel;


//到期时间
@property(strong, nonatomic)UILabel *duetoLabel;

//姓名提示
@property(strong, nonatomic)UILabel *thenameLabel;


//姓名
@property(strong, nonatomic)UILabel *nameLabel;

-(void)setData:(ReminndListModel*)remindList;

@end
