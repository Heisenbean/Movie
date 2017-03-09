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
@interface Top250ViewController ()
@property (strong,nonatomic) NSMutableArray *models;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    // Do any additional setup after loading the view.
}

- (void)loadData{
    [[Api sharedAPI] getTop250Movies:0 countNum:20 callback:^(NSArray<MovieModel *> *events, NSError *error) {
        self.models = [NSMutableArray arrayWithArray:events];
        [self.activity stopAnimating];
        [self.tableView reloadData];
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
