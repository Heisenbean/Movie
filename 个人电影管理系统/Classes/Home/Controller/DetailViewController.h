//
//  DetailViewController.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieModel;
@interface DetailViewController : UIViewController

@property (nonatomic,copy) NSString *movieId;
@property (strong,nonatomic) MovieModel *localData;

@end
