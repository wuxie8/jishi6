//
//  BusinessViewController.m
//  jishi
//
//  Created by Admin on 2017/3/30.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BusinessViewController.h"


@interface BusinessViewController ()

@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"商务合作";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel  *companylabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-200, 100, 400, 100)];
    companylabel.text=@"公司:浙江海田网络科技有限公司";
    companylabel.textAlignment=NSTextAlignmentCenter;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-200, 250, 400, 100)];
    label.text=@"公司邮箱：bd@jishiyu11.cn";
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:companylabel];
    [self.view addSubview:label];


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
