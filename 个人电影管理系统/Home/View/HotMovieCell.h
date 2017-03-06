//
//  HotMovieCell.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface HotMovieCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *moviIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UIImageView *starIcon;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *noScoreLabel;
@property (strong,nonatomic) MovieModel *models;

@end
