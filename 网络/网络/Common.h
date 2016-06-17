//
//  Common.h
//  网络
//
//  Created by qingyun on 16/6/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import "AFNetworking.h"
//请求主机
#define BASEURL @"http://115.29.113.198/index.php?s=/"
//请求轮播图
#define TEMAIURL @"Api/index/slide/tag/temai"
//请求商品
#define GOODSURL @"Api/Goods/lists"
//请求商品详细
#define INFOURL @"Api/Goods/info"



static NSString *const ID=@"id";
static NSString *const Title=@"title";
static NSString *const Desc=@"description";
static NSString *const Cover=@"cover";
static NSString *const Market_price=@"market_price";
static NSString *const Price=@"price";
static NSString *const Sold=@"sold";
static NSString *const Image=@"image";


#endif /* Common_h */
