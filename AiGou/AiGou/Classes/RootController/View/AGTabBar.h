//
//  AGTabBar.h
//  AiGou
//
//  Created by rimi on 14-12-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGTabBar;

@protocol AGTabBarDelegate <NSObject>

@optional           
- (void)tabBar:(AGTabBar *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to;

@end

@interface AGTabBar : UIView

@property (nonatomic, weak) id <AGTabBarDelegate> delegate;

- (void)addTabBarButton:(NSString *)icon selIcon:(NSString *)selIcon title:(NSString *)title;

@end
