//
//  AGBuyDock.m
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGBuyDock.h"
#import "AGDeal.h"
#import "UIImage+AG.h"
#import "AGCenterLineLabel.h"

@implementation AGBuyDock

- (void)setDeal:(AGDeal *)deal
{
    _deal = deal;
    
    _listPrice.text = [NSString stringWithFormat:@" %@ 元 ", deal.list_price_text];
    _currentPrice.text = deal.current_price_text;
}

+ (id)buyDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"AGBuyDock" owner:nil options:nil][0];
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_buyBtn.png"] drawInRect:rect];
}

- (IBAction)buy {
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://o.p.dianping.com/buy/d%@", ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
