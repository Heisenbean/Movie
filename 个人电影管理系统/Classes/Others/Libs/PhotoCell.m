//
//  PhotoCell.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/7.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "PhotoCell.h"
#import "UIImageView+WebCache.h"
@implementation PhotoCell
- (void)setImageUrl:(NSString *)imageUrl{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}
@end
