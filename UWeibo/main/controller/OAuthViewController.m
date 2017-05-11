//
//  OAuthViewController.m
//  WSDL
//
//  Created by 陈鑫荣 on 16/4/9.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "OAuthViewController.h"
#import "OAuth.h"
#import "UniHttpTool.h"
#import "WBTabBarController.h"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView* web=[[UIWebView alloc]init];
    web.frame=[[UIScreen mainScreen]bounds];
    [self.view addSubview:web];
    NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1959899293&redirect_uri=www.unifound.net"];
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    web.delegate=self;
    [web loadRequest:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //NSLog(@"%@",request.URL);
    NSString* urlstr=request.URL.absoluteString;
    NSRange rang=[urlstr rangeOfString:@"code="];
    if (rang.length) {
        int loc=rang.location+rang.length;
        NSString* code=[urlstr substringFromIndex:loc];
        NSLog(@"==%@",urlstr);
        NSLog(@"===%@",code);
        NSMutableDictionary* parameters=[NSMutableDictionary dictionary];
        parameters[@"client_id"]=@"1959899293";
        parameters[@"client_secret"]=@"28d2832dc4589cbf5256fb91e05f3908";
        parameters[@"grant_type"]=@"authorization_code";
        parameters[@"code"]=code;
        parameters[@"redirect_uri"]=@"www.unifound.net";
        [UniHttpTool postWithUrl:@"https://api.weibo.com/oauth2/access_token"  parameters:parameters progress:^(NSProgress *progress) {
            NSLog(@"加载中");
        } success:^(id json) {
            NSLog(@"成功了..%@",json);
            OAuth* acc=[OAuth oauthWithDict:json];
            NSString* doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
            NSString* file=[doc stringByAppendingString:@"/accout.data"];
            [NSKeyedArchiver archiveRootObject:acc toFile:file];
            WBTabBarController* tabBarController=[[WBTabBarController alloc]init];
            [self presentViewController:tabBarController animated:YES completion:nil];
            [self.view removeFromSuperview];
        } failure:^(NSError *error) {
            NSLog(@"出错了%@",error);
        }];
        
    }
    
    return YES;
}

@end
