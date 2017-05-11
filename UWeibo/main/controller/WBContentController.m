//
//  WBContentConreoller.m
//  weibo
//
//  Created by 陈鑫荣 on 16/6/12.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "WBContentController.h"
#import "WbHomeTableViewController.h"
#import "StatusCell.h"
@interface WBContentController()<WbHomeTableViewControllerDelete>
@property(nonatomic,assign)int index;
@property(nonatomic,copy)NSString* idStr;
@end

@implementation WBContentController

-(void)viewDidLoad{

    WbHomeTableViewController* WbhomeTableView=[[WbHomeTableViewController alloc]init];
    WbhomeTableView.delete=self;
}

-(void)WbhomeTableViewDidSel:(WbHomeTableViewController *)WbHomeTableView selectIndex:(NSString*)index{

    self.idStr=index;
    NSLog(@"打印打印打印----%@",index);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WbHomeTableViewController* WbhomeTableView=[[WbHomeTableViewController alloc]init];
    WbhomeTableView.delete=self;
    StatusCell* cell= [StatusCell cellWithTableView:tableView];
    cell.statusFrame=WbhomeTableView.statusFrames[self.index];
    //NSLog(@"错误%d",self.index);
//    static NSString* ID=@"cell";
//    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text=@"test";
    return cell;

}
@end
