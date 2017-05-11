//
//  UIImage+WB.h
//  weibo
//
//  Created by 陈鑫荣 on 16/5/14.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WB)
+(UIImage*)resizable:(UIImage*)image;
+(UIImage*)resizableWithImageName:(NSString *)name;
+(UIImage*)resizableWithImageName:(NSString*)name heigh:(CGFloat)h width:(CGFloat)w;
@end
