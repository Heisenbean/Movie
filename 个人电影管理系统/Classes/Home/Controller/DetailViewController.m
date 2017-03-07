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
#import "MWPhotoBrowser.h"
@interface DetailViewController ()<MWPhotoBrowserDelegate>
@property (strong, nonatomic) IBOutlet DetailView *detailView;
@property (strong,nonatomic) NSMutableArray *photos;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    __weak DetailViewController *weakSelf = self;
    self.detailView.didClieckImage = ^(Casts *cast,NSArray *casts,NSIndexPath *indexPath){
    
        weakSelf.photos = [NSMutableArray arrayWithCapacity:casts.count];
        for (Casts *cast in casts) {
            [weakSelf.photos addObject:[[MWPhoto alloc]initWithURL:[NSURL URLWithString:cast.avatars.large]]];
        }
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:weakSelf];
        [browser setCurrentPhotoIndex:indexPath.row];
        [weakSelf.navigationController pushViewController:browser animated:YES];

        
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

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
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
