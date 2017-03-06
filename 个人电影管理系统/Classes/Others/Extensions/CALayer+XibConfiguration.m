//
//  CALayer+XibConfiguration.m
//  Doctor
//
//  Created by Heisenbean on 16/5/19.
//  Copyright © 2016年 @Zs. All rights reserved.
//

#import "CALayer+XibConfiguration.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@implementation CALayer (XibConfiguration)
-(void)setBorderUIColor:(UIColor*)color{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor{
    return [UIColor colorWithCGColor:self.borderColor];
}
@end
