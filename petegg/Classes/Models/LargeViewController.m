//
//  LargeViewController.m
//  petegg
//
//  Created by yulei on 16/4/18.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "LargeViewController.h"
#import "UIImageView+WebCache.h"



@interface LargeViewController ()<UIActionSheetDelegate>
{
    
    QFTableView * mytableView;
    NSString * strUrl;
    
}

@end

@implementation LargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blackColor];
    
    
    
}

- (void)setupView
{
    [super setupView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    mytableView = [[QFTableView alloc] initWithFrame:CGRectMake(0, 60, 375, MainScreen.height)];
    mytableView.delegate   = self;
    mytableView.dataSource = self;
    mytableView.backgroundColor =[UIColor blackColor];
    mytableView.pagingEnabled = YES;
    [self.view addSubview:mytableView];

    [mytableView reloadData];
    
}

- (void)setupData
{
    [super setupData];
    
    
    
    
}

#pragma mark ---- QFTableViewDataSource,QFTableViewDelegate

- (CGFloat)QFTableView:(QFTableView *)fanView widthForIndex:(NSInteger)index
{
    return 375;
}


//返回横向tableView的Cell的个数
- (NSInteger)numberOfIndexForQFTableView:(QFTableView *)fanView
{
    
    NSArray *imageArray = [self.model.imagename componentsSeparatedByString:@","];
    
    return imageArray.count;
    
    
    
}

//为CotentView中的子视图控件重新赋值
- (void)QFTableView:(QFTableView *)fanView setContentView:(UIView *)contentView ForIndex:(NSInteger)index
{
    
    
    NSArray *imageArray = [self.model.imagename componentsSeparatedByString:@","];
  
    contentView.backgroundColor = [UIColor blackColor];
    contentView.userInteractionEnabled = YES;

    strUrl = imageArray[index];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 375, [UIScreen mainScreen].bounds.size.height - 108)];
    imageV.userInteractionEnabled = YES;
    imageV.backgroundColor = [UIColor blackColor];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    
    imageV.tag = index+9999;
    
    UILongPressGestureRecognizer *tapImageV = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
    [imageV addGestureRecognizer:tapImageV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap0Image:)];
    [imageV addGestureRecognizer:tap];
    
    //设置最小停留时间
    tapImageV.minimumPressDuration= 1.0;
    tapImageV.allowableMovement=50; //容许偏移量
    
    
    // 设置图片的显示模式
    
    [imageV sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"默认头像2副本.png"]];
    
    
    [contentView addSubview:imageV];
    
}

- (UIView *)QFTableView:(QFTableView *)fanView targetRect:(CGRect)targetRect ForIndex:(NSInteger)index
{
    UIImageView *imageV = [[UIImageView alloc]init];
    
    
    return imageV;
}

//图片点击事件

- (void)onTap0Image:(UITapGestureRecognizer *)tap
{
    
    CATransition *animation1 = [CATransition animation];
    animation1.duration = 1.2f;
    animation1.timingFunction=UIViewAnimationCurveEaseInOut;
    animation1.type    = kCATransitionMoveIn;
    animation1.subtype = kCATransitionMoveIn;
    [self.view.window.layer addAnimation:animation1 forKey:Nil];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


- (void)onTapImage:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                        otherButtonTitles:@"保存图片到相册", nil];
        [sheet showInView:self.view];
    }
    
}

#pragma mark- actionSheet的代理函数
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//保存图片
        NSArray *imageArray = [self.model.imagename componentsSeparatedByString:@","];

        NSURL *url = [NSURL URLWithString:imageArray[0]];
    
        NSData *resultData = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:resultData];
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        
    }
    
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    if (!error) {
       
        [self showSuccessHudWithHint:@"保存成功"];
        
    }else
    {
        [self showFailureHudWithHint:@"保存失败"];
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
