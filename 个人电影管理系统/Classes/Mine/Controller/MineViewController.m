//
//  MineViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "MineViewController.h"
#import "MyCollectionViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {   // my collection
        MyCollectionViewController *collection = [UIStoryboard initialViewControllerWithSbName:@"Collection"];
        [self.navigationController pushViewController:collection animated:YES];
    }else if (indexPath.row == 1){  // about us
    
    }else{  // logout
        
    }
}

@end
