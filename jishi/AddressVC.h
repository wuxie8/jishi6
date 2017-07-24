//
//  AddressVC.h
//  小依休
//
//  Created by 吴公胜 on 16/3/11.
//  Copyright © 2016年 AnSaiJie. All rights reserved.
//

#import "NavBaseVC.h"
#import "PersonModel.h"
#import "XHJAddressBook.h"
#import "PersonCell.h"

typedef void(^telBlock)(NSString * tel);

typedef void(^personBlock)(PersonModel *person);

@interface AddressVC : NavBaseVC<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic, copy)telBlock clickBlock;
@property(nonatomic, copy)personBlock clickPersonBlock;

@property (nonatomic, copy)NSString *location;
@property(nonatomic,strong)NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *sectionTitles;
@property(strong,nonatomic)NSMutableDictionary *diction;

@end
