//
//  AGDealCell.m
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealCell.h"
#import "AGDeal.h"
#import "AGImageTool.h"

@implementation AGDealCell

- (void)setDeal:(AGDeal *)deal
{
    _deal = deal;
    
    // 1.设置描述
    _desc.text = deal.desc;
    
    // 2.下载图片
    [AGImageTool downloadImage:deal.image_url placeholder:[UIImage imageNamed:@"placeholder_deal.png"] imageView:_image];
    
    // 3.购买人数
    [_purchaseCount setTitle:[NSString stringWithFormat:@"%d", deal.purchase_count] forState:UIControlStateNormal];
    
    // 4.价格
    _price.text = deal.current_price_text;
    
    // 5.标签
    // 5.1.获得当前时间字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *now = [fmt stringFromDate:[NSDate date]];
    
    // 5.2.比较当前时间
    NSString *icon = nil;
    if ([deal.publish_date isEqualToString:now]) {
        icon = @"ic_deal_new.png";
    } else if ([deal.purchase_deadline isEqualToString:now]) {
        icon = @"ic_deal_soonOver.png";
    } else if ([deal.purchase_deadline compare:now] == NSOrderedAscending) {
        icon = @"ic_deal_over.png";
    }
    
    _badge.hidden = icon == nil;
    _badge.image = [UIImage imageNamed:icon];
}

@end
