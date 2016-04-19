//
//  AGMineController.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGMineController.h"
#import "AGCollectTool.h"
#import "AGDealCell.h"
#import "Defines.h"

@interface AGMineController ()

@end

@implementation AGMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = kGlobalBg;
     [[NSNotificationCenter defaultCenter] addObserver:_collectionView selector:@selector(reloadData) name:kCollectChangeNote object:nil];
}

- (NSArray *)totalDeals
{
    return [AGCollectTool sharedAGCollectTool].collectedDeals;
}

@end
