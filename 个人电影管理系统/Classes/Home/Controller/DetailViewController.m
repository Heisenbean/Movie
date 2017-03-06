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

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet DetailView *detailView;

@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.castCollectionView registerClass:[CastCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self loadData];
}

- (void)loadData{
    [[Api sharedAPI] getDetailMovies:self.movieId callback:^(DetailMovie *movie, NSError *error) {
        self.detailView.movie = movie;
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
