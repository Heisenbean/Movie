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

- (void)getHotShowingMovies:(NSUInteger )start countNum:(NSUInteger)num callback:(void (^)(NSArray<MovieModel *> *events, NSError *error))callback;

- (void)getTop250Movies:(NSUInteger )start countNum:(NSUInteger)num callback:(void (^)(NSArray<MovieModel *> *events, NSError *error))callback;


- (void)getDetailMovies:(NSString *)id callback:(void (^)(DetailMovie  *movie, NSError *error))callback;
@end
