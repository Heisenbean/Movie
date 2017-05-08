//
//  SearchResultCell.h
//  个人电影管理系统
//
//  Created by Heisenbean on 2017/5/8.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailMovie.h"
#import "UIImageView+WebCache.h"
@interface SearchResultCell : UITableViewCell
@property (strong,nonatomic) DetailMovie *model;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end
