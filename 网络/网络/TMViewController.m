//
//  ViewController.m
//  网络
//
//  Created by qingyun on 16/6/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TMViewController.h"
#import "Common.h"
#import "TMModel.h"

@interface TMViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TMViewController

-(void)requestDetail{
   //创建Manager对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //设置响应接受类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //设置请求数据
    NSDictionary *pars=@{@"id":_model.ID};
    
    NSString *path=[BASEURL stringByAppendingPathComponent:INFOURL];
    [manager GET:path parameters:pars progress:^(NSProgress * _Nonnull downloadProgress){} success:^(NSURLSessionDataTask * _Nonnull task,id _Nullable resposeObject){NSHTTPURLResponse *response=(NSHTTPURLResponse *)task.response;
        if (response.statusCode==200) {
            [_webView loadHTMLString:((NSDictionary *)resposeObject)[@"data"][@"content"] baseURL:[NSURL URLWithString:path]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task,NSError * _Nonnull error){
        NSLog(@"error = %@",error);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
