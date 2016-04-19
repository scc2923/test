//
//  AGBaseController.m
//  AiGou
//
//  Created by rimi on 14/12/29.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGBaseController.h"

@interface AGBaseController ()

@end

@implementation AGBaseController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton * back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [back setBackgroundImage:[UIImage imageNamed:@"btn_backItem_white.png"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * backBtn = [[UIBarButtonItem alloc] initWithCustomView:back];
        [self.navigationItem setLeftBarButtonItem:backBtn];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
