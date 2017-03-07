//
//  DetailViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/6.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "DetailViewController.h"
#import "Api.h"
#import "CastCell.h"
#import "DetailView.h"
#import "PhotoBrwoserViewController.h"
@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet DetailView *detailView;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    __weak DetailViewController *weakSelf = self;
    self.detailView.didClieckImage = ^(Casts *cast,NSArray *casts,NSIndexPath *indexPath){
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:casts.count];
        for (Casts *cast in casts) {
            [array addObject:cast.avatars.large];
        }
        PhotoBrwoserViewController *browser = [UIStoryboard initialViewControllerWithSbName:@"PhotoBrowser"];
        browser.indexPath = indexPath;
        browser.photos = array;
        [weakSelf presentViewController:browser animated:YES completion:nil];
    };
    [self loadData];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[Api sharedAPI] getDetailMovies:self.movieId callback:^(DetailMovie *movie, NSError *error) {
        self.detailView.movie = movie;
        [SVProgressHUD dismiss];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
