//
//  LoginViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/3.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "LoginViewController.h"
#import "FMDB.h"
#import "SVProgressHUD.h"
#import "UIStoryboard+Category.h"
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)login {

    NSString *sqliteFilePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    NSLog(@"%@",DocumentPath);
    FMDatabase *db = [FMDatabase databaseWithPath:sqliteFilePath];
    if (![db open]) {   // 如果无法打开数据库,直接返回
        db = nil; return;
    }else{
        NSString *sqlMain = @"CREATE TABLE IF NOT EXISTS user_table  (uid INTEGER PRIMARY KEY AUTOINCREMENT,name                                                                                                                         TEXT,pwd TEXT);";
        if([db executeUpdate:sqlMain]) {
            FMResultSet *set = [db executeQuery:@"SELECT * FROM user_table WHERE name = ? COLLATE NOCASE",self.userName.text];
            while ([set next]) {    // 查询数据库是否有该用户
                NSString *name = [set stringForColumn:@"name"];
                FMResultSet *s = [db executeQuery:@"SELECT * FROM user_table WHERE name = ?",name];
                    if ([s next]) {
                        if ([self.password.text isEqualToString:[s stringForColumn:@"pwd"]]) {  // 成功匹配
                            [UIApplication sharedApplication].keyWindow.rootViewController = [UIStoryboard initialViewControllerWithSbName:@"Main"];
                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
                            return;
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"密码错误"];
                        }
                    }
                }
                [SVProgressHUD showInfoWithStatus:@"尚未注册,请先注册"];
                return;
        }
        [db close];
    }
}

// 用户注册完把用户资料插入数据库中的用户表
- (IBAction)regis {
    // 获取数据库在项目中的路径
    NSString *sqliteFilePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    NSLog(@"%@",DocumentPath);
    FMDatabase *db = [FMDatabase databaseWithPath:sqliteFilePath];
    if (![db open]) {   // 如果无法打开数据库,直接返回
        db = nil;
        return;
    }else{
        NSString *sqlMain = @"CREATE TABLE IF NOT EXISTS user_table  (uid INTEGER PRIMARY KEY AUTOINCREMENT,name                                                                                                                         TEXT,pwd TEXT);";
        if([db executeUpdate:sqlMain]) {
            NSMutableArray *array = [NSMutableArray array];
            FMResultSet *s = [db executeQuery:@"SELECT uid FROM user_table"];
            while ([s next]) {
                int uid = [s intForColumn:@"uid"];
                [array addObject:@(uid)];
            }
            CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] integerValue];
            FMResultSet *ss = [db executeQuery:@"SELECT * FROM user_table"];
            while ([ss next]) {
                NSString *name = [ss stringForColumn:@"name"];
                BOOL result = [name caseInsensitiveCompare:self.userName.text] == NSOrderedSame;
                if (result) {    // 如果有相同的名字,不能注册
                    [SVProgressHUD showErrorWithStatus:@"已注册过,请登录"];
                    return;
                }
            }
            BOOL success = [db executeUpdate:@"INSERT INTO user_table (name,pwd,uid) VALUES  (?,?,?)",self.userName.text,self.password.text,@(max+1)];
            if (success) {  // 插入数据成功
                [SVProgressHUD showSuccessWithStatus:@"注册成功,请登录!"];
            }else{
                NSLog(@"%@",[db lastError]);
            }
        }
        }

   
    [db close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"bey");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
