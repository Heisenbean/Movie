//
//  SearchResultCell.m
//  个人电影管理系统
//
//  Created by Heisenbean on 2017/5/8.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DetailMovie *)model{
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.images.large] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.nameLabel.text = model.title;
    self.detailLabel.text = [NSString stringWithFormat:@"%.1f分",model.rating.average];
    self.yearLabel.text = model.year;
    [self.nameLabel sizeToFit];
    [self.detailLabel sizeToFit];
}

@end
