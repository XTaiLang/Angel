//
//  TMModel.m
//  网络
//
//  Created by qingyun on 16/6/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TMModel.h"
#import "Common.h"

@implementation TMModel
+(instancetype)modelWithDictionary:(NSDictionary *)info{
    return [[self alloc]initWithDictionary:info];
}

-(instancetype)initWithDictionary:(NSDictionary *)info{
    if (self=[super init]) {
        _ID=info[ID];
        _title=info[Title];
        _Desc=info[Desc];
        _cover=info[Cover];
        _market_price=info[Market_price];
        _price=info[Price];
        _sold=info[Sold];
    }
    return self;
}

@end
