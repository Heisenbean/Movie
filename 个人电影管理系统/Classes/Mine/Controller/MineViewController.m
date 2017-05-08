//
//  MineViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "MineViewController.h"
#import "MyCollectionViewController.h"
#import "FMDB.h"
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
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"login"]) {    // 游客模式
            [SVProgressHUD showErrorWithStatus:@"请先注册并登陆"];
            return;
        }
        MyCollectionViewController *collection = [UIStoryboard initialViewControllerWithSbName:@"Collection"];
        [self.navigationController pushViewController:collection animated:YES];
    }else if (indexPath.row == 1){  // about us
    
    }else  if (indexPath.row == 2){  // logout
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定退出账号吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
            [UIApplication sharedApplication].keyWindow.rootViewController = [UIStoryboard initialViewControllerWithSbName:@"Login"];
        }];
        [alert addAction:cancel];
        [alert addAction:certain];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定注销账号吗?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *certain = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self deleteUserData];
        }];
        [alert addAction:cancel];
        [alert addAction:certain];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:nil];
        });

    }
}

- (void)deleteUserData{
    NSString *sqliteFilePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:sqliteFilePath];
    if (![db open]) {   // 如果无法打开数据库,直接返回
        db = nil; return;
    }else{
        NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];
        BOOL success1 = [db executeUpdate:@"DELETE FROM user_table WHERE uid = ?",@(uid)];
        BOOL success2 = [db executeUpdate:@"DELETE FROM collection_table WHERE uid = ?",@(uid)];
        if (success1 && success2) {
            [SVProgressHUD showSuccessWithStatus:@"注销成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
                [UIApplication sharedApplication].keyWindow.rootViewController = [UIStoryboard initialViewControllerWithSbName:@"Login"];
            });
        }
    }
}

@end
