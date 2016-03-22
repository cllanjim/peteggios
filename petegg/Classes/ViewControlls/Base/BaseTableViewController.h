//
//  BaseTableViewController.h
//  petegg
//
//  Created by ldp on 16/3/22.
//  Copyright © 2016年 ldp. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, assign) BOOL bGroupView;

//资源数组
@property (nonatomic, strong) NSMutableArray* dataSource;

@property (nonatomic, assign) int pageIndex;

//加载分页数据
- (void)loadDataSourceWithPage:(int)page;

- (void)handleEndRefresh;

//更新数据从开始
- (void)updateData;

@end