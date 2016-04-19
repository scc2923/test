//
//  AGDealCell.h
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGDeal;

@interface AGDealCell : UICollectionViewCell

// 描述
@property (weak, nonatomic) IBOutlet UILabel *desc;
// 图片
@property (weak, nonatomic) IBOutlet UIImageView *image;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *price;
// 购买人数
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;
// 标签
@property (weak, nonatomic) IBOutlet UIImageView *badge;

@property (nonatomic, strong) AGDeal *deal;

@end
