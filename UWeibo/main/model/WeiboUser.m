//
//  WeiboUser.m
//  weibo
//
//  Created by 陈鑫荣 on 16/4/28.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "WeiboUser.h"



@implementation WeiboUser
-(instancetype)initWithDict:(NSDictionary*)dict{

    if (self=[super init]) {
        self.name=dict[@"name"];
        self.profile_image_url=dict[@"profile_image_url"];
        self.idstr=dict[@"idstr"];
        self.vip=dict[@"mbrank"];
    }
    return self;
}
+(instancetype)userWithDict:(NSDictionary*)dict{

    return [[self alloc]initWithDict:dict];
}


@end
