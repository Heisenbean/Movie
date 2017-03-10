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
#import "FMDB.h"
#import "YYModel.h"
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

/* 收藏到个人收藏逻辑:
    1. 拿到当前电影id
    2. 检测自己本地电影数据库是否已经有收藏过
    3. 收藏过,跳出;未收藏,添加至数据库
 */
- (IBAction)collection {
    NSString *sqliteFilePath = [DocumentPath stringByAppendingPathComponent:@"data.sqlite"];
    NSLog(@"%@",DocumentPath);

    FMDatabase *db = [FMDatabase databaseWithPath:sqliteFilePath];
    if (![db open]) {   // 如果无法打开数据库,直接返回
        db = nil; return;
    }else{
        NSString *sqlMain = @"CREATE TABLE IF NOT EXISTS collection_table  (uid INTEGER,id INTEGER,title                                                                                                                         TEXT,images BLOB,summary TEXT,genres TEXT,year TEXT,aka TEXT,countries TEXT,original_title TEXT,rating TEXT,casts BLOB,directors BLOB);";
        if([db executeUpdate:sqlMain]) {
            FMResultSet *set = [db executeQuery:@"SELECT * FROM collection_table WHERE id = ? ",self.movieId];
            if ([set next]) {   // 如果有
                [SVProgressHUD showErrorWithStatus:@"您已收藏过"];
                return;
            }else{
                NSUInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"uid"];
                BOOL success = [db executeUpdate:@"INSERT INTO collection_table  (uid,id,title,images,summary,genres,year,aka,countries,original_title,rating,casts,directors) VALUES  (?,?,?,?,?,?,?,?,?,?,?,?,?)",
                                @(uid),
                                @(self.movieId.integerValue),
                                self.detailView.movie.title,
                                UIImagePNGRepresentation(self.detailView.movieIcon.image),
                                self.detailView.movie.summary,
                                [self.detailView.movie.genres componentsJoinedByString:@","],
                                self.detailView.movie.year,
                                [self.detailView.movie.aka componentsJoinedByString:@","],
                                [self.detailView.movie.countries componentsJoinedByString:@","],
                                self.detailView.movie.original_title,
                                @(self.detailView.movie.rating.average),
                                [self modelArrayToDicArray:self.detailView.movie.casts],
                                [self modelArrayToDicArray:self.detailView.movie.directors]];
                if (!success) {
                    [SVProgressHUD showErrorWithStatus:@"收藏失败"];
                    NSLog(@"%@",[db lastErrorMessage]);
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                }

            }

        }
    }
}

- (NSData *)modelArrayToDicArray:(NSArray *)models{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:models.count];
    // NSKeyedArchiver不能保存模型,所以数组中的模型要转为字典
    for (Casts *c in models) {
        [array addObject:[c yy_modelToJSONObject]];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    return data;
}


#pragma mark - MWPhotoBrowserDelegate
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

@end
