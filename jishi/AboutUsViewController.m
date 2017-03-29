//
//  AboutUsViewController.m
//  jishi
//
//  Created by Admin on 2017/3/29.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"关于我们";
    self.view.backgroundColor=AppPageColor;
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,HEIGHT-64)];
    [image setImage:[UIImage imageNamed:@"About-Us"]];
    [self.view addSubview:image];
    
    
//    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(image.frame), WIDTH-40, HEIGHT-CGRectGetMaxY(image.frame))];
//    text.text=@"及时雨贷款成立于2016年7月，公司位于北京。及时雨贷款通过移动互联网和大数据应用技术，为用户提供线上纯信用贷款服务的平台。及时雨贷款全程线上操作、申请、审批，手续简便快捷，用户应急周转和线上消费的备用钱包。截至目前，及时雨APP累计注册用户50万人，入驻多家主流正规贷款机构，包括消费金融公司、小贷公司、汽车金融公司、 互联网金融公司等。商务合作";
//    [self.view addSubview:text];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
