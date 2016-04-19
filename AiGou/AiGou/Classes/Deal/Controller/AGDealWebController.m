//
//  AGDealWebController.m
//  AiGou
//
//  Created by rimi on 14-12-31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealWebController.h"
#import "AGDeal.h"
#import "Defines.h"

@interface AGDealWebController () <UIWebViewDelegate>
{
    UIWebView * _webView;
    UIView *_cover;
}

@end

@implementation AGDealWebController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor = kGlobalBg;
    _webView.scrollView.backgroundColor = kGlobalBg;
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.加载请求
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID];
    NSLog(@"%@",url);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    // 2.添加遮盖
    _cover = [[UIView alloc] init];
    _cover.frame = _webView.bounds;
    _cover.backgroundColor = kGlobalBg;
    [_webView addSubview:_cover];
    
    // 3.添加指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat x = _cover.frame.size.width * 0.5;
    CGFloat y = _cover.frame.size.height * 0.5;
    indicator.center = CGPointMake(x, y);
    [_cover addSubview:indicator];
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //移除遮盖
    [_cover removeFromSuperview];
    _cover = nil;
}
@end
