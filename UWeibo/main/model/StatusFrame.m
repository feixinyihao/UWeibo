//
//  StatusFrame.m
//  weibo
//
//  Created by 陈鑫荣 on 16/5/14.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "StatusFrame.h"
#import "WeiboUser.h"
#import "WeiboStatus.h"

@implementation StatusFrame

-(void)setStatus:(WeiboStatus *)status{
    _status=status;
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width-2*WBStatusCellBorder;

    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = WBStatusCellBorder;
    CGFloat iconViewY = WBStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + WBStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize=[status.user.name sizeWithAttributes:@{NSFontAttributeName:WBStatusNameFont}];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.isVip) {
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + WBStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewH, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + WBStatusCellBorder;
    CGSize timeLabelSize=[status.created_at sizeWithAttributes:@{NSFontAttributeName:WBStatusTimeFont}];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX =CGRectGetMaxX(_timeLabelF) + WBStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:@{NSFontAttributeName:WBStatusSourceFont}];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + WBStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * WBStatusCellBorder;
//    CGSize contentLabelSize = [status.text sizeWithFont:WBStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];

    CGSize contentLabelSize=[status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:WBStatusNameFont} context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    
    if (status.thumbnail_pic) {
        if(status.pic_urls.count==1){
            
            NSURL*url=[NSURL URLWithString:status.thumbnail_pic];
            NSData* data=[NSData dataWithContentsOfURL:url];
            UIImage* image=[UIImage imageWithData:data];
            CGFloat photoViewX = contentLabelX;
            CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + WBStatusCellBorder;
            _photoViewF = CGRectMake(photoViewX, photoViewY, image.size.width*1.2, image.size.height*1.2);
            
            
        }else if (status.pic_urls.count>1){
            CGFloat photoViewW = contentLabelMaxW;
            CGFloat photoViewH=((status.pic_urls.count-1)/3)*(photoViewW-2*WBStatusTableBorder)/3+(photoViewW-2*WBStatusTableBorder)/3;
            CGFloat photoViewX = contentLabelX;
            CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + WBStatusCellBorder;
            _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewW, photoViewH);
        }
        

    }
    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + WBStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = WBStatusCellBorder;
        CGFloat retweetNameLabelY = WBStatusCellBorder;
        NSDictionary* namefontSize=@{NSFontAttributeName:WBRetweetStatusNameFont};
        CGSize retweetNameLabelSize = [status.retweeted_status.user.name sizeWithAttributes:namefontSize];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + WBStatusCellBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * WBStatusCellBorder;
        NSDictionary*contenFontSize=@{NSFontAttributeName:WBRetweetStatusContentFont};
        CGSize size=CGSizeMake(retweetContentLabelMaxW, MAXFLOAT);
        //NSString* str ;
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:contenFontSize context:nil].size;
        //CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:WBRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewWH = 70;
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + WBStatusCellBorder;
   
            NSURL*url=[NSURL URLWithString:status.retweeted_status.thumbnail_pic];
            NSData* data=[NSData dataWithContentsOfURL:url];
            UIImage* image=[[UIImage alloc]initWithData:data];
            
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, image.size.width*1.2, image.size.height*1.2);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += WBStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        if (status.thumbnail_pic) { // 有图
            topViewH = CGRectGetMaxY(_photoViewF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += WBStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + WBStatusTableBorder;
    
}
@end
