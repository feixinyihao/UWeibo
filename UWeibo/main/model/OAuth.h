//
//  OAuth.h
//  WSDL
//
//  Created by 陈鑫荣 on 16/4/9.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth : NSObject
@property(nonatomic,copy)NSString*access_token;
@property(nonatomic,assign)long long expires_in;
@property(nonatomic,assign)long long remind_in;
@property(nonatomic,assign)long long uid;

-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)oauthWithDict:(NSDictionary*)dict;
@end
