//
//  LeftMenuViewDemo.m
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200

#import "LeftMenuViewDemo.h"

@interface LeftMenuViewDemo ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong)UITableView    *contentTableView;

@end

@implementation LeftMenuViewDemo
{
    NSArray *titleArray;
    NSArray *imageArray;
}
 
-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return  self;
}

-(void)initView{

    self.backgroundColor = [UIColor whiteColor];
    //添加头部
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, 200)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    CGFloat width          = 90/2;
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(Frame_Width/2 - 35, 70, 70, 70)];
//    [imageview setBackgroundColor:[UIColor redColor]];
    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"avatar"]];
    [headerView addSubview:imageview];
    UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake(Frame_Width/2-50, CGRectGetMaxY(imageview.frame)+10, 100, 30)];
    
    [loginButton setTitle:@"立即登录" forState:0];
    [loginButton setTitle:Context.currentUser.username forState:0];
    [loginButton setTitleColor:kColorFromRGBHex(0x3c89fe) forState:0];
//    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    loginButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [loginButton setTintColor:kColorFromRGBHex(0x3c89fe)];
    [headerView addSubview:loginButton];
    
    width                  = 15;

  
    [self addSubview:headerView];
    

  imageArray=@[@"personal",@"Operator-1",@"address",@"BusinessCooperation",@"AboutUs",@"LoggedOut"];
    titleArray=@[@"个人资料",@"运营商验证",@"为好友注册",@"商务合作",@"关于我们",@"退出登陆"];
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.frame.size.height - headerView.frame.size.height - 50)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self addSubview:contentTableView];

}
-(void)loginClick{
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:-1];
    }
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];

    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];

    [cell.imageView setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
    [cell.textLabel setText:titleArray[indexPath.row]];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
    
}



@end
