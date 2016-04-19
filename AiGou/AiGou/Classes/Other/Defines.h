//
//  Defines.h
//  AiGou
//
//  Created by rimi on 14-12-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#define IOS5 [[UIDevice currentDevice].systemVersion floatValue] < 6
#define IOS6 [[UIDevice currentDevice].systemVersion floatValue] < 7
#define IOS7 [[UIDevice currentDevice].systemVersion floatValue] >= 7

// 更新应用
#define AGAppId(id) #id

// 分享账号
#define My_App_Kye @"1397404784"

#define My_App_Secret @"fe1a560243d7beba1bddde39aa99d216"

/*
 控件尺寸
 */

// 主屏幕宽度
#define kMainScreenW [UIScreen mainScreen].bounds.size.width
// 主屏幕高度
#define kMainScreenH [UIScreen mainScreen].bounds.size.height

// 1.Dock上条目的尺寸
#define kDockItemW 100
#define kDockItemH 80

// navc高
#define kNavcBarH 64
// tabBar高
#define kTabBarH 49

// 顶部菜单项的设置
#define kTopMenuItemW [UIScreen mainScreen].bounds.size.width/3
#define kTopMenuItemH 35
#define kTopFont 13.5
// 顶部文字颜色
#define kTopTintColorN [UIColor colorWithWhite:0.3 alpha:0.7]
// 顶部文字高亮颜色
#define kTopTintColorH [UIColor colorWithWhite:0.7 alpha:0.7]

// 底部菜单项的宽高
#define kBottomMenuItemW (kMainScreenW/4)
#define kBottomMenuItemH 40
// 底部文字颜色
#define kBottomTintColorN [UIColor colorWithWhite:0.15 alpha:0.8]
// 底部Subtitle文字颜色
#define kSubTintColorN [UIColor colorWithWhite:0.07 alpha:0.9]

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// 3.通知名称
// 城市改变的通知
#define kCityChangeNote @"city_change"
// 区域改变的通知
#define kDistrictChangeNote @"district_change"
// 分类改变的通知
#define kCategoryChangeNote @"category_change"
// 排序改变的通知
#define kOrderChangeNote @"order_change"
// 收藏改变的通知
#define kCollectChangeNote @"collect_change"

// 城市的key
#define kCityKey @"city"

#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];


// 4.全局背景色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]
// 更多文字颜色
#define kWordColor [UIColor colorWithRed:22.0f/255.0f green:190.0f/255.0f blue:168.0f/255.0f alpha:0.5]
// 获得颜色
#define AGColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

// tabBar
// 5.默认的动画时间
#define kDefaultAnimDuration 0.3
#define kDuration 0.3
// 默认遮盖alpha值
#define kCoverAlpha 0.4

// 每一个子标题按钮的宽度
#define kTitleW (kMainScreenW/4)
// 每一个子标题按钮的高度
#define kTitleH 30

// celloctionViewCell宽高
#define kItemW 145
#define kItemH 160

// 6.固定的字符串
#define kAllCategory @"全部分类"
#define kAllDistrict @"全部商区"
#define kDefaultSort @"默认排序"
#define kAll @"全部"

// 7.更多
// 关于的详细内容
#define kScript @"\t网络团购的商业模式分析[摘要 摘要]文章主要对网络团购的商业模式进行分析，通过介绍我国团购发展情况， 摘要 出现的问题，然后从商业模式、市场运作方式、线下商品整合能力、用户需求这 四个方面对所出现的问题进行解决。 \n\n\t网络团购、影响、我国发展现状，解决 关键词 Groupon,相信这个名字大家都很熟悉，也是今年网络 fashion 的代表。它为 消费者带来了实惠、方便、快捷的同时也为商户带来了市场推广、宣传、销售、 便利等。\n\n\t它就是美国团购网站，在其上线半年即实现盈利并获机构 1.35 亿美元 投资的刺激，从今年 3 月王兴推出美团网至今，24 券、拉手网、爱帮网、阿丫 网、F 团等近 400 家团购网站纷纷冒出，展开对中国团购市场的激烈争夺。据中 国电子商务研究中心近日发布的《2010 年(上)中国电子商务市场数据监测报告》 显示，截止到 2010 年 6 月底，国内团购网站数量已飙升到 480 家，预计到 2010 年底，国内团购网站数量有望达到 880 家。"
// 电话
#define kPhone @"客服电话     028-892893657"

// 更多自定义cell属性
#define kTableViewCellH 40

// TableView组数（行数）
#define kTableViewH 3

// TableView头行数
#define kTableFooterCount 8




