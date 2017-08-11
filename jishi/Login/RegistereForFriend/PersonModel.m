//
//  PersonModel.m
//  BeautyAddressBook
//
//  Created by 余华俊 on 15/10/22.
//  Copyright © 2015年 hackxhj. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (NSDictionary *) encodedItem
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.phonename, @"phonename",
           UIImageJPEGRepresentation(self.image, 1.0), @"image",
            self.tel , @"phoneNumber", nil];
}

@end
