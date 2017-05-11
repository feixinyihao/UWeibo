//
//  StatusFrame.h
//  weibo
//
//  Created by 陈鑫荣 on 16/5/14.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 昵称的字体 */
#define WBStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define WBRetweetStatusNameFont WBStatusNameFont

/** 时间的字体 */
#define WBStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define WBStatusSourceFont WBStatusTimeFont
/**获得RGB颜色*/
#define WBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/** 正文的字体 */
#define WBStatusContentFont [UIFont systemFontOfSize:15]
/** 被转发微博正文的字体 */
#define WBRetweetStatusContentFont WBStatusContentFont

/** 表格的边框宽度 */
#define WBStatusTableBorder 5

/** cell的边框宽度 */
#define WBStatusCellBorder 10

@class WeiboStatus;
@interface StatusFrame : NSObject
@property (nonatomic, strong) WeiboStatus *status;
/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
