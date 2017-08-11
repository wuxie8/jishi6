//
//  PersonCell.m
//  BM
//
//  Created by yuhuajun on 15/7/13.
//  Copyright (c) 2015年 yuhuajun. All rights reserved.
//

#import "PersonCell.h"
#import "CDFInitialsAvatar.h"
@implementation PersonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellviewbackground"]];
        
        _tximg=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40,40)];
        [self.contentView addSubview:_tximg];
        
        _txtName=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 160, 25)];
        _txtName.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16];
        
        [self.contentView addSubview:_txtName];
        
        _phoneNum=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 160, 25)];
        _phoneNum.font=[UIFont fontWithName:@"STHeitiTC-Light" size:13];
        [self.contentView addSubview:_phoneNum];
        
    }
    return self;
}

-(void)setData:(PersonModel*)personDel;
{
    _tximg.image=personDel.image;
    _txtName.text=personDel.phonename;
    _phoneNum.text=personDel.tel;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
