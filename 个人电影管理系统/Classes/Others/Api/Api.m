//
//  Api.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "Api.h"
#import "YYModel.h"
@implementation Api
+ (instancetype)sharedAPI {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}



- (void)getHotShowingMovies:(NSString *)action pageNum:(NSUInteger )start countNum:(NSUInteger)num callback:(void (^)(NSArray<MovieModel *> *events, NSError *error))callback{
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,action]];
    
    // 2.创建一个网络请求
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.根据会话对象，创建一个Task任务：
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 5.对从服务器获取到的数据data进行相应的处理：
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        
        NSArray *event = [NSArray yy_modelArrayWithClass:[MovieModel class] json:dict[@"subjects"]];
        
        if (event) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(event,nil);
        });
           
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"msg":@"暂无数据"}];
                callback(nil,error);
            });
        }
    }];
    
    // 6.最后一步，执行任务（resume也是继续执行）:
    [sessionDataTask resume];
}


- (void)getDetailMovies:(NSString *)id callback:(void (^)(DetailMovie *model, NSError *))callback{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@subject/%@",baseUrl,id]];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        if(!dict){
            NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{@"msg":@"暂无数据"}];
            callback(nil,error);
        }else{
            DetailMovie *model = [DetailMovie yy_modelWithDictionary:dict];
            callback(model,nil);
        }
    }];
    
    [sessionDataTask resume];
}
@end
