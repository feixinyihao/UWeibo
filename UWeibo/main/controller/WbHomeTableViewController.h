//
//  WbHomeTableViewController.h
//  weibo
//
//  Created by 陈鑫荣 on 16/2/28.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WbHomeTableViewController;
@protocol WbHomeTableViewControllerDelete<NSObject>

@optional
-(void)WbhomeTableViewDidSel:(WbHomeTableViewController*)WbHomeTableView selectIndex:(NSString*)index;

@end


@interface WbHomeTableViewController : UITableViewController
@property(nonatomic,strong)id <WbHomeTableViewControllerDelete>delete;
@property(nonatomic,strong)NSArray* statusFrames;
@end
