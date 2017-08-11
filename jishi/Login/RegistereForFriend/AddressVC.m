//
//  AddressVC.m
//  小依休
//
//  Created by 吴公胜 on 16/3/11.
//  Copyright © 2016年 AnSaiJie. All rights reserved.
//

/**
 *  本机联系人列表页面
 *
 */

#import "AddressVC.h"
#import "InviteFriendsViewController.h"
@interface AddressVC ()

@property (strong, nonatomic) PersonModel *people;

@end

@implementation AddressVC
{
    UITableView *_tableShow;
    XHJAddressBook *_addBook;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"所有联系人";
    _sectionTitles=[NSMutableArray new];
    _tableShow=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    _tableShow.delegate=self;
    _tableShow.dataSource=self;
    [self.view addSubview:_tableShow];
    _tableShow.sectionIndexBackgroundColor=[UIColor clearColor];
    _tableShow.sectionIndexColor = [UIColor blackColor];
    _tableShow.tableFooterView = [[UIView alloc]init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [self setTitleList];
                          [_tableShow reloadData];
                      });
    });
    
}

//设置navigationBar
- (void)setNavigationBar
{
    self.title=@"快捷通话";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"lp_nav_goback"] style:UIBarButtonItemStylePlain target:self  action:@selector(back)];
    left.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=left;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)setTitleList
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    NSMutableArray * existTitles = [NSMutableArray array];
    for(int i=0;i<[_listContent count];i++)//过滤 就取存在的索引条标签
    {
        PersonModel *pm=_listContent[i][0];
        for(int j=0;j<_sectionTitles.count;j++)
        {
            if(pm.sectionNumber==j)
                [existTitles addObject:self.sectionTitles[j]];
        }
    }
    
    [self.sectionTitles removeAllObjects];
    self.sectionTitles =existTitles;
    
}

-(NSMutableArray*)listContent
{
    if(_listContent==nil)
    {
        _listContent=[NSMutableArray new];
    }
    return _listContent;
}
-(void)initData
{
    _addBook=[[XHJAddressBook alloc]init];
    self.listContent=[_addBook getAllPerson];
    if(_listContent==nil)
    {
        return;
    }
    
}
//几个  section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listContent count];
    
}
//对应的section有多少row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_listContent objectAtIndex:(section)] count];
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//section的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.sectionTitles==nil||self.sectionTitles.count==0)
        return nil;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    NSString *sectionStr=[self.sectionTitles objectAtIndex:(section)];
    [label setText:sectionStr];
    [contentView addSubview:label];
    return contentView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    PersonCell *personcell=(PersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(personcell==nil)
    {
        personcell=[[PersonCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdenfer];
    }
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    _people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    personcell.textLabel.text=_people.name1;
    personcell.detailTextLabel.text=_people.tel;

  
    return personcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    self.people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    InviteFriendsViewController *InviteFriends=[[ InviteFriendsViewController alloc]init];
    InviteFriends.tel=self.people.tel;
    [self.navigationController pushViewController:InviteFriends animated:YES];
}

//开启右侧索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
