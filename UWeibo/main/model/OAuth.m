//
//  OAuth.m
//  WSDL
//
//  Created by 陈鑫荣 on 16/4/9.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "OAuth.h"
@interface OAuth()<NSCoding>

@end
@implementation OAuth

-(instancetype)initWithDict:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}
+(instancetype)oauthWithDict:(NSDictionary*)dict{
    
    return [[self alloc]initWithDict:dict];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self=[super init]) {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.uid=[aDecoder decodeInt64ForKey:@"uid"];
        self.expires_in=[aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in=[aDecoder decodeInt64ForKey:@"remind_in"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    
    
    
}
@end
