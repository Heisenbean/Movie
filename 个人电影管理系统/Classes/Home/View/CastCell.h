//
//  CastCell.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface CastCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *castImage;
@property (weak, nonatomic) IBOutlet UILabel *castName;
@property (strong,nonatomic) Casts *cast;

@end
