//
//  WeiboUser.h
//  weibo
//
//  Created by 陈鑫荣 on 16/4/28.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboUser : NSObject

/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博姓名
 */
@property(nonatomic,copy)NSString*name;

/**
 *  头像url
 */
@property(nonatomic,copy)NSString*profile_image_url;
/**
 *  是否为vip
 */
@property (nonatomic, assign, getter = isVip) BOOL vip;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)userWithDict:(NSDictionary*)dict;
@end
