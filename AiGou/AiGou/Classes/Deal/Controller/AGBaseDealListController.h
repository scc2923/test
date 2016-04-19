//
//  AGBaseDealListController.h
//  AiGou
//
//  Created by rimi on 15/1/2.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGBaseShowDetailController.h"

@interface AGBaseDealListController : AGBaseShowDetailController
{
    UICollectionView *_collectionView;
}

- (NSArray *)totalDeals; // 所有的团购数据

@end
