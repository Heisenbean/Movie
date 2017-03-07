//
//  CastCell.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "CastCell.h"
#import "UIImageView+WebCache.h"
@implementation CastCell

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)setCast:(Casts *)cast{
    _castName.text = cast.name;
    [_castImage sd_setImageWithURL:[NSURL URLWithString:cast.avatars.medium]  placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    
}
@end
