//
//  HotMovieViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "HotMovieViewController.h"
#import "HotMovieCell.h"
#import "MovieModel.h"
#import "SVProgressHUD.h"
#import "Api.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
@interface HotMovieViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong,nonatomic) NSMutableArray *models;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation HotMovieViewController
static NSString *CellIdentifier = @"cell";
- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

- (void)configUI{
    
    CGFloat itemLeftMargin = 14;
    CGFloat itemMargin = 16;
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 2 * (itemMargin + itemLeftMargin)) / 3;
    CGFloat itemHeight = itemWidth * 1.7;
    self.layout.minimumLineSpacing = 20;
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10, itemMargin, 20, itemMargin);
    self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"login"]) {    // 游客模式
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}

- (IBAction)search:(id)sender {
     SearchViewController *search = [UIStoryboard initialViewControllerWithSbName:@"Search"];
    search.dismissCallback = ^(NSString *id) {
        DetailViewController *detail = [UIStoryboard initialViewControllerWithSbName:@"Detail"];
        detail.movieId = id;
        [self.navigationController pushViewController:detail animated:YES];
    };
    //    SearchViewController *search = [[SearchViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:search];
    
    [self presentViewController:search animated:YES completion:nil];
}

- (void)loadData{
    [[Api sharedAPI] getHotShowingMovies:0 countNum:10 callback:^(NSArray<MovieModel *> *events, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[@"msg"]];
        }
        self.models = [NSMutableArray arrayWithArray:events];
        [self.collectionView reloadData];
        [self.activity stopAnimating];
    }];
}

#pragma mark - UICollectionViewDataSource
// 返回多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

// cell的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.models = self.models[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
//  点击了某一个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *model = self.models[indexPath.row];
    DetailViewController *detail = [UIStoryboard initialViewControllerWithSbName:@"Detail"];
    detail.movieId = model.id;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
