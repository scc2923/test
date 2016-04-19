//
//  AGLocationTool.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class AGCity;

@interface AGLocationTool : NSObject

singleton_interface(AGLocationTool)

@property (nonatomic, strong) AGCity *locationCity; // 定位城市

@end
