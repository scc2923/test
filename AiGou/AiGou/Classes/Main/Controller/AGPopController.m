//
//  AGPopController.m
//  AiGou
//
//  Created by Mac on 14/12/28.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGPopController.h"
#import "AGCitySection.h"
#import "AGMetaDataTool.h"
#import "AGCity.h"
#import "AGSearchController.h"

@interface AGPopController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    AGSearchController *_searchResult;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray * citySections; //所有城市组
@property (nonatomic) CGPoint showPoint; //弹框出现的点

@property (nonatomic, strong) UIButton *handerView; //遮盖蒙板

@end

@implementation AGPopController

- (id)initWithPoint:(CGPoint)point
{
    self = [super init];
    if (self) {
        self.showPoint = point;
        [self loadCitiesData];
        self.frame = CGRectMake(0, 0, 300, 200);
        [self addSubview:self.tableView];
        [self addSubview:self.searchBar];
        
    }
    return self;
}

#pragma mark 加载城市数据
- (void)loadCitiesData
{
    _citySections = [NSMutableArray array];
    
    NSArray *sections = [AGMetaDataTool sharedAGMetaDataTool].totalCitySections;
    [_citySections addObjectsFromArray:sections];
    [self.tableView reloadData];
}

#pragma mark - Other
- (void)show
{
    //window上添加蒙版
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    //设置出现动画
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    self.frame = CGRectMake(0, 64, 200, 330);
    
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08 delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

- (void)dismiss
{
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animate
{
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
    }];
    
}

#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, 200, 300) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 30)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入城市名或拼音";
    }
    return _searchBar;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AGCitySection *citySec = _citySections[section];
    return citySec.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    AGCitySection *sec = _citySections[indexPath.section];
    AGCity *city = sec.cities[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    AGCitySection *sec = _citySections[section];
    return sec.name;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    // 会取出_citySections中所有元素name属性的值，并且放到数组中返回
//    return [_citySections valueForKeyPath:@"name"];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AGCitySection *s = _citySections[indexPath.section];
    AGCity *city = s.cities[indexPath.row];
    //单例中setCurrentCity方法中发出通知改变当前城市
    [AGMetaDataTool sharedAGMetaDataTool].currentCity = city;
    //    if (self.selectedCity) {
    //        self.selectedCity(city.name); //设置城市名的block
    //    }
    [self dismiss:YES];
}

#pragma mark UISearchBarDelegate
//搜索框文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        // 隐藏搜索界面
        [_searchResult.view removeFromSuperview];
    } else {
        // 显示搜索界面
        if (_searchResult == nil) {
            _searchResult = [[AGSearchController alloc] init];
            _searchResult.view.frame = _tableView.frame;
        }
        _searchResult.searchText = searchText;
        [self addSubview:_searchResult.view];
    }
}

@end
