//
//  HotMovieCell.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "HotMovieCell.h"

@implementation HotMovieCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)setModels:(MovieModel *)models{
    _models = models;
    
    

    _movieName.text = models.title;
    if (models.rating.average != 0) {
        _scoreLabel.text = [NSString stringWithFormat:@"%.1f",models.rating.average];
    }else{
        _scoreLabel.text  = nil;
    }
    CGFloat average = models.rating.average;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_moviIcon setImageWithURL:[NSURL URLWithString:models.images.large] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
        if (average <= 3.1) {
            _starIcon.image = [UIImage imageNamed:@"icon_star_1"];
        }else if (average > 3.1 && average <= 5.1){
            _starIcon.image = [UIImage imageNamed:@"icon_star_2"];
        }else if (average > 5.1 && average <= 7.1){
            _starIcon.image = [UIImage imageNamed:@"icon_star_3"];
        }else if(average > 7.1 && average <= 8.9){
            _starIcon.image = [UIImage imageNamed:@"icon_star_4"];
        }else{
            _starIcon.image = [UIImage imageNamed:@"icon_star_5"];
        }
    });
    
    _noScoreLabel.hidden = models.rating.average;
    _starIcon.hidden = !models.rating.average;
}
@end
