//
//  XMLParser.m
//  weibo
//
//  Created by 陈鑫荣 on 16/5/23.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "XMLParser.h"



@implementation XMLParser
+(NSString*)XMLParserWithString:(NSString* )str{

    int tempFrom=0;
    int tempEnd = 0 ;
    if ([str isEqual:@""] ||str==nil) {
        return @"-1";
    }else{
    for (int i=0; i<str.length; i++) {
        NSString* temp=[str substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@">"] && i<str.length-1) {
            tempFrom=i;
        }
        if ([temp isEqualToString:@"<"]&& i>1) {
            tempEnd=i;
        }
    }
    return [str substringWithRange:NSMakeRange(tempFrom+1, tempEnd-tempFrom-1)];
    }
}

@end
