//
//  AppDelegate.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "AppDelegate.h"
#import "UIStoryboard+Category.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initConfig];
    return YES;
}

- (void)initConfig{
    NSString *dataBasePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    NSLog(@"%@",dataBasePath);
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"login"];
    if (isLogin) {  // 已经登陆
        self.window.rootViewController =  [UIStoryboard initialViewControllerWithSbName:@"Main"];
    }else{
        self.window.rootViewController =  [UIStoryboard initialViewControllerWithSbName:@"Login"];
    }
    [self.window makeKeyAndVisible];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
