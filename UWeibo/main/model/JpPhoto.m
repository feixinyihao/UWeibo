//
//  JpPhoto.m
//  UWeibo
//
//  Created by 陈鑫荣 on 2017/5/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import "JpPhoto.h"

@implementation JpPhoto
-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self=[super init]) {
        self.thumbnail_pic=dic[@"thumbnail_pic"];
    }
    return self;
}
+(instancetype)jpphotoWithDic:(NSDictionary* )dic{

    return [[self alloc]initWithDic:dic];
}
@end
