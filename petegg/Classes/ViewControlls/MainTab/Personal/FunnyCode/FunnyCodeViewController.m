//
//  FunnyCodeViewController.m
//  petegg
//
//  Created by yulei on 16/4/11.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FunnyCodeViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface FunnyCodeViewController ()<UITextFieldDelegate>
{
    
    UIButton * _bigButton;
    UIView *_centerView;
    UITextField * _preiceNumberTexiField;
    UITextField * _fangwentoushiTextField;
    NSTimer * _timer;
    int timeTF;
    NSString * pcidStr;
    NSString * endTime;
    
    
    
    
}

@end

@implementation FunnyCodeViewController
@synthesize ceishi;


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    ceishi.delegate = self;
   
    self.view.backgroundColor =[UIColor whiteColor];
    [self setNavTitle: NSLocalizedString(@"funTitle", nil)];
    
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    
    
    /**
     *  查询
     */
    
    [self checkMessage];
    
    
    
}

- (void)setupView{
    
    [self showBarButton:NAV_RIGHT imageName:@"doumashare.png"];
    [self creatGoto];
    
    
    
    
    
    
}



/**
 *   分享
 */
- (void)doRightButtonTouch

{
    if ([self.onFunyCode.text isEqualToString:@"暂无"]) {
        
        [self showSuccessHudWithHint:@"请生成有效逗码！"];
    }else
    {
    
    
  // 1、创建分享参数
  NSArray *imageArray = @[ [UIImage imageNamed:@"segoColor.jpg"] ];
  //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数

    
 // QQ空间分享失败的原因为 image url title 不能为nil 是一种图文链接的方式
  if (imageArray) {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams
     SSDKSetupShareParamsByText:[NSString stringWithFormat:@"赛果分享[%@]此逗码%@之前有效，复制这条信息，打开赛果不倒蛋软件，即可控制分享者的设备开启远程互动(软件下载地址：http://www.segopet.com/download.html)", self.onFunyCode.text,endTime]
                            images:nil
                               url:nil
                             title:@"赛果逗码分享"
                              type:SSDKContentTypeAuto];
      
      
    // 2、分享（可以弹出我们的分享菜单和编辑界面）
    [ShareSDK showShareActionSheet: nil items:nil shareParams:shareParams onShareStateChanged:^(
             SSDKResponseState state, SSDKPlatformType platformType,
             NSDictionary *userData, SSDKContentEntity *contentEntity,
             NSError *error, BOOL end) {
        
           switch (state) {
           case SSDKResponseStateSuccess: {
             UIAlertView *alertView =
                 [[UIAlertView alloc] initWithTitle:@"分享成功"
                                            message:nil
                                           delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];
             [alertView show];
            [ceishi becomeFirstResponder];

//               NSLog(@"22222");
//               __weak FunnyCodeViewController *weakSelf = self;
//               dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
//               
//            
//               
//               dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                   
//                  
//                   [weakSelf yanchi];
//               });
             break;
           }
           case SSDKResponseStateFail: {
             UIAlertView *alert = [[UIAlertView alloc]
                     initWithTitle:@"分享失败"
                           message:[NSString stringWithFormat:@"%@", error]
                          delegate:nil
                 cancelButtonTitle:@"OK"
                 otherButtonTitles:nil, nil];
               
             [alert show];
            [[[UIApplication sharedApplication] keyWindow] resignFirstResponder];

             break;
           }
           default:
             break;
           }
    }];
      
  }
        
    }
}



    
   


/**
 *
 * 生成逗码
 */
- (IBAction)productMycode:(UIButton *)sender {
    
   

    if ([self.onFunCodeBtn.titleLabel.text isEqualToString:@"生成我的逗码"]) {
        _bigButton.hidden = NO;
        _centerView.hidden = NO;
    }else{
        [self.onFunCodeBtn setTitle:@"立即失效" forState:UIControlStateNormal];
        [self lostData];
    }
    
}


- (void)checkMessage
{
    
    NSString * str =@"clientAction.do?method=json&common=queryPlayCodeTime&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
        
        NSMutableArray * arr =json[@"jsondata"][@"list"];
        if (arr.count == 0) {
            self.onFunprice.text =@"暂无";
            self.onFunfood.text =@"暂无";
            self.onFuntime.text =@"暂无";
            self.onFunyCode.text =@"暂无";
            
            
        }else{
        
        if ([[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"status"] isEqualToString:@"0"] || [[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"seconds"] isEqualToString:@"0"]){
            self.onFunprice.text =@"暂无";
            self.onFunfood.text =@"暂无";
            self.onFuntime.text =@"暂无";
            self.onFunyCode.text =@"暂无";
          
        }else
        {
    
            self.onFunyCode.text = [NSString stringWithFormat:@"%@",[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"playcode"]];
            self.onFunfood.text =[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"tsnum"];
            self.onFunprice.text =[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"price"];
            self.onFuntime.text =[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"seconds"];
            pcidStr  =[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"pcid"];
            endTime =[[json objectForKey:@"jsondata"]objectForKey:@"list"][0][@"endtime"];
            self.onFuntime.text =endTime;
            [self.onFunCodeBtn setTitle:@"立即失效" forState:UIControlStateNormal];
            
//            timeTF = [self.onFuntime.text intValue];
//            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }
        
            
}
    } failure:^(NSError *error) {
        
    }];

    
    
}

-(void)timeFireMethod{
    self.onFuntime.text = [NSString stringWithFormat:@"%d",timeTF];
    timeTF--;
    if (timeTF == 0) {
        [_timer invalidate];
     
        self.onFunprice.text =@"暂无";
        self.onFunfood.text =@"暂无";
        self.onFuntime.text =@"暂无";
        self.onFunyCode.text =@"暂无";
        
    }

}

/**
 *确认
 */
- (void)sureBtn:(UIButton *)sender {
    
    [self buttonHidden];
   
    
    
    if ([AppUtil isBlankString:_preiceNumberTexiField.text]) {
         _preiceNumberTexiField.text =@"0";
    }
    if ([AppUtil isBlankString:_fangwentoushiTextField.text]) {
        _fangwentoushiTextField.text =@"0";
        
    }
    
    NSString * str =@"clientAction.do?method=json&common=generatePlayCode&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:[AccountManager sharedAccountManager].loginModel.mid forKey:@"mid"];
    [dic setObject:_preiceNumberTexiField.text forKey:@"price"];
    [dic setObject:_fangwentoushiTextField.text forKey:@"tsnum"];
    
    [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
      
        if ([[[json objectForKey:@"jsondata"]objectForKey:@"retCode"] isEqualToString:@"0000"]) {
            [self checkMessage];
            [self.onFunCodeBtn setTitle:@"立即失效" forState:UIControlStateNormal];
            self.onFunCodeBtn.enabled = YES;
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];

    
    

}

- (void)cancelBtn:(UIButton *)sender
{
    [self buttonHidden];
    
    
}


//弹出东东
-(void)creatGoto{
    
    _bigButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bigButton.hidden = YES;
    _bigButton.backgroundColor = [UIColor lightGrayColor];
    _bigButton.alpha = 0.3;
     [[UIApplication sharedApplication].keyWindow addSubview:_bigButton];
    [_bigButton addTarget:self action:@selector(buttonHidden) forControlEvents:UIControlEventTouchUpInside];
    
    _centerView = [[UIView alloc]initWithFrame:CGRectMake(50, 200, 275, 130)];
    _centerView.backgroundColor = [UIColor whiteColor];
    _centerView.layer.cornerRadius = 5;
    _centerView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:_centerView];
    NSArray * nameArray = [NSArray arrayWithObjects:@"访问价格:",@"访问投食:", nil];
    for (int i = 0 ; i < 2; i ++) {
        UILabel * lineLabeles = [[UILabel alloc]initWithFrame:CGRectMake(0, 40 + i * 40, 275, 0.5)];
        lineLabeles.backgroundColor = [UIColor grayColor];
        [_centerView addSubview:lineLabeles];
        
        UILabel * towNamelabeles = [[UILabel alloc]initWithFrame:CGRectMake(25, 10 + i * 40, 100, 20)];
        towNamelabeles.text = nameArray[i];
        towNamelabeles.textColor = [UIColor blackColor];
        towNamelabeles.font = [UIFont systemFontOfSize:13];
        [_centerView addSubview:towNamelabeles];
    }
    
    _preiceNumberTexiField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, 150, 40)];
    _preiceNumberTexiField.tintColor = [UIColor grayColor];
    _preiceNumberTexiField.placeholder = @"请输入访问价格";
    _preiceNumberTexiField.font = [UIFont systemFontOfSize:13];
    _preiceNumberTexiField.keyboardType = UIKeyboardTypeNumberPad;
    [_centerView addSubview:_preiceNumberTexiField];
    
    _fangwentoushiTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 40, 150, 40)];
    _fangwentoushiTextField.tintColor = [UIColor grayColor];
    _fangwentoushiTextField.placeholder = @"请输入投食次数";
    _fangwentoushiTextField.font = [UIFont systemFontOfSize:13];
    _fangwentoushiTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_centerView addSubview:_fangwentoushiTextField];
    
    
    //确定按钮
    UIButton * leftSureButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 80, 137.5, 50)];
    [leftSureButton setTitle:@"确定" forState:UIControlStateNormal];
    [leftSureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftSureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_centerView addSubview:leftSureButton];
    [leftSureButton addTarget:self action:@selector(sureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //取消按钮
    UIButton * rightquxiaoButton = [[UIButton alloc]initWithFrame:CGRectMake(137.5, 80, 137.5, 50)];
    [rightquxiaoButton setTitle:@"取消" forState:UIControlStateNormal];
    [rightquxiaoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightquxiaoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_centerView addSubview:rightquxiaoButton];
    [rightquxiaoButton addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    

}

/**
 *  失效
 */


- (void)lostData
{
    NSString * str =@"clientAction.do?method=json&common=delPlayCode&classes=appinterface";
    NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
    [dic setValue:self.onFunyCode.text forKey:@"playcode"];
  [AFNetWorking postWithApi:str parameters:dic success:^(id json) {
      if ([[[json objectForKey:@"jsondata"]objectForKey:@"retCode"] isEqualToString:@"0000"]) {
          
          //成功
          [self.onFunCodeBtn setTitle:@"生成我的逗码" forState:UIControlStateNormal];
          self.onFunprice.text =@"暂无";
          self.onFunfood.text =@"暂无";
          self.onFuntime.text =@"暂无";
          self.onFunyCode.text =@"暂无";

          
          
      }

      
  } failure:^(NSError *error) {
      
  }];
    

    
}


- (void)buttonHidden
{
   
    [_preiceNumberTexiField resignFirstResponder];
    [_fangwentoushiTextField resignFirstResponder];
    _bigButton.hidden = YES;
    _centerView.hidden = YES;
   
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer

{
    [self.view endEditing:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
    //
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
