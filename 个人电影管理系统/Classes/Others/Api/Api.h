//
//  Api.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"
#import "DetailMovie.h"
@interface Api : NSObject
+ (instancetype)sharedAPI;

/**
 获取热映电影

 @param start 开始位置
 @param num 每条数组个数
 @param callback 获取数据后的回调
 */
- (void)getHotShowingMovies:(NSUInteger )start countNum:(NSUInteger)num callback:(void (^)(NSArray<MovieModel *> *events, NSError *error))callback;


/**
 获取豆瓣top250电影

 @param start 开始位置
 @param num 个数
 @param callback 获取数据后的回调
 */
- (void)getTop250Movies:(NSUInteger )start countNum:(NSUInteger)num callback:(void (^)(NSArray<MovieModel *> *events, NSError *error))callback;


/**
 获取某个电影的详情数据

 @param id 电影id
 @param callback 获取数据后的回调
 */
- (void)getDetailMovies:(NSString *)id callback:(void (^)(DetailMovie  *movie, NSError *error))callback;


/**
 搜索

 @param keyword 输入的关键字
 @param callback 获取搜索后的数据
 */
- (void)searchMovie:(NSString *)keyword callback:(void (^)(NSArray<DetailMovie *> *results, NSError *error))callback;
@end
