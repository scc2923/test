//
//  MoreController.m
//  AiGou
//
//  Created by rimi on 14-12-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGMoreController.h"
#import "Defines.h"

@interface AGMoreController ()

@end

@implementation AGMoreController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"更多";
        self.view.backgroundColor = kGlobalBg;
    }
    return self;
}

@end

