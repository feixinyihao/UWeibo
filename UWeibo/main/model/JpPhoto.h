//
//  JpPhoto.h
//  UWeibo
//
//  Created by 陈鑫荣 on 2017/5/15.
//  Copyright © 2017年 justprint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JpPhoto : NSObject
@property(nonatomic,copy)NSString * thumbnail_pic;
-(instancetype)initWithDic:(NSDictionary* )dic;
+(instancetype)jpphotoWithDic:(NSDictionary* )dic;
@end
