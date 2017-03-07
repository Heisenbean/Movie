//
//  DetailView.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "DetailView.h"
#import "CastCell.h"
#import "UIImageView+WebCache.h"

#define kPreferredMaxLayoutWidth [UIScreen mainScreen].bounds.size.width - 16
@implementation DetailView 

- (void)awakeFromNib{
    [super awakeFromNib];
    self.summryContent.preferredMaxLayoutWidth = kPreferredMaxLayoutWidth;
    self.castLabel.preferredMaxLayoutWidth = kPreferredMaxLayoutWidth;
    self.drictorName.preferredMaxLayoutWidth = kPreferredMaxLayoutWidth;
    self.summryLabel.preferredMaxLayoutWidth = kPreferredMaxLayoutWidth;
    self.akaLabel.preferredMaxLayoutWidth = kPreferredMaxLayoutWidth;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.myScrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.castCollectionView.frame));
}

- (void)setMovie:(DetailMovie *)movie{
    _movie = movie;
    [_movieIcon sd_setImageWithURL:[NSURL URLWithString:movie.images.large] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    _movieName.text = [NSString stringWithFormat:@"%@ (%@)",movie.original_title,movie.year];
    [_bgImage sd_setImageWithURL:[NSURL URLWithString:movie.images.large] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    _summryLabel.text = [NSString stringWithFormat:@"%@的简介",movie.original_title];
    _summryContent.text = movie.summary;
    _countryLabel.text = [NSString stringWithFormat:@"地区: %@",[movie.countries componentsJoinedByString:@","]];
    _akaLabel.text = [NSString stringWithFormat:@"又名: %@",[movie.aka componentsJoinedByString:@","]];
    _typeLabel.text = [NSString stringWithFormat:@"类型: %@",[movie.genres componentsJoinedByString:@","]];
    NSString *names = [self getStringValueFromArray:movie.casts];
    self.castLabel.text = [NSString stringWithFormat:@"演员: %@",names];
    NSString *directors = [self getStringValueFromArray:movie.directors];
    self.drictorName.text = [NSString stringWithFormat:@"导演: %@",directors];
    dispatch_async(dispatch_get_main_queue(), ^ {
        [self.castCollectionView reloadData];
    });
    
}


- (NSString *)getStringValueFromArray:(NSArray *)array{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:array.count];
    for (Casts *cast in array) {
        [temp addObject:cast.name];
    }
    return [temp componentsJoinedByString:@","];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movie.casts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CastCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.cast = self.movie.casts[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didClieckImage) {
        self.didClieckImage(self.movie.casts[indexPath.row],self.movie.casts,indexPath);
    }
}

@end
