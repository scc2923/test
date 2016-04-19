//
//  AGBaseSettingViewController.m
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGBaseSettingViewController.h"
#import "UIBarButtonItem+AG.h"
#import "AGSettingCell.h"
#import "Defines.h"

const int AGCellSectionHeaderH = 20;

@interface AGBaseSettingViewController ()

@end

@implementation AGBaseSettingViewController

- (void)loadView
{
     _allGroups = [NSMutableArray array];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    //设置背景
    tableView.backgroundView = nil;
    tableView.backgroundColor = kGlobalBg;
    
    // group状态下，sectionFooterHeight和sectionHeaderHeight是有值的
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = AGCellSectionHeaderH;
    
    
    // 在tableView初始化的时候设置contentInset
    // 在tableView展示完数据的时候给contentInset.top增加64的值
    if (IOS7) {
        tableView.contentInset = UIEdgeInsetsMake(AGCellSectionHeaderH - 35, 0, 0, 0);
    }
    
    // 隐藏分隔线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view = tableView;
    
    _tableView = tableView;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AGSettingGroup *group = _allGroups[section];
    
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个ILSettingCell
    AGSettingCell *cell = [AGSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ILSettingItem）
    AGSettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 去除选中时的背景
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 0.取出这行对应的模型
    AGSettingGroup *group = _allGroups[indexPath.section];
    AGSettingItem *item = group.items[indexPath.row];
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
        return;
    }
    
    // 2.检测有没有要跳转的控制器
    if ([item isKindOfClass:[AGSettingArrowItem class]]) {
        AGSettingArrowItem *arrowItem = (AGSettingArrowItem *)item;
        if (arrowItem.showVCClass) {
            UIViewController *vc = [[arrowItem.showVCClass alloc] init];
            vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"arrow_merchant_detail_map_normal" highlightedIcon:nil target:self action:@selector(back)];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    AGSettingGroup *group = _allGroups[section];
    
    return group.header;
}

#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    AGSettingGroup *group = _allGroups[section];
    
    return group.footer;
}

@end
