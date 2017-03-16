//
//  Top250ViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/2.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "Top250ViewController.h"
#import "TopMovieCell.h"
#import "DetailViewController.h"
#import "Api.h"
#import "MJRefresh.h"
@interface Top250ViewController ()
@property (strong,nonatomic) NSMutableArray *models;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSUInteger pageNum;

@end

@implementation Top250ViewController

- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.pageNum = 0;
    // Do any additional setup after loading the view.
}

- (void)configRefresh{
    self.tableView.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadData{
    [[Api sharedAPI] getTop250Movies:0 countNum:20 callback:^(NSArray<MovieModel *> *events, NSError *error) {
        self.models = [NSMutableArray arrayWithArray:events];
        [self.activity stopAnimating];
        [self.tableView reloadData];
        [self configRefresh];
    }];
}

- (void)loadMoreData{
    self.pageNum++;
    [[Api sharedAPI] getTop250Movies:self.pageNum countNum:20 callback:^(NSArray<MovieModel *> *events, NSError *error) {
        if (error) {
            self.pageNum--;
        }else{
            [self.models addObjectsFromArray:events];
            [self.activity stopAnimating];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    TopMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *model = self.models[indexPath.row];
    DetailViewController *detail = [UIStoryboard initialViewControllerWithSbName:@"Detail"];
    detail.movieId = model.id;
    [self.navigationController pushViewController:detail animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}


@end
