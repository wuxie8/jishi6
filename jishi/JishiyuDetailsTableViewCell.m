//
//  JishiyuDetailsTableViewCell.m
//  jishi
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "JishiyuDetailsTableViewCell.h"

@implementation JishiyuDetailsTableViewCell


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
