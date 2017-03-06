//
//  MovieModel.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <Foundation/Foundation.h>

// 图片模型
@interface Image : NSObject
@property (nonatomic,copy) NSString *small;

@property (nonatomic,copy) NSString *large;

@property (nonatomic,copy) NSString *medium;
@end

// 评分模型
@interface Rating : NSObject
@property (nonatomic,assign) CGFloat max;

@property (nonatomic,assign) CGFloat average;

@property (nonatomic,copy) NSString *stars;

@property (nonatomic,assign) CGFloat min;
@end

// 演员模型
@interface Casts : NSObject
@property (nonatomic,copy) NSString *alt;   // 演员主页

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *id;

@property (strong,nonatomic) Image *avatars;

@end

// 电影模型
@interface MovieModel : NSObject
@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) Image *images;

@property (strong,nonatomic) Rating *rating;

@property (strong,nonatomic) NSArray  *casts;  // 演员

@property (strong,nonatomic) NSArray  *directors;  // 导演

@property (nonatomic,copy) NSString *id;

@end
