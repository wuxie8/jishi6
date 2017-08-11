//
//  idInfo.m
//  BankCard
//
//  Created by XAYQ-FanXL on 16/7/8.
//  Copyright © 2016年 AN. All rights reserved.
//

#import "IDInfo.h"

@implementation IDInfo

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.num forKey:@"num"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.nation forKey:@"nation"];
    
    [aCoder encodeObject:self.issue forKey:@"issue"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.valid forKey:@"valid"];
    [aCoder encodeObject:self.IDPositiveImage forKey:@"IDPositiveImage"];
    [aCoder encodeObject:self.IDOppositeImage forKey:@"IDOppositeImage"];
    [aCoder encodeObject:self.is_Face forKey:@"is_Face"];

  
}

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.num = [aDecoder decodeObjectForKey:@"num"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.nation = [aDecoder decodeObjectForKey:@"nation"];
        
        self.issue = [aDecoder decodeObjectForKey:@"issue"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.valid = [aDecoder decodeObjectForKey:@"valid"];
        self.IDPositiveImage = [aDecoder decodeObjectForKey:@"IDPositiveImage"];
        self.IDOppositeImage = [aDecoder decodeObjectForKey:@"IDOppositeImage"];
        self.IDOppositeImage = [aDecoder decodeObjectForKey:@"is_Face"];

      
    }
    return self;
}


@end
