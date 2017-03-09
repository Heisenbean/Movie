//
//  DetailMovie.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"

@interface DetailMovie : MovieModel
/// 电影原名
@property (nonatomic,copy) NSString *original_title;
/// 简介
@property (nonatomic,copy) NSString *summary;
/// 类型
@property (strong,nonatomic) NSArray *genres;
/// 年代
@property (nonatomic,copy) NSString *year;
/// 又名
@property (strong,nonatomic) NSArray *aka;
/// 地区
@property (strong,nonatomic) NSArray *countries;

@property (strong,nonatomic) NSData *imageDatas;

@end
