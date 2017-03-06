//
//  CALayer+XibConfiguration.h
//  Doctor
//
//  Created by Heisenbean on 16/5/19.
//  Copyright © 2016年 @Zs. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XibConfiguration)
// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;
@end
