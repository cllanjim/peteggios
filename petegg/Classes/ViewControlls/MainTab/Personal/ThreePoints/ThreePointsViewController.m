//
//  ThreePointsViewController.m
//  petegg
//
//  Created by czx on 16/5/3.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "ThreePointsViewController.h"
#import "IntroduceViewController.h"
#import "SuggestViewController.h"
#import "AgreementViewController.h"


@interface ThreePointsViewController ()

@end

@implementation ThreePointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self setNavTitle:@"关于"];
    self.view.backgroundColor = LIGHT_GRAY_COLOR;
    
}

-(void)setupView{
    [super setupView];
    UIImageView * tubiaobiao = [[UIImageView alloc]initWithFrame:CGRectMake(130.5 * W_Wide_Zoom, 100 * W_Hight_Zoom, 125 * W_Wide_Zoom, 125 * W_Hight_Zoom)];
    tubiaobiao.image = [UIImage imageNamed:@"tubiaobiao.png"];
    [self.view addSubview:tubiaobiao];

    UILabel * banbenLabel = [[UILabel alloc]initWithFrame:CGRectMake(160 *W_Wide_Zoom, 240 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    
    banbenLabel.text = @"SEGO V1.4";
    banbenLabel.textColor = [UIColor grayColor];
    banbenLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:banbenLabel];
    
    
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 300 * W_Hight_Zoom, 375 * W_Wide_Zoom, 150 * W_Hight_Zoom)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    NSArray * nameArray = @[@"产品简介",@"意见反馈",@"注册协议"];
    for (int i = 0 ; i < 3 ; i++) {
        UILabel * linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 50 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        linelabel.backgroundColor = [UIColor grayColor];
        linelabel.alpha = 0.3;
        [whiteView addSubview:linelabel];
        
        UILabel * namelabel = [[UILabel alloc]initWithFrame:CGRectMake(160.5 * W_Wide_Zoom, 10 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 100 *W_Wide_Zoom, 30 * W_Hight_Zoom)];
        namelabel.text = nameArray[i];
        namelabel.textColor = [UIColor lightGrayColor];
        namelabel.font = [UIFont systemFontOfSize:13];
        [whiteView addSubview:namelabel];
        
        UIButton * touchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom + i * 50 * W_Hight_Zoom, 375 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
        touchBtn.tag = i + 120;
        touchBtn.backgroundColor = [UIColor clearColor];
        [whiteView addSubview:touchBtn];
        [touchBtn addTarget:self action:@selector(someTouchcc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    
    UIButton * loginoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(50 * W_Wide_Zoom, 500 * W_Hight_Zoom, 275 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    loginoutBtn.backgroundColor = GREEN_COLOR;
    [loginoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [loginoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginoutBtn.layer.cornerRadius = 5;
    loginoutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:loginoutBtn];
    [loginoutBtn addTarget:self action:@selector(loginOutButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    

}
-(void)loginOutButtonTouch{
    //退出登录
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLoginStateChange object:@NO];
        [[AccountManager sharedAccountManager]logout];
        // 清除plist
        NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
        NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
        for(NSString* key in [dictionary allKeys]){
            [userDefatluts removeObjectForKey:key];
            [userDefatluts synchronize];
        }
        [userDefatluts setObject:@"1" forKey:@"STARTFLAG"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}
-(void)someTouchcc:(UIButton *)sender{
    if (sender.tag == 120) {
        IntroduceViewController * introlVc = [[IntroduceViewController alloc]init];
        [self.navigationController pushViewController:introlVc animated:YES];
        
        
    }else if (sender.tag == 121){
        SuggestViewController * suggVc = [[SuggestViewController alloc]init];
        [self.navigationController pushViewController:suggVc animated:YES];
    }else if (sender.tag == 122){
        

        AgreementViewController * agreeVc = [[AgreementViewController alloc]init];
        [self.navigationController pushViewController:agreeVc animated:YES];
    }
    
}

-(void)setupData{
    [super setupData];

}

@end