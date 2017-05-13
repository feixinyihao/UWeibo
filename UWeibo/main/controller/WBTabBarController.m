//
//  WBTabBarController.m
//  weibo
//
//  Created by 陈鑫荣 on 16/2/28.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "WBTabBarController.h"
#import "WBDiscoverTableViewController.h"
#import "WbHomeTableViewController.h"
#import "WBMessageTableViewController.h"
#import "WBMeTableViewController.h"
#import "WBTabbar.h"

@interface WBTabBarController ()<WBTabBarDelegate>

@property (weak,nonatomic)WBTabbar* MyTabBar;
@end

@implementation WBTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self setupAllChildView];
    
    

}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    for (UIView * child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
       
    }
    //NSLog(@"%@",self.tabBar.subviews);
}

-(void)tabBardidClick:(WBTabbar*)tabBar from:(int)from to:(int)to{

  //  NSLog(@"%d,%d",from,to);
    self.selectedIndex=to;
    
}

-(void)setTabBar{
    WBTabbar* MyTabbar=[[WBTabbar alloc]init];
    MyTabbar.frame=self.tabBar.bounds;
//    MyTabbar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    [self.tabBar addSubview:MyTabbar];
    self.MyTabBar=MyTabbar;
    MyTabbar.delegate=self;

}

/**
 *  初始化所有子控制器
 */
-(void)setupAllChildView{
    WbHomeTableViewController* home=[[WbHomeTableViewController alloc]init];
    [self SetupChileViewConterller:home title:@"微博" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
   
    WBMessageTableViewController* message=[[WBMessageTableViewController alloc]init];
    [self SetupChileViewConterller:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    WBDiscoverTableViewController* discover=[[WBDiscoverTableViewController alloc]init];
    [self SetupChileViewConterller:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
   
    
    WBMeTableViewController* me=[[WBMeTableViewController alloc]init];
    [self SetupChileViewConterller:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
}
/**
 *  初始化一个子控制器
 */
-(void)SetupChileViewConterller:(UIViewController * )childView title:(NSString*)title  imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName{

    childView.title=title;
    childView.tabBarItem.image=[UIImage imageNamed:imageName];
    childView.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController * childViewNav=[[UINavigationController alloc]initWithRootViewController:childView];
    [self addChildViewController:childViewNav];
    [self.MyTabBar addButtonWithItem:childView.tabBarItem];
    
}



@end
