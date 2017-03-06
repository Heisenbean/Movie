//
//  TopMovieCell.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/3.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "TopMovieCell.h"

@implementation TopMovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MovieModel *)model{
    _name.text = model.title;
    [_movieIcon setImageWithURL:[NSURL URLWithString:model.images.medium] placeholder:[UIImage imageNamed:@""]];
    CGFloat average = model.rating.average;
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
    _score.text = [NSString stringWithFormat:@"%.1f",model.rating.average];
    NSMutableArray *casts  = [NSMutableArray array];
    NSMutableArray *directors  = [NSMutableArray array];
    for (Casts *cast in model.casts) {
        [casts addObject:cast.name];
    }
    
    for (Casts *cast in model.directors) {
        [directors addObject:cast.name];
    }
    
    NSString *castString = [casts componentsJoinedByString:@","];
    NSString *directorString = [directors componentsJoinedByString:@","];
    _caster.text = [NSString stringWithFormat:@"演员: %@",[castString stringByReplacingOccurrencesOfString:@"," withString:@"/"]];
    _director.text = [NSString stringWithFormat:@"导演: %@",[directorString stringByReplacingOccurrencesOfString:@"," withString:@"/"]];
}

@end
