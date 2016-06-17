//
//  TMCollectionViewController.m
//  网络
//
//  Created by qingyun on 16/6/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TMTableViewController.h"
#import "Common.h"
#import "AFNetworking.h"
#import "TMModel.h"
#import "TMTableViewCell.h"
#import "TMViewController.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"

@interface TMTableViewController ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)NSArray *array;
@end

@implementation TMTableViewController

static NSString *cellIdentifier= @"Cell";

-(NSArray *)array{
    if (_array==nil) {
        _array=[NSArray array];
    }
    return _array;
}


-(void)requesGoodsList{
 //创建Manager对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    //设置响应接受类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //get请求
    __weak TMTableViewController *weakSelf=self;
    [manager GET:[BASEURL stringByAppendingPathComponent:GOODSURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            
            NSArray *statusArr=responseObject[@"data"];
            NSMutableArray *models=[NSMutableArray array];
            for(NSDictionary *statusDict in statusArr){
                TMModel *status=[TMModel modelWithDictionary:statusDict];
                [models addObject:status];
            }
            weakSelf.array=models;
            
            
            //刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
}
    }failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        NSLog(@"error=%@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requesGoodsList];
    [self requestTemai];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TMTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    self.tableView.estimatedRowHeight = 150;
    [self requesGoodsList];
    [self requestTemai];
}
-(void)requestTemai{
    //创建Manager对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //设置响应接受类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    
    //请求
    __weak TMTableViewController *weakSelf=self;
    [manager GET:[BASEURL stringByAppendingPathComponent:TEMAIURL] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            NSArray *statusArr=responseObject[@"data"];
            [weakSelf headerView:statusArr];

            //刷新
            dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf headerView:statusArr];

            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

-(void)headerView:(NSArray *)pictureArr{
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 180) delegate:self placeholderImage:[UIImage imageNamed:@"social-user"]];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < pictureArr.count; i++) {
        NSDictionary *dict = pictureArr[i];
        [tempArray addObject:dict[@"image"]];
    }
    scrollView.imageURLStringsGroup = tempArray;
    scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.tableView.tableHeaderView = scrollView;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.model = self.array[indexPath.row];
    // Configure the cell...
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TMViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"webView"];
    TMModel *selectedMode = self.array[indexPath.row];
    detailVC.model = selectedMode;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
