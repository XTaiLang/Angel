//
//  TMModel.h
//  网络
//
//  Created by qingyun on 16/6/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMModel : NSObject

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *Desc;
@property(nonatomic,strong)NSString *tags;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *market_price;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *sold;


+(instancetype)modelWithDictionary:(NSDictionary *)info;
-(instancetype)initWithDictionary:(NSDictionary *)info;

@end
