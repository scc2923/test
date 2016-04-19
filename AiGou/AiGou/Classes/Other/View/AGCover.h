//
//  AGCover.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGCover : UIView

+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;

@end
