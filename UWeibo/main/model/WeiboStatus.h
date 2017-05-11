//
//  WeiboStatus.h
//  weibo
//
//  Created by 陈鑫荣 on 16/4/27.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboUser.h"
@interface WeiboStatus : NSObject
/**
 *  字符串id
 */
@property(nonatomic,copy)NSString*idstr;
/**
 *  微博内容
 */
@property(nonatomic,copy)NSString*text;
/**
 *  微博来源
 */
@property(nonatomic,copy)NSString*source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  转发数
 */
@property(nonatomic,assign)int reposts_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博的单张配图
 */
@property (nonatomic, copy) NSString *thumbnail_pic;
/**
 *  多张配图
 */
@property(nonatomic,copy)NSString* pic_urls;
/**
 *  评论数
 */
@property(nonatomic,assign)int comments_count;
/**
 *  微博用户
 */
@property(nonatomic,strong)WeiboUser* user;
/**
 *  被转发的微博
 */
@property (nonatomic, strong) WeiboStatus *retweeted_status;



+(instancetype)statusWithDict:(NSDictionary* )dict;
-(instancetype)initWithDict:(NSDictionary*)dict;
@end
