//
//  WeiboStatus.m
//  weibo
//
//  Created by 陈鑫荣 on 16/4/27.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "WeiboStatus.h"
@interface WeiboStatus()
@end
@implementation WeiboStatus
+(instancetype)statusWithDict:(NSDictionary* )dict{

    return [[self alloc]initWithDict:dict];
}

/** 解析微博时间格式*/
- (NSString*)resolveSinaWeiboDate:(NSString*)date{
    NSDateFormatter *iosDateFormater=[[NSDateFormatter alloc]init];
    iosDateFormater.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
    //必须设置，否则无法解析
    iosDateFormater.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *tdate=[iosDateFormater dateFromString:date];
    
    //目的格式
    NSDateFormatter *resultFormatter=[[NSDateFormatter alloc]init];
    [resultFormatter setDateFormat:@"YYYYMMdd HH:mm:ss"];
    NSString * str=[resultFormatter stringFromDate:tdate];
    
    //NSLog(@"%@",str);
    
    
    
    return str;;
}
-(NSString *)created_at{

    NSString* createdTime=_created_at;
    //设置微博格式
    NSString*str=[self resolveSinaWeiboDate:createdTime];
    
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMdd HH:mm:ss"];
    NSDate* date1=[dateFormatter dateFromString:str];
    //把时间格式转化成时间戳
    // NSString* creatTime=[NSString stringWithFormat:@"%ld",(long)[date1 timeIntervalSince1970]];
    long long creatTime=[date1 timeIntervalSince1970];
    NSTimeInterval  time=[[NSDate date]timeIntervalSince1970];
    long long dTime=[[NSNumber numberWithDouble:time]longLongValue];
    NSString* result=@"";
    if ((dTime-creatTime)<60) {
        result=@"刚刚";
    }else if((dTime-creatTime)>60 && (dTime-creatTime)<3600){
        
        result=[NSString stringWithFormat:@"%lld分钟前",(dTime-creatTime)/60];
    }else if((dTime-creatTime)>3600 && (dTime-creatTime)<86400){
        
        result=[NSString stringWithFormat:@"%lld小时前",(dTime-creatTime)/3600];
        
    }else{
        result=[NSString stringWithFormat:@"%lld天前",(dTime-creatTime)/86400];
        
    }
    return result;
    

}

-(instancetype)initWithDict:(NSDictionary*)dict{

    if (self=[super init]) {
        self.idstr=dict[@"idstr"];
        self.text=dict[@"text"];
        self.source=dict[@"source"];
        self.reposts_count=[dict[@"reposts_count"] intValue];
        self.comments_count=[dict[@"comments_count"] intValue];
        self.user=[WeiboUser userWithDict:dict[@"user"]];
       // NSString* createdTime=dict[@"created_at"];
        self.created_at=dict[@"created_at"];
        self.pic_urls=dict[@"pic_urls"];
//        //设置微博格式
//        NSString*str=[self resolveSinaWeiboDate:createdTime];
//        
//        NSDateFormatter* dateFormatter=[[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"YYYYMMdd HH:mm:ss"];
//        NSDate* date1=[dateFormatter dateFromString:str];
//        //把时间格式转化成时间戳
//        // NSString* creatTime=[NSString stringWithFormat:@"%ld",(long)[date1 timeIntervalSince1970]];
//        long long creatTime=[date1 timeIntervalSince1970];
//        NSTimeInterval  time=[[NSDate date]timeIntervalSince1970];
//        long long dTime=[[NSNumber numberWithDouble:time]longLongValue];
//        if ((dTime-creatTime)<60) {
//            self.created_at=@"刚刚";
//        }else if((dTime-creatTime)>60 && (dTime-creatTime)<3600){
//            
//            self.created_at=[NSString stringWithFormat:@"%lld分钟前",(dTime-creatTime)/60];
//        }else if((dTime-creatTime)>3600 && (dTime-creatTime)<86400){
//            
//            self.created_at=[NSString stringWithFormat:@"%lld小时前",(dTime-creatTime)/3600];
//            
//        }else{
//           self.created_at=[NSString stringWithFormat:@"%lld天前",(dTime-creatTime)/86400];
//            
//        }
        
        self.attitudes_count=[dict[@"attitudes_count"] intValue];
        if (dict[@"retweeted_status"]) {
            self.retweeted_status=[[WeiboStatus alloc]init];
            NSDictionary* dic=dict[@"retweeted_status"];
            self.retweeted_status=[WeiboStatus statusWithDict:dic];
            
        }
        
        self.thumbnail_pic=dict[@"thumbnail_pic"];
        
        
        
    }
    return self;
}
/**



-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self=[super init]) {
        self.idstr=[aDecoder decodeObjectForKey:@"idstr"];
        self.text=[aDecoder decodeObjectForKey:@"text"];
        self.source=[aDecoder decodeObjectForKey:@"source"];
        self.created_at=[aDecoder decodeObjectForKey:@"created_at"];
        self.reposts_count=[aDecoder decodeIntForKey:@"reposts_count"];
        self.thumbnail_pic=[aDecoder decodeObjectForKey:@"thumbnail_pic"];
        self.pic_urls=[aDecoder decodeObjectForKey:@"pic_urls"];
        self.comments_count=[aDecoder decodeIntForKey:@"comments_count"];
        self.user=[aDecoder decodeObjectForKey:@"user"];
        self.retweeted_status=[aDecoder decodeObjectForKey:@"retweeted_status"];
    
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.idstr forKey:@"idstr"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeInteger:self.reposts_count forKey:@"reposts_count"];
    [aCoder encodeObject:self.thumbnail_pic forKey:@"thumbnail_pic"];
    [aCoder encodeObject:self.pic_urls forKey:@"pic_urls"];
    [aCoder encodeInt:self.comments_count forKey:@"comments_count"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.retweeted_status forKey:@"retweeted_status"];
    

    
}
  */
@end
