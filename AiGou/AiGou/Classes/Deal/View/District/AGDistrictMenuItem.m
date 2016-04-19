//
//  AGDistrictMenuItem.m
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDistrictMenuItem.h"
#import "AGDistrict.h"

@implementation AGDistrictMenuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDistrict:(AGDistrict *)district
{
    _district = district;
    [self setTitle:district.name forState:UIControlStateNormal];
}

- (NSArray *)titles
{
    return _district.neighborhoods;
}

@end
