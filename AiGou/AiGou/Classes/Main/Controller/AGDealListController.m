//
//  AGBuyController.m
//  AiGou
//
//  Created by Mac on 14/12/28.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealListController.h"
#import "AGPopController.h"
#import "AGMetaDataTool.h"
#import "AGDealTopMenu.h"
#import "NSObject+Value.h"
#import "AGDealCell.h"
#import "AGDealTool.h"
#import "Defines.h"
#import "AGDeal.h"

#import "MJRefresh.h"
#import "AGImageTool.h"
#import "AGDealDetailController.h"

@interface AGDealListController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray * _deals;
    UICollectionView * _collectionView;
    
    int _page; // 页码
}

@property (nonatomic, strong)UICollectionView * collectionView;

@end

@implementation AGDealListController

#pragma mark - getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat v = 10;
        CGFloat h = 10;
        layout.sectionInset = UIEdgeInsetsMake(v, h, 5, h);// 每一行之间的间距寸
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.基本设置
    [self baseSetting];

#warning 设置当前默认城市为北京
//    [AGMetaDataTool sharedAGMetaDataTool].currentCity = [AGMetaDataTool sharedAGMetaDataTool].totalCities[@"北京"];
    
    NSString *name = [AGMetaDataTool sharedAGMetaDataTool].currentCity.name;
    if (name != nil) {
        [self dataChange];
    }
}
- (void)dataChange
{
    [self.collectionView headerBeginRefreshing];
}

- (NSArray *)totalDeals
{
    return _deals;
}

#pragma mark 基本设置
- (void)baseSetting
{
    // 1.监听城市改变的通知
     kAddAllNotes(setCurrentCity);
    
    // 2.设置背景色
    self.view.backgroundColor = kGlobalBg;
    
    // 3.右边的搜索框
//    UISearchBar *s = [[UISearchBar alloc] init];
//    s.frame = CGRectMake(0, 0, 210, 35);
//    s.placeholder = @"请输入商品名、地址等";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:s];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"定位中"
                                                                              style:UIBarButtonItemStylePlain target:self
                                                                             action:@selector(selectedCity:)];
//    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"icon_tabbar_nearby"];
    // 4.菜单栏
    AGDealTopMenu * top = [[AGDealTopMenu alloc] init];
    
    top.contentView = self.view;
    top.contentView.frame = CGRectMake(0, kTopMenuItemH, self.view.frame.size.width, self.view.frame.size.height-kTopMenuItemH);
    
    [self.view addSubview:top];
    
    // 5.注册cell要用到的xib
    [self.view addSubview:self.collectionView];
    
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefreshing)];
    [self.collectionView addFooterWithTarget:self action:@selector(footerRefreshing)];
}


- (void)headerRefreshing
{
    // 清除图片缓存
    [AGImageTool clear];
    _page = 1; // 第一页
    
    // 加载第_page页的数据
    [[AGDealTool sharedAGDealTool] dealsWithPage:_page success:
     ^(NSArray *deals, int totalCount) {
             _deals = [NSMutableArray array];
         
         // 1.添加数据
         [_deals addObjectsFromArray:deals];
         
         // 2.刷新表格
         [_collectionView reloadData];
         
         // 3.恢复刷新状态
         [self.collectionView headerEndRefreshing];
         
     } error:^(NSError *error) {
         [self.collectionView headerEndRefreshing];;
     }];
}

- (void)footerRefreshing
{
     _page++;
    
    // 加载第_page页的数据
    [[AGDealTool sharedAGDealTool] dealsWithPage:_page success:
     ^(NSArray *deals, int totalCount) {
         // 1.添加数据
         [_deals addObjectsFromArray:deals];
         
         // 2.刷新表格
         [_collectionView reloadData];
         
         // 3.恢复刷新状态
         [self.collectionView footerEndRefreshing];
         
         // 4.根据数量判断是否需要隐藏上拉控件
         self.collectionView.footerHidden = _deals.count >= totalCount;
         
     } error:^(NSError *error) {
         [self.collectionView footerEndRefreshing];;
     }];
}


#pragma mark - 点击弹出选择城市弹框
- (void)selectedCity:(UIBarButtonItem *)item
{
    AGPopController * popover = [[AGPopController alloc] initWithPoint:CGPointZero];
    //改变当前城市名称的block
//        popover.selectedCity = ^(NSString *name){
//            [self.navigationItem.leftBarButtonItem setTitle:name];
//        };
    [popover show];
}

#pragma mark - 通知设置当前城市
- (void)setCurrentCity
{
    //从单例中获取当前城市名
    [self.navigationItem.leftBarButtonItem setTitle:[AGMetaDataTool sharedAGMetaDataTool].currentCity.name];
    [self dataChange];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _deals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    AGDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.deal = _deals[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetails:_deals[indexPath.row]];
}

- (void)showDetails:(AGDeal *)deal
{
    AGDealDetailController *details = [[AGDealDetailController alloc] init];
    details.deal = deal;
    [self.navigationController pushViewController:details animated:YES];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
