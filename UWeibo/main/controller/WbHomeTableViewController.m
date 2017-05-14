//
//  WbHomeTableViewController.m
//  weibo
//
//  Created by 陈鑫荣 on 16/2/28.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "WbHomeTableViewController.h"
#import "OAuth.h"
#import "WeiboStatus.h"
#import "WeiboUser.h"
#import "StatusCell.h"
#import "StatusFrame.h"
#import "MJRefresh.h"
#import "WBContentController.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
@interface WbHomeTableViewController ()

@property(nonatomic,strong)NSArray* statuses;
@end

@implementation WbHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupStatus];
  
    
    /**下拉刷新
     */
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self setupStatus];
        [self.tableView.mj_header endRefreshing];
    
    }];
    /**
     *  上拉加载更多
     */
}

/**
 *  初始化微博信息
 */
-(void)setupStatus{

    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    NSMutableDictionary*parameters=[NSMutableDictionary dictionary];
    NSString* doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* file=[doc stringByAppendingString:@"/accout.data"];
    OAuth * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    parameters[@"access_token"]=acc.access_token;
    parameters[@"count"]=@"50";
    //NSLog(@"----%@",acc.access_token);
    //parameters[@"count"]=@2;
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    
        NSLog(@"加载中。。。");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"weibo%@",responseObject[@"statuses"]);
        NSMutableArray* statusArr=[NSMutableArray array];
        //self.statuses=responseObject[@"status"];
        for (NSDictionary * statusDic in responseObject[@"statuses"]) {
            WeiboStatus* status=[WeiboStatus statusWithDict:statusDic];
            [statusArr addObject:status];
            //NSLog(@"--%@",status.pic_urls);
            
        }
        if (self.statuses==nil) {
            self.statuses=[NSArray array];
        }
        self.statuses = statusArr;
        
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (WeiboStatus *status in self.statuses) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        
        // 赋值
        self.statusFrames = statusFrameArray;
        //NSLog(@"%@",self.statusFrames);
        [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusCell* cell= [StatusCell cellWithTableView:tableView];
    cell.statusFrame=self.statusFrames[indexPath.row];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//
////    if ([self.delete respondsToSelector:@selector(WbhomeTableViewDidSel:selectIndex:)]) {
////        WeiboStatus* status=[[WeiboStatus alloc]init];
////        NSString* weiboID=status.idstr;
////        [self.delete WbhomeTableViewDidSel:self selectIndex:weiboID];
////        NSLog(@"打印的打印的%@",weiboID);
////       // NSLog(@"%ld",(long)indexPath.row);
////    }
////    WeiboStatus* status=[[WeiboStatus alloc]init];
////    NSString* weiboID=status.idstr;
////    [self.delete WbhomeTableViewDidSel:self selectIndex:weiboID];
////    NSLog(@"打印的打印的%@",weiboID);
////
////    WBContentController* content=[[WBContentController alloc]init];
////    
////    [self.navigationController pushViewController:content animated:YES];
//    
//}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

}


@end
