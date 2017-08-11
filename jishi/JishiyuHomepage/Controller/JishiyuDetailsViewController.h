//
//  JishiyuDetailsViewController.h
//  jishi
//
//  Created by Admin on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "GestureNavBaseVC.h"
#import "ProductModel.h"
@interface JishiyuDetailsViewController : GestureNavBaseVC<UITableViewDelegate,UITableViewDataSource>


@property(strong, nonatomic)ProductModel*product;
@end
