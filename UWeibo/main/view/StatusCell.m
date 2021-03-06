//
//  StatusCell.m
//  weibo
//
//  Created by 陈鑫荣 on 16/5/12.
//  Copyright © 2016年 unifound. All rights reserved.
//

#import "StatusCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WB.h"
#import "WeiboStatus.h"
#import "StatusFrame.h"
#import "WeiboUser.h"
#import "XMLParser.h"
#import "JpPhoto.h"
@interface StatusCell()<NSXMLParserDelegate>
/** 顶部的view */
@property (nonatomic, weak) UIImageView *topView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIView *photoView;

@property(nonatomic,weak)UIButton* photoBtn;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 微博的工具条 */
@property (nonatomic, weak) UIImageView *statusToolbar;


@end

@implementation StatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"status";
    //StatusCell* cell=[[StatusCell alloc]init];
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.subviews lastObject] != nil) {
        
            [(UIView *)[cell.subviews lastObject] removeFromSuperview];
        }
        // 1.添加原创微博内部的子控件
        [cell setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [cell setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [cell setupStatusToolBar];

    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.userInteractionEnabled=YES;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{

    
    /** 1.顶部的view */
    UIImageView *topView = [[UIImageView alloc] init];
    topView.userInteractionEnabled=YES;
    topView.image = [UIImage resizableWithImageName:@"timeline_card_top_background_os7"];
    [self addSubview:topView];

    self.topView = topView;
    
    /** 2.头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    /** 3.会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    /** 4.配图 */
    UIView *photoView = [[UIView alloc] init];
    photoView.userInteractionEnabled=YES;
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    /** 5.昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = WBStatusNameFont;
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 6.时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = WBStatusTimeFont;
    timeLabel.textColor = WBColor(240, 140, 19);
    timeLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 7.来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = WBStatusSourceFont;
    sourceLabel.textColor = WBColor(135, 135, 135);
    sourceLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 8.正文\内容 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = WBColor(39, 39, 39);
    contentLabel.font = WBStatusContentFont;
    contentLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    /** 1.被转发微博的view(父控件) */
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizableWithImageName:@"timeline_retweet_background_os7" heigh:0.9 width:0.9];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 2.被转发微博作者的昵称 */
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = WBRetweetStatusNameFont;
    retweetNameLabel.textColor = WBColor(67, 107, 163);
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    /** 3.被转发微博的正文\内容 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = WBRetweetStatusContentFont;
    retweetContentLabel.backgroundColor = [UIColor clearColor];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.textColor = WBColor(90, 90, 90);
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 4.被转发微博的配图 */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}
/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    /** 1.微博的工具条 */
    UIImageView *statusToolbar = [[UIImageView alloc] init];
    statusToolbar.image = [UIImage resizableWithImageName:@"timeline_card_bottom_background_os7"];
    [self.contentView addSubview:statusToolbar];
    self.statusToolbar = statusToolbar;
}

/**
 *  拦截frame的设置
 */


- (void)setFrame:(CGRect)frame
{
    frame.origin.y += WBStatusTableBorder;
    frame.origin.x = WBStatusTableBorder;
    frame.size.width -= 2 * WBStatusTableBorder;
    frame.size.height -= WBStatusTableBorder;
    [super setFrame:frame];
}

/**
 *  传递模型数据
 */
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.原创微博
    [self setupOriginalData];
    
    // 2.被转发微博
    [self setupRetweetData];
    
    // 3.微博工具条
    [self setupStatusToolbar];
}

/**
 *  微博工具条
 */
- (void)setupStatusToolbar
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
}




/**
 *  原创微博
 */
- (void)setupOriginalData
{
    WeiboStatus *status = self.statusFrame.status;
    WeiboUser *user = status.user;
    
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.头像
    self.iconView.frame = self.statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url]  placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView .layer.masksToBounds=YES;
    self.iconView .layer.cornerRadius=self.iconView.frame.size.height/2.0f; //设置为图片宽度的一半出来为圆形
    self.iconView .layer.borderWidth=1.0f; //边框宽
    self.iconView .layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色

   
   
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = self.statusFrame.vipViewF;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        
        
    } else {
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text=status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;

    
    // 6.来源
    NSString* from=[XMLParser XMLParserWithString:status.source];
    self.sourceLabel.text =[NSString stringWithFormat:@"来自%@",from];
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
   
    
    
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        if (status.pic_urls.count>1) {
            for (int i=0; i<status.pic_urls.count; i++) {
                UIImageView* imageview=[[UIImageView alloc]init];
      
                NSDictionary* imagedic=status.pic_urls[i];
                JpPhoto* jpphoto=[JpPhoto jpphotoWithDic:imagedic];
                [imageview sd_setImageWithURL:[NSURL URLWithString:jpphoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder_os7"]];
                [imageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
                imageview.contentMode =  UIViewContentModeScaleAspectFill;
                imageview.autoresizingMask=UIViewAutoresizingFlexibleHeight;
                imageview.clipsToBounds=YES;
                CGFloat imageW=(self.photoView.bounds.size.width-2*WBStatusTableBorder)/3;
                CGFloat imageH=imageW;
                CGFloat imageX=(i%3)*(imageW+WBStatusTableBorder);
                CGFloat imageY=(i/3)*(imageW+WBStatusTableBorder);
                imageview.frame=CGRectMake(imageX, imageY, imageW, imageH);
                imageview.userInteractionEnabled=YES;
                UIGestureRecognizer* gest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
                [imageview addGestureRecognizer:gest];
                imageview.tag=i;
                [self.photoView addSubview:imageview];
                }
        }else{
        
            UIImageView* imageview=[[UIImageView alloc]init];
            [imageview sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder_os7"]];
            imageview.frame=self.photoView.bounds;
            [self.photoView addSubview:imageview];
        
        }
    } else {
        self.photoView.hidden = YES;
    }
}
-(void)clickImage:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"click");
    
    
    
}


/**
 *  被转发微博
 */
- (void)setupRetweetData
{
    WeiboStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    WeiboUser *user = retweetStatus.user;
    
    // 1.父控件
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 2.昵称
        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 3.正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 4.配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder_os7"]];
        } else {
            self.retweetPhotoView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
}




@end
