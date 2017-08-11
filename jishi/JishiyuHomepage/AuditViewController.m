//
//  AuditViewController.m
//  jishi
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AuditViewController.h"

@interface AuditViewController ()

@end

@implementation AuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"审核状态";
    UIImageView*image=  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    image.image=[UIImage imageNamed:@"ReviewStatus"];
    [self.view addSubview:image];
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
