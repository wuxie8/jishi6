//
//  AddressBookVC.m
//  小依休
//
//  Created by 吴公胜 on 16/2/25.
//  Copyright © 2016年 AnSaiJie. All rights reserved.
//

#import "AddressBookVC.h"

@interface AddressBookVC ()

@property (strong, nonatomic) PersonModel *people;

@end

@implementation AddressBookVC
{
    UITableView *_tableShow;
    XHJAddressBook *_addBook;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"所有联系人";
    _sectionTitles=[NSMutableArray new];
    _tableShow=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _tableShow.delegate=self;
    _tableShow.dataSource=self;
    [self.view addSubview:_tableShow];
    _tableShow.sectionIndexBackgroundColor=[UIColor clearColor];
    _tableShow.sectionIndexColor = [UIColor blackColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [self setTitleList];
                          [_tableShow reloadData];
                      });
    });

}
-(void)addContact:(NSString *)photo
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:photo, @"MobilePhone",
                         nil];
    [[NetWorkManager sharedManager] postJSON:@"UserManage/AddEmergencyContact" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {

        [self.navigationController popViewControllerAnimated:NO];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"联系人已添加" message:nil delegate:nil cancelButtonTitle:@"知道啦" otherButtonTitles: nil];
        [alert show];
    }];
    
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
    [personcell setData:_people];
    
    return personcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    self.people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    [self addContact:_people.phoneNumber];
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
