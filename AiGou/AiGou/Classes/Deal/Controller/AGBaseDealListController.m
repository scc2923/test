//
//  AGBaseDealListController.m
//  AiGou
//
//  Created by rimi on 15/1/2.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGBaseDealListController.h"
#import "AGDealCell.h"
#import "Defines.h"
#import "AGDeal.h"

@interface AGBaseDealListController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation AGBaseDealListController

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
//    [self initUserInterface];
}

- (NSArray *)totalDeals { return nil; }

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat v = 10;
        CGFloat h = 10;
        layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);// 每一行之间的间距寸
        // 每一个网格的尺寸
        layout.itemSize = CGSizeMake((kMainScreenW - 30)/2, kItemH);
        CGRect f = self.view.frame;
        if (IOS7) {
            f.size.height = self.view.frame.size.height - 110;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:f
                                             collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kGlobalBg;
        [_collectionView registerNib:[UINib nibWithNibName:@"AGDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
        
        // 设置collectionView永远支持垂直滚动(弹簧)
        _collectionView.alwaysBounceVertical = YES;
    }
    return _collectionView;
}

//- (void)initUserInterface
//{
//    // 0.创建自己的collectionView
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat v = 10; // 每一个网格的尺寸
//    CGFloat h = 10;
//    layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);// 每一行之间的间距寸
//    // 每一个网格的尺寸
//    layout.itemSize = CGSizeMake((kMainScreenW - 30)/2, kItemH);
////    CGRect f = self.view.frame;
////    if (IOS7) {
////        f.size.height = kMainScreenH;
////    }
//
//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
////    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [self.view addSubview:self.collectionView];
//    
//    // 1.注册cell要用到的xib
//    [self.collectionView registerNib:[UINib nibWithNibName:@"AGDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
//    
//    // 2.设置collectionView永远支持垂直滚动(弹簧)
//    self.collectionView.alwaysBounceVertical = YES;
//    
//    // 3.背景色
//    self.collectionView.backgroundColor = kGlobalBg;
//}

#pragma mark 在viewWillAppear和viewDidAppear中可以取得view最准确的宽高（width和height）
//- (void)viewWillAppear:(BOOL)animated
//{
//    // 默认计算layout
//    [self didRotateFromInterfaceOrientation:0];
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 屏幕旋转完毕的时候调用
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    // 1.取出layout
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    
//    // 2.计算间距
//    CGFloat v = 20;
//    CGFloat h = 0;
//    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) { // 横屏
//        h = (self.view.frame.size.width - 3 * kItemW) / 4;
//    } else {
//        h = (self.view.frame.size.width - 2 * kItemW) / 3;
//    }
//    [UIView animateWithDuration:2.0 animations:^{
//        layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);
//    }];
//}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:self.totalDeals[indexPath.row]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalDeals.count;
}

#pragma mark 刷新数据的时候会调用（reloadData）
#pragma mark 每当有一个cell重新进入屏幕视野范围内就会调用
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    AGDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.deal = self.totalDeals[indexPath.row];
    
    return cell;
}

@end
