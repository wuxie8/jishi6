//
//  AddressBookVC.h
//  小依休
//
//  Created by 吴公胜 on 16/2/25.
//  Copyright © 2016年 AnSaiJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHJAddressBook.h"
#import  "PersonModel.h"
#import "PersonCell.h"

@interface AddressBookVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@end
