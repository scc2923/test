//
//  UIImage+AG.h
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AG)
#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;
@end
