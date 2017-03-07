//
//  PhotoCell.h
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/7.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,copy) NSString *imageUrl;

@end
