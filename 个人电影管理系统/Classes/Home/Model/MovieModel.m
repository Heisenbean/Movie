//
//  MovieModel.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "MovieModel.h"
@implementation Image

@end

@implementation MovieModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"casts" : [Casts class],
             @"directors" : [Casts class]};
}
@end

@implementation Rating

@end

@implementation Casts

@end
