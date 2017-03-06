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
@interface HotMovieViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong,nonatomic) NSMutableArray *models;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation HotMovieViewController

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
    
    CGFloat itemWidth = (kScreenSize.width - 2 * (itemMargin + itemLeftMargin)) / 3;
    CGFloat itemHeight = itemWidth * 1.7;
    self.layout.minimumLineSpacing = 20;
    self.myCollectionView.contentInset = UIEdgeInsetsMake(10, itemMargin, 20, itemMargin);
    self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}


- (void)loadData{
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/in_theaters"];
    
    // 2.创建一个网络请求
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];

    // 4.根据会话对象，创建一个Task任务：
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error) {
    // 5.对从服务器获取到的数据data进行相应的处理：
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
        NSArray *datas = dict[@"subjects"];
        for (NSDictionary *d in datas) {
            [self.models addObject:[MovieModel modelWithDictionary:d]];
        }
        [self.activity stopAnimating];
        [self.collectionView reloadData];
    }];
    
    // 6.最后一步，执行任务（resume也是继续执行）:
    [sessionDataTask resume];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.models = self.models[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
