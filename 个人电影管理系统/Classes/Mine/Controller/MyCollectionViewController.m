//
//  MyCollectionViewController.m
//  个人电影管理系统
//
//  Created by Heisenbean on 17/3/9.
//  Copyright © 2017年 Heisenbean. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "FMDB.h"
#import "MovieModel.h"
#import "TopMovieCell.h"
#import "DetailViewController.h"
#import "YYModel.h"
@interface MyCollectionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *models;

@end

@implementation MyCollectionViewController

- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self loadSqliteData];
}

- (void)loadSqliteData{

    NSString *dataBasePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
        NSString *sqlMain = @"CREATE TABLE IF NOT EXISTS collection_table  (uid INTEGER,id INTEGER,title                                                                                                                         TEXT,images BLOB,summary TEXT,genres TEXT,year TEXT,aka TEXT,countries TEXT,original_title TEXT,rating TEXT,casts BLOB,directors BLOB);";
        if([db executeUpdate:sqlMain]) {
            NSUInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];

            FMResultSet *set = [db executeQuery:@"SELECT * FROM collection_table WHERE uid = ?",@(uid)];
            while ([set next]) {
                DetailMovie *movie = [[DetailMovie alloc]init];
                movie.title = [set stringForColumn:@"title"];
                movie.original_title = [set stringForColumn:@"original_title"];
                movie.id = [NSString stringWithFormat:@"%d",[set intForColumn:@"id"]];
                movie.imageDatas = [set dataForColumn:@"images"];
                movie.summary = [set stringForColumn:@"summary"];
                movie.genres = [[set stringForColumn:@"genres"] componentsSeparatedByString:@","];
                movie.year = [set stringForColumn:@"year"];
                movie.aka = [[set stringForColumn:@"aka"] componentsSeparatedByString:@","];
                movie.countries =  [[set stringForColumn:@"countries"] componentsSeparatedByString:@","];
                Rating *rat = [[Rating alloc]init];
                rat.average = [set stringForColumn:@"rating"].floatValue;
                movie.rating = rat;
                NSData *castData = [set dataForColumn:@"casts"];
                NSData *directorsData = [set dataForColumn:@"directors"];
                NSArray *casts = [NSKeyedUnarchiver unarchiveObjectWithData:castData];
                NSArray *directors = [NSKeyedUnarchiver unarchiveObjectWithData:directorsData];
                movie.casts = [NSArray yy_modelArrayWithClass:[Casts class] json:casts];
                movie.directors = [NSArray yy_modelArrayWithClass:[Casts class] json:directors];
                [self.models addObject:movie];
            }
            [self.tableView reloadData];
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    TopMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.localData = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *model = self.models[indexPath.row];
    DetailViewController *detail = [UIStoryboard initialViewControllerWithSbName:@"Detail"];
    detail.movieId = model.id;
    [self.navigationController pushViewController:detail animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieModel *m = self.models[indexPath.row];
    NSString *id = m.id;
    NSString *dataBasePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:dataBasePath];
    if ([db open]) {
        BOOL success = [db executeUpdate:@"DELETE FROM collection_table WHERE id = ?",id];
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"取消收藏"];
            [self.models removeObject:m];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消失败"];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"取消收藏";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
