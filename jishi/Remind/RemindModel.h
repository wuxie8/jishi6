//
//  RemindModel.h
//  haitian
//
//  Created by Admin on 2017/5/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject

@property (nonatomic, copy) NSString *rep_id;

@property (nonatomic, copy) NSString *name;

@end

@interface ReminndTimeModel : NSObject

@property (nonatomic, copy) NSString *rem_id;

@property (nonatomic, copy) NSString *name;

@end
@interface ReminndListModel : NSObject

@property (nonatomic, copy) NSString *icon;


@property (nonatomic, copy) NSString *msg_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *amount;

@property (nonatomic, copy) NSString *rem_name;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *rep_name;

@property (nonatomic, copy) NSString *repayment_date;

@property (nonatomic, copy) NSString *type_name;



@end
