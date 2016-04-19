//
//  AGSearchController.m
//  AiGou
//
//  Created by Mac on 14/12/28.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGSearchController.h"
#import "AGMetaDataTool.h"
#import "AGCity.h"
#import "AGPopController.h"
#import "PinYin4Objc.h"

@interface AGSearchController ()
{
    NSMutableArray *_resultCities; // 放着所有搜索到的城市
}
@end

@implementation AGSearchController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _resultCities = [NSMutableArray array];
}

- (void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    // 1.清除之前的搜索结果
    [_resultCities removeAllObjects];
    
    // 2.筛选城市
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase; // 大小写
    fmt.toneType = ToneTypeWithoutTone; //声调
    fmt.vCharType = VCharTypeWithUUnicode;
    
    NSDictionary *cities = [AGMetaDataTool sharedAGMetaDataTool].totalCities;
    //遍历字典的key和value
    [cities enumerateKeysAndObjectsUsingBlock:^(NSString *key, AGCity *obj, BOOL *stop) {
        
        // 1.拼音
        NSString *pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:obj.name withHanyuPinyinOutputFormat:fmt withNSString:@"#"]; //#分隔
        
        // 2.拼音首字母
        NSArray *words = [pinyin componentsSeparatedByString:@"#"];
        NSMutableString *pinyinHeader = [NSMutableString string];
        for (NSString *word in words) {
            [pinyinHeader appendString:[word substringToIndex:1]]; //遍历每个汉字拼音的第一个字母
        }
        
        // 去掉所有的#
        pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // 3.城市名中包含了搜索条件
        // 拼音中包含了搜索条件
        // 拼音首字母中包含了搜索条件
        if (([obj.name rangeOfString:searchText].length != 0) ||
            ([pinyin rangeOfString:searchText.uppercaseString].length != 0)||
            ([pinyinHeader rangeOfString:searchText.uppercaseString].length != 0))
        {
            // 说明城市名中包含了搜索条件
            [_resultCities addObject:obj];
        }
    }];
    
    // 3.刷新表格
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"共%ld个搜索结果", (unsigned long)_resultCities.count];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    AGCity *city = _resultCities[indexPath.row];
    cell.textLabel.text = city.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AGCity *city = _resultCities[indexPath.row];
    
    [AGMetaDataTool sharedAGMetaDataTool].currentCity = city;
    //移除tableView
    [((AGPopController *)self.view.superview) dismiss:YES];
}

@end
