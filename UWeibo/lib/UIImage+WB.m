//
//  UIImage+WB.m
//  weibo
//
//  Created by 陈鑫荣 on 16/5/14.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "UIImage+WB.h"

@implementation UIImage (WB)
+(UIImage*)resizable:(UIImage*)image{
    
    CGFloat h=image.size.height*0.5;
    CGFloat w=image.size.width*0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
   
}

+(UIImage*)resizableWithImageName:(NSString *)name{

    UIImage* imageName=[UIImage imageNamed:name];
    CGFloat h=imageName.size.height*0.5;
    CGFloat w=imageName.size.width*0.5;
    return [imageName resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

+(UIImage*)resizableWithImageName:(NSString*)name heigh:(CGFloat)h width:(CGFloat)w{
    UIImage* imageName=[UIImage imageNamed:name];
    return [imageName resizableImageWithCapInsets:UIEdgeInsetsMake(imageName.size.height*h, imageName.size.width*w, imageName.size.height*h, imageName.size.width*w)];
}
@end
