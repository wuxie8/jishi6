//
//  JishiyuTableViewCell.m
//  jishi
//
//  Created by Admin on 2017/3/8.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "JishiyuTableViewCell.h"

@implementation JishiyuTableViewCell


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
    self.backgroundColor = [UIColor whiteColor];
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    _image.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.layer.cornerRadius=10;
    _image.layer.masksToBounds=YES;
    [self.contentView addSubview:_image];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+20, 20, 100, 20)];
    _titleLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
    _post_hits_Label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+20, 40, 200, 40   )];
    _post_hits_Label.font=[UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:_post_hits_Label];
    
    _feliv_Label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-160, 40, 120, 20)];
    [_feliv_Label setTextColor:[UIColor grayColor]];
    _feliv_Label.textAlignment=NSTextAlignmentRight;
    _feliv_Label.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:_feliv_Label];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 79, WIDTH-20, 1)];
    view.backgroundColor=[UIColor grayColor];
    view.alpha=0.3;
    
    [self.contentView addSubview:view];
}

-(void)setModel:(ProductModel *)model
{
    [self.image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_PATH,model.smeta]]];
//    [self.image setImage:[UIImage imageNamed:model.smeta]];
    [self.titleLabel setText:model.post_title];
    [self.feliv_Label setText:model.feilv];
    
    NSString *str=[NSString stringWithFormat:@"申请人数%@人",model.post_hits];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(4, [AttributedStr length]-4)];
    
   self.post_hits_Label.attributedText=AttributedStr;
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
