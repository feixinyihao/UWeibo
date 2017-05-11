//
//  StatusCell.h
//  weibo
//
//  Created by 陈鑫荣 on 16/5/12.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatusFrame;
@interface StatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) StatusFrame *statusFrame;
@end
