//
//  WBMeTableViewController.m
//  weibo
//
//  Created by 陈鑫荣 on 16/2/28.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "WBMeTableViewController.h"
#import "AFNetworking.h"
#import "OAuth.h"

@interface WBMeTableViewController ()

@end

@implementation WBMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    NSMutableDictionary*parameters=[NSMutableDictionary dictionary];
    NSString* doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString* file=[doc stringByAppendingString:@"/accout.data"];
    OAuth * acc=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    parameters[@"access_token"]=acc.access_token;
    parameters[@"uid"]=[NSString stringWithFormat:@"%lld",acc.uid];
    //NSLog(@"----%@",acc.access_token);
    [manager GET:@"https://api.weibo.com/2/eps/user/info.json" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"loading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSArray *statusArray =[NSArray array];
        // WeiboStatus * status=[WeiboStatus statusWithDict:responseObject];
        //        self.statusFrames=responseObject[@"Status"];
        //
        // NSLog(@"%@",responseObject[@"statuses"]);
        //        NSMutableArray *statusFrameArray = [NSMutableArray array];
        //        for (NSDictionary *statusDic in self.statusFrames) {
        //
        //            StatusFrame *statusFrame = [[StatusFrame alloc]init];
        //            // 传递微博模型数据
        //            statusFrame.status = status;
        //            [statusFrameArray addObject:statusFrame];
        //        }
        //
        NSLog(@"--%@",responseObject);
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
}


   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 2;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 2;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* ID=@"status";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=@"XXX";
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
