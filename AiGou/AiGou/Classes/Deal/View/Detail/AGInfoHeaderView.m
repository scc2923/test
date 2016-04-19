//
//  AGInfoHeaderView.m
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGInfoHeaderView.h"
#import "AGDeal.h"
#import "AGImageTool.h"
#import "AGRestriction.h"
#import "NSDate+AG.h"

@implementation AGInfoHeaderView

- (void)setDeal:(AGDeal *)deal
{
    _deal = deal;
    
    if (deal.restrictions) { // 有约束（完整的数据）
        // 1.设置是否支持退款
        _anyTimeBack.enabled = deal.restrictions.is_refundable;
        _expireBack.enabled = _anyTimeBack.enabled;
    } else { // 不完整的数据
        // 2.下载图片
        [AGImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
        
        // 3.设置剩余时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd"; // 2013-11-17
        // 2013-11-17
        NSDate *dealline = [fmt dateFromString:deal.purchase_deadline];
        // 2013-11-18 00:00:00
        dealline = [dealline dateByAddingTimeInterval:24 * 3600];
        // 2013-11-17 10:50
        NSDate *now = [NSDate date];
        
        //    NSDateComponents *cmps = [NSDate compareFrom:now to:dealline];
        
        NSDateComponents *cmps = [now compare:dealline];
        
        NSString *timeStr = [NSString stringWithFormat:@"%ld 天 %ld 小时 %ld 分钟", (long)cmps.day, (long)cmps.hour, (long)cmps.minute];
        [_time setTitle:timeStr forState:UIControlStateNormal];
    }
    
    // 4.购买人数
    NSString *pc = [NSString stringWithFormat:@"%d 人已购买", deal.purchase_count];
    [_purchaseCount setTitle:pc forState:UIControlStateNormal];
        
    // 5.设置描述
    _desc.text = deal.desc;
    // 描述的高度
    CGFloat descH = [deal.desc sizeWithFont:_desc.font constrainedToSize:CGSizeMake(_desc.frame.size.width, MAXFLOAT) lineBreakMode:_desc.lineBreakMode].height + 20;
    CGRect descF = _desc.frame;
    
    CGFloat descDeltaH = descH - descF.size.height;
    
    descF.size.height = descH;
    _desc.frame = descF;
    
    // 6.设置整体的高度
    CGRect selfF = self.frame;
    selfF.size.height += descDeltaH;
    self.frame = selfF;
}

//- (void)setFrame:(CGRect)frame
//{
//    frame.size.height = self.frame.size.height;
//    [super setFrame:frame];
//}

+ (id)infoHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"AGInfoHeaderView" owner:nil options:nil][0];
}

@end