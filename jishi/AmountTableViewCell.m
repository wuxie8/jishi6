//
//  AmountTableViewCell.m
//  jishi
//
//  Created by Admin on 2017/3/29.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AmountTableViewCell.h"
#define  interval  30
@implementation AmountTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatHealthBroadcastCellUI];
    }
    return self;
}

-(void)creatHealthBroadcastCellUI
{
    
   
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 5, WIDTH-20, 110)];
    view.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:view];
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(60, 20, 30, 30)];
//    _image.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    
    [self.contentView addSubview:_image];
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 120, 60)];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.font= [UIFont boldSystemFontOfSize:16 ];
    [self.contentView addSubview:_titleLabel];
 
    _post_hits_Label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+interval , 30, 200, 20  )];
    _post_hits_Label.font=[UIFont systemFontOfSize:16];
    [_post_hits_Label setTextColor:[UIColor redColor]];
    _post_hits_Label.textAlignment=NSTextAlignmentLeft;


    [self.contentView addSubview:_post_hits_Label];
    
    _feliv_Label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame)+interval ,50, 200, 60)];
    [_feliv_Label setTextColor:[UIColor grayColor]];
  _feliv_Label.lineBreakMode = NSLineBreakByCharWrapping;//换行模式，与上面的计算保持一致。
    _feliv_Label.numberOfLines=0;
    _feliv_Label.textAlignment=NSTextAlignmentLeft;
    _feliv_Label.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_feliv_Label];
    
  
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
