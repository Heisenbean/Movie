//
//  SearchViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 2017/5/8.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultCell.h"
#import "DetailViewController.h"
#import "Api.h"
@interface SearchViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (strong,nonatomic) NSMutableArray <DetailMovie *>*datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noResultLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;



@end

@implementation SearchViewController

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchController delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [SVProgressHUD show];
    [[Api sharedAPI] searchMovie:searchText callback:^(NSArray<DetailMovie *> *results, NSError *error) {
        if (results.count > 0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.noResultLabel.alpha = 0.0;
            }];
            self.datas = [NSMutableArray arrayWithArray:results];
            [self.tableView reloadData];
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.noResultLabel.alpha = 1.0;
            }];
        }
        [SVProgressHUD dismiss];
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[NSBundle mainBundle] loadNibNamed:@"SearchResult" owner:nil options:nil].lastObject;
    }
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *mid = self.datas[indexPath.row].id;
        self.dismissCallback(mid);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
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
