//
//  BaseTableViewController.m
//  petegg
//
//  Created by ldp on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "BaseTableViewController.h"



@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupData{
    _dataSource = [NSMutableArray array];
    _dataSourceImage =[NSMutableArray array];
    
}

- (void)setupView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.bGroupView ? UITableViewStyleGrouped : UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = GRAY_COLOR;
    
    [self.view addSubview:_tableView];
}

- (void)updateData
{
    [self.tableView.header beginRefreshing];
}

- (void)initRefreshView
{
    __typeof (&*self) __weak weakSelf = self;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = START_PAGE_INDEX;
        [weakSelf loadDataSourceWithPage:weakSelf.pageIndex];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ((weakSelf.pageIndex )* REQUEST_PAGE_SIZE == weakSelf.dataSource.count) {
            weakSelf.pageIndex++;
            [weakSelf loadDataSourceWithPage:weakSelf.pageIndex];
        }else{
            [weakSelf.tableView.footer endRefreshing];
            weakSelf.tableView.footer.hidden = YES;
        }
    }];
    
    self.tableView.footer.hidden = YES;
    [self.tableView.header beginRefreshing];
}

-(void)handleEndRefresh{
    
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}

- (void)loadDataSourceWithPage:(int)page {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    UIImageView *_headerView =[[UIImageView alloc]initWithFrame:CGRectMake(8*W_Wide_Zoom, 0*W_Hight_Zoom, 356*W_Wide_Zoom, 250*W_Hight_Zoom)];
    
    if ((image.size.width / image.size.height) < (_headerView.bounds.size.width / _headerView.bounds.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * _headerView.bounds.size.height / _headerView.bounds.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _headerView.bounds.size.width / _headerView.bounds.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage * newnewimage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return newnewimage;
    // return [UIImage imageWithCGImage:imageRef];
}


@end
