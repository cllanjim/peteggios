//
//  LargeViewController.h
//  petegg
//
//  Created by yulei on 16/4/18.
//  Copyright © 2016年 sego. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "QFTableView.h"
#import "ImageModel.h"

@interface LargeViewController : BaseViewController<QFTableViewDataSource,QFTableViewDelegate>

@property (nonatomic,strong)ImageModel * model;
@end
