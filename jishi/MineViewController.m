//
//  MineViewController.m
//  jishiyu.com
//
//  Created by Admin on 2017/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "MineViewController.h"

#import "LoginViewController.h"
#define InitialHeight  64
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineViewController

{
    UIButton *but;
    UILabel *label;
    NSArray *arr;
    NSArray *imagesArr;
    UITableView *tab;
    UILabel *lab;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//     NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [tab reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    [tab reloadData];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"个人中心";
    
    self.view.backgroundColor=AppPageColor;
    
    arr=@[@"浏览记录",@"我的消息",@"设置"];
    imagesArr=@[@"BrowsingHistory",@"MyNews",@"SetUp"];
    
    [self loadTableview];
}
-(void)loadTableview
{
   tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) ];
    tab.delegate=self;
    tab.dataSource=self;
    tab.scrollEnabled=NO;
    tab.separatorInset = UIEdgeInsetsZero;
    tab.layoutMargins = UIEdgeInsetsZero;
    tab.tableFooterView=[[UIView alloc]init];
   
    [self.view addSubview:tab];

}


#define mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;          
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60   ;
        
    }
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1    ;
        
    }
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0)
        return 0;
    else
        return 20.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        [self denglu];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    static NSString *CellIdentifier                    = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
//  UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
//    if (!cell) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
//        cell.selectionStyle=   UITableViewCellSelectionStyleNone;
//          cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
//         cell.layoutMargins = UIEdgeInsetsZero;
//    }
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",indexPath.section]];
    cell.selectionStyle=   UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.layoutMargins = UIEdgeInsetsZero;
    if (indexPath.section==0) {
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 40, 40)];
        image.image=[UIImage imageNamed:@"HeadPortrait"];
        [cell.contentView addSubview:image];
        lab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+20, 10, 150, 40)];
        [lab setText:nil];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
           
            [lab setText:Context.currentUser.username];
        }
        else
        {
            [lab setText:@"点击登陆"];
        }
      
        [cell.contentView addSubview:lab];

    }
    else{
    cell.textLabel.text=arr[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:imagesArr[indexPath.row]]];
    }
    return cell;

}
-(void)loadInitView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 60)];
    view.backgroundColor=[UIColor whiteColor ];
    

    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    image.image=[UIImage imageNamed:@"Mine"];
    [view addSubview:image];
    
    label =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+20, 10, 300, 40)];
    [view addSubview:label];
    but=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+20, WIDTH, 40)];
    
    [but addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor=[UIColor whiteColor];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:view];
    [self.view addSubview:but];
}
-(void)denglu
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kIsLogin"];
    
     Context.currentUser = nil;
        //用户信息归档
        [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")];
    }
       LoginViewController *login=[[LoginViewController alloc]init];
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
   
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
