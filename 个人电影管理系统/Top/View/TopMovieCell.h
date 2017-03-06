//
//  TopMovieCell.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/3.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface TopMovieCell : UITableViewCell
@property (strong,nonatomic) MovieModel *model;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *starIcon;
@property (weak, nonatomic) IBOutlet UILabel *director;
@property (weak, nonatomic) IBOutlet UILabel *caster;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
