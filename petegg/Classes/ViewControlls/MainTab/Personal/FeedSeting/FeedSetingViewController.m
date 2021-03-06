//
//  FeedSetingViewController.m
//  petegg
//
//  Created by czx on 16/4/28.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "FeedSetingViewController.h"
#import "AFHttpClient+FeedingClient.h"
#import "FeedSetingTableViewCell.h"
#import "FeddingModel.h"

static NSString * cellId = @"fedseting2321232322313323231";
@interface FeedSetingViewController ()
@property (nonatomic,strong)UIButton * bigBtn;
@property (nonatomic,strong)UIButton * oneDayButton;
@property (nonatomic,strong)UIButton * twoDayButton;
@property (nonatomic,strong)UIView * moveView;
@property (nonatomic,assign)BOOL isOneOrTwo;

@property (nonatomic,strong)NSMutableArray * ondedayArray;
@property (nonatomic,strong)NSString * timeStr;


@property (nonatomic,strong)UIButton * bigBtn11;

@property (nonatomic,strong)UIButton * timeBtn1;
@property (nonatomic,strong)UIButton * timeBtn2;
@property (nonatomic,strong)UIButton * timeBtn3;
@property (nonatomic,strong)UIButton * timeBtn4;
@property (nonatomic,strong)UIButton * timeBtn5;
@property (nonatomic,strong)UIButton * timeBtn6;



@property (nonatomic,strong)UIDatePicker * datePicker;
@property (nonatomic,strong)UIView * bigView;
@property (nonatomic,strong)UIButton * bigButton;
@property (nonatomic,strong)UIButton * wanchengBtn;
@property (nonatomic,strong)NSString * panduanStr;

@property (nonatomic,strong)NSMutableArray * dataArray;


@property (nonatomic,strong)UIView * bigView1;
@property (nonatomic,strong)UIView * bigView2;

@property (nonatomic,strong)UIButton * sureBtn2;

@end


@implementation FeedSetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ondedayArray = [[NSMutableArray alloc]init];
    [self setNavTitle:@"喂食设置"];
    _dataArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [self querWeishi];
}

-(void)setupView{
    [super setupView];
    _bigBtn = [[UIButton alloc]initWithFrame:CGRectMake(87.5 * W_Wide_Zoom, 80 * W_Hight_Zoom , 200 * W_Wide_Zoom, 200 * W_Hight_Zoom)];
    //_bigBtn.backgroundColor = [UIColor blueColor];
    [_bigBtn setImage:[UIImage imageNamed:@"weishi_onday.png"] forState:UIControlStateNormal];
    _bigBtn.layer.cornerRadius = _bigBtn.width/2;
    [self.view addSubview:_bigBtn];
    
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 290 * W_Hight_Zoom, 375 * W_Wide_Zoom, 50 * W_Hight_Zoom)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    
    
    UILabel * wenziLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * W_Wide_Zoom, 15 * W_Hight_Zoom, 100 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    wenziLabel.text = @"喂食天数";
    wenziLabel.textColor = [UIColor blackColor];
    wenziLabel.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:wenziLabel];
    
    _oneDayButton = [[UIButton alloc]initWithFrame:CGRectMake(235 * W_Wide_Zoom, 16 * W_Hight_Zoom, 17 * W_Wide_Zoom, 17 * W_Hight_Zoom)];
    _oneDayButton.selected = YES;
    [_oneDayButton setImage:[UIImage imageNamed:@"quan_guize.png"] forState:UIControlStateNormal];
    [_oneDayButton setImage:[UIImage imageNamed:@"xuanquan_guize.png"] forState:UIControlStateSelected];
    [whiteView  addSubview:_oneDayButton];
      [_oneDayButton addTarget:self action:@selector(onedayButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * wenzi1 =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_oneDayButton.frame) + 5, 15 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    wenzi1.text = @"一天";
    wenzi1.textColor = GREEN_COLOR;
    wenzi1.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:wenzi1];
  

    
    _twoDayButton = [[UIButton alloc]initWithFrame:CGRectMake(310 * W_Wide_Zoom, 16 * W_Hight_Zoom, 17 * W_Wide_Zoom, 17 * W_Hight_Zoom)];
    [_twoDayButton setImage:[UIImage imageNamed:@"quan_guize.png"] forState:UIControlStateNormal];
    [_twoDayButton setImage:[UIImage imageNamed:@"xuanquan_guize.png"] forState:UIControlStateSelected];
    [whiteView addSubview:_twoDayButton];
    [_twoDayButton addTarget:self action:@selector(twoDayButtontouch) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel * wenzi2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_twoDayButton.frame) + 5, 15 * W_Hight_Zoom, 50 * W_Wide_Zoom, 20 * W_Hight_Zoom)];
    wenzi2.text = @"两天";
    wenzi2.textColor = GREEN_COLOR;
    wenzi2.font = [UIFont systemFontOfSize:13];
    [whiteView addSubview:wenzi2];
    
    
    
    
    
    
//    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(230 * W_Wide_Zoom, 300 * W_Hight_Zoom, 80 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
//    whiteView.backgroundColor = [UIColor whiteColor];
//    whiteView.layer.cornerRadius = 3;
//    [self.view addSubview:whiteView];
//    
//    _oneDayButton = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 40 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
//    [_oneDayButton setTitle:@"一天" forState:UIControlStateNormal];
//    _oneDayButton.backgroundColor = [UIColor whiteColor];
//    _oneDayButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    [_oneDayButton setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
//    [whiteView addSubview:_oneDayButton];
//    [_oneDayButton addTarget:self action:@selector(onedayButtonTouch) forControlEvents:UIControlEventTouchUpInside];
//    
//
//    
//    _twoDayButton = [[UIButton alloc]initWithFrame:CGRectMake(40 * W_Wide_Zoom, 0 * W_Hight_Zoom, 40 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
//    [_twoDayButton setTitle:@"两天" forState:UIControlStateNormal];
//    _twoDayButton.backgroundColor = [UIColor whiteColor];
//    _twoDayButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    [_twoDayButton setTitleColor:GREEN_COLOR forState:UIControlStateNormal];
//    [whiteView addSubview:_twoDayButton];
//    [_twoDayButton addTarget:self action:@selector(twoDayButtontouch) forControlEvents:UIControlEventTouchUpInside];
//    
//    _moveView = [[UIView alloc]initWithFrame:CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom)];
//    _moveView.backgroundColor = GREEN_COLOR;
//    [whiteView addSubview:_moveView];
    
    _isOneOrTwo = YES;

    
    UIButton * sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(221.25 * W_Wide_Zoom, 620 * W_Hight_Zoom, 120 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    sureBtn.backgroundColor = GREEN_COLOR;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    sureBtn.layer.cornerRadius = 5;
    [self.view addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(hahahahaha) forControlEvents:UIControlEventTouchUpInside];
    
    
    _sureBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(33.75 * W_Wide_Zoom, 620 * W_Hight_Zoom, 120 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    _sureBtn2.backgroundColor = GREEN_COLOR;
    [_sureBtn2 setTitle:@"停用" forState:UIControlStateNormal];
    [_sureBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    _sureBtn2.layer.cornerRadius = 5;
    [self.view addSubview:_sureBtn2];
    [_sureBtn2 addTarget:self action:@selector(stopWeishi) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)stopWeishi{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要停用自动喂食吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FeddingModel * model = self.dataSource[0];
        [self showHudInView:self.view hint:@"正在停用..."];
        [[AFHttpClient sharedAFHttpClient]cancelFeedingtimeWithbrid:model.brid complete:^(BaseModel *model) {
            [self hideHud];
            if (model) {
                [[AppUtil appTopViewController] showHint:model.retDesc];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
        }];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
     [self presentViewController:alert animated:YES completion:nil];
}
-(void)twoDayView{
    //dadaad
    [_bigView1 removeFromSuperview];
    _bigView2 = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 350 * W_Hight_Zoom, 375 * W_Wide_Zoom, 120 * W_Hight_Zoom)];
    _bigView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bigView2];

    _timeBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 15 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_timeBtn5 setTitle:@"00:00" forState:UIControlStateNormal];
    [_timeBtn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn5.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bigView2 addSubview:_timeBtn5];
    _timeBtn5.tag = 15;
    [_timeBtn5 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _timeBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 75 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_timeBtn6 setTitle:@"00:00" forState:UIControlStateNormal];
    [_timeBtn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn6.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bigView2 addSubview:_timeBtn6];
    _timeBtn6.tag = 16;
    [_timeBtn6 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];

    for (int i = 0 ; i < 2; i++) {
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 59 * W_Hight_Zoom + i * 60 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = LIGHT_GRAY_COLOR;
        [_bigView2 addSubview:lineLabel];
        

        
        UILabel * tLabel = [[UILabel alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 15 * W_Hight_Zoom + i*60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        tLabel.text = [NSString stringWithFormat:@"t%d",i+1];
        tLabel.textColor = [UIColor blackColor];
        tLabel.font = [UIFont systemFontOfSize:13];
        [_bigView2 addSubview:tLabel];
    }

}

-(void)onedayView{
    [_bigView2 removeFromSuperview];
    _bigView1 = [[UIView alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 350 * W_Hight_Zoom, 375 * W_Wide_Zoom, 240 * W_Hight_Zoom)];
    _bigView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bigView1];
    
    _bigBtn11 = [[UIButton alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 0 * W_Hight_Zoom, 375 * W_Wide_Zoom, 60 * W_Hight_Zoom)];
    _bigBtn11.userInteractionEnabled=NO;
    _bigBtn11.backgroundColor = [UIColor whiteColor];
    [_bigView1 addSubview:_bigBtn11];
    
    
    _timeBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 15 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_timeBtn1 setTitle:@"00:00" forState:UIControlStateNormal];
    [_timeBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bigView1 addSubview:_timeBtn1];
    _timeBtn1.tag = 11;
    [_timeBtn1 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _timeBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 75 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_timeBtn2 setTitle:@"00:00" forState:UIControlStateNormal];
    [_timeBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bigView1 addSubview:_timeBtn2];
    _timeBtn2.tag = 12;
    [_timeBtn2 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _timeBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 135 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_timeBtn3 setTitle:@"00:00" forState:UIControlStateNormal];
    [_timeBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bigView1 addSubview:_timeBtn3];
    _timeBtn3.tag = 13;
    [_timeBtn3 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    _timeBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(20 * W_Wide_Zoom, 195 * W_Hight_Zoom, 100 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
    [_timeBtn4 setTitle:@"00:00" forState:UIControlStateNormal];
    [_timeBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timeBtn4.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bigView1 addSubview:_timeBtn4];
    _timeBtn4.tag = 14;
    [_timeBtn4 addTarget:self action:@selector(hehedada:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0 ; i < 4; i++) {
        
        UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0 * W_Wide_Zoom, 59 * W_Hight_Zoom + i * 60 * W_Hight_Zoom, 375 * W_Wide_Zoom, 1 * W_Hight_Zoom)];
        lineLabel.backgroundColor = LIGHT_GRAY_COLOR;
        [_bigView1 addSubview:lineLabel];
        
        UILabel * tLabel = [[UILabel alloc]initWithFrame:CGRectMake(300 * W_Wide_Zoom, 15 * W_Hight_Zoom + i*60 * W_Hight_Zoom, 30 * W_Wide_Zoom, 30 * W_Hight_Zoom)];
        tLabel.text = [NSString stringWithFormat:@"t%d",i+1];
        tLabel.textColor = [UIColor blackColor];
        tLabel.font = [UIFont systemFontOfSize:13];
        [_bigView1 addSubview:tLabel];
    }
}
-(void)hehedada:(UIButton *)sender{
    if (sender.tag == 11) {
        _panduanStr = @"11";
    }else if (sender.tag == 12){
        _panduanStr = @"12";
    }else if (sender.tag == 13){
        _panduanStr = @"13";
    }else if (sender.tag == 14){
        _panduanStr = @"14";
    }else if (sender.tag == 15){
        _panduanStr = @"15";
    }else if (sender.tag == 16){
        _panduanStr = @"16";
    }
    
    [self brithdayButtontouch];
}



-(void)brithdayButtontouch{
    _bigButton = [[UIButton alloc]initWithFrame:self.view.bounds];
    _bigButton.backgroundColor = [UIColor blackColor];
    _bigButton.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_bigButton];
    [_bigButton addTarget:self action:@selector(bigButtonHidden) forControlEvents:UIControlEventTouchUpInside];
    _datePicker = [[ UIDatePicker alloc] initWithFrame:CGRectMake(0 * W_Wide_Zoom,200,self.view.frame.size.width,260 * W_Hight_Zoom)];
    _datePicker.datePickerMode = UIDatePickerModeTime;
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.alpha = 1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:_datePicker];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置   为中文显示
    _datePicker.locale = locale;
    
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    _wanchengBtn = [[UIButton alloc]initWithFrame:CGRectMake(0* W_Wide_Zoom, 427 * W_Hight_Zoom, 375 * W_Wide_Zoom, 35 * W_Hight_Zoom)];
    _wanchengBtn.backgroundColor = [UIColor whiteColor];
    [_wanchengBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_wanchengBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:_wanchengBtn];
    [_wanchengBtn addTarget:self action:@selector(wanchengButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)wanchengButtonTouch:(UIButton *)sender{
    
    NSDate *pickerDate = [_datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
  //  NSInteger i = (NSInteger)dateString;
    if ([_panduanStr isEqualToString:@"11"]) {
         [_timeBtn1 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"12"]){
    [_timeBtn2 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"13"]){
    [_timeBtn3 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"14"]){
        [_timeBtn4 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"15"]){
        [_timeBtn5 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"16"]){
        [_timeBtn6 setTitle:dateString forState:UIControlStateNormal];
    }
    sender.hidden = YES;
    _bigButton.hidden = YES;
    _datePicker.hidden = YES;
}




-(void)dateChanged:(id)sender{
    NSDate *pickerDate = [sender date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    if ([_panduanStr isEqualToString:@"11"]) {
        [_timeBtn1 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"12"]){
        [_timeBtn2 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"13"]){
        [_timeBtn3 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"14"]){
        [_timeBtn4 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"15"]){
        [_timeBtn5 setTitle:dateString forState:UIControlStateNormal];
    }else if ([_panduanStr isEqualToString:@"16"]){
        [_timeBtn6 setTitle:dateString forState:UIControlStateNormal];
    }
    //打印显示日期时间
    NSLog(@"格式化显示时间：%@",dateString);
}

-(void)bigButtonHidden{
    _wanchengBtn.hidden = YES;
    _bigButton.hidden = YES;
    _datePicker.hidden = YES;
    
}

-(void)onedayButtonTouch{
    _oneDayButton.selected = YES;
    _twoDayButton.selected = NO;
    _isOneOrTwo = YES;
    [_bigView2 removeFromSuperview];
    _bigView2.hidden = YES;
    _bigView1.hidden = NO;
    [self onedayView];
//    [UIView animateWithDuration:0.3 animations:^{
//        _moveView.frame = CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
//    [[AppUtil appTopViewController] showHint:@"启用一天模式"];
         [_bigBtn setImage:[UIImage imageNamed:@"weishi_onday.png"] forState:UIControlStateNormal];
//    }];
}

-(void)twoDayButtontouch{
    [_bigView1 removeFromSuperview];
    _bigView2.hidden = NO;
    _bigView1.hidden = YES;
    _oneDayButton.selected = NO;
    _twoDayButton.selected = YES;
     _isOneOrTwo = NO;
    [self twoDayView];
//    [UIView animateWithDuration:0.3 animations:^{
//        _moveView.frame = CGRectMake(42 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
//         [[AppUtil appTopViewController] showHint:@"启用两天模式"];
         [_bigBtn setImage:[UIImage imageNamed:@"weishi_twoday.png"] forState:UIControlStateNormal];
//    }];
//
}




-(void)hahahahaha{
    NSString * typeStr = @"";
    if (_isOneOrTwo == YES) {
        [_dataArray removeAllObjects];
        [_dataArray addObject:_timeBtn1.titleLabel.text];
        [_dataArray addObject:_timeBtn2.titleLabel.text];
        [_dataArray addObject:_timeBtn3.titleLabel.text];
        [_dataArray addObject:_timeBtn4.titleLabel.text];
        typeStr = @"one";
    }else{
        [_dataArray removeAllObjects];
        [_dataArray addObject:_timeBtn5.titleLabel.text];
        [_dataArray addObject:_timeBtn6.titleLabel.text];
        typeStr = @"two";
    }
   
    for (int i = 0 ; i < _dataArray.count - 1; i++) {
        for (int j = i + 1; j < _dataArray.count; j++) {
            if (_dataArray[i] == _dataArray[j]) {
               [[AppUtil appTopViewController] showHint:@"请不要选择相同的时间哦，亲!"];
                return;
            }
        }
    }
    [self showHudInView:self.view hint:@"正在设置..."];
    NSString * timeStr = [_dataArray componentsJoinedByString:@","];
    NSLog(@"%@",timeStr);
    NSString * termidStr = [AccountManager sharedAccountManager].loginModel.termid ;
    NSString * deviceno = [AccountManager sharedAccountManager].loginModel.deviceno;
    if ([AppUtil isBlankString:termidStr]) {
        NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
        deviceno = [defaults objectForKey:@"deviceNumber"];
        termidStr= [defaults objectForKey:@"termid"];
    }
    
    [[AFHttpClient sharedAFHttpClient]addFeedingtimeWithMid:[AccountManager sharedAccountManager].loginModel.mid type:typeStr times:timeStr deviceno:[AccountManager sharedAccountManager].loginModel.deviceno termid:[AccountManager sharedAccountManager].loginModel.termid complete:^(BaseModel *model) {
        [self hideHud];
        if (model) {
            [[AppUtil appTopViewController] showHint:model.retDesc];
            [self querWeishi];
        }
        
    }];
    NSLog(@"%@",_dataArray);
}

//查询
-(void)querWeishi{
    [_bigView2 removeFromSuperview];
    [_bigView1
     removeFromSuperview];
    [_timeBtn1 setTitle:@"" forState:UIControlStateNormal];
    [_timeBtn2 setTitle:@"" forState:UIControlStateNormal];
    [_timeBtn3 setTitle:@"" forState:UIControlStateNormal];
    [_timeBtn4 setTitle:@"" forState:UIControlStateNormal];
    [_timeBtn5 setTitle:@"" forState:UIControlStateNormal];
    [_timeBtn6 setTitle:@"" forState:UIControlStateNormal];
    [self.dataSource removeAllObjects];
    [[AFHttpClient sharedAFHttpClient]queryFeedingtimeWithMid:[AccountManager sharedAccountManager].loginModel.mid status:@"1" complete:^(BaseModel *model) {
        if (model.list.count > 0 ) {
            _sureBtn2.backgroundColor = GREEN_COLOR;
            _sureBtn2.userInteractionEnabled = YES;
            [self.dataSource addObjectsFromArray:model.list];
            FeddingModel * model = self.dataSource[0];
            NSArray * array = [model.times componentsSeparatedByString:NSLocalizedString(@",", nil)];
            if ([model.type isEqualToString:@"one"]) {
                _oneDayButton.selected = YES;
                _twoDayButton.selected = NO;
                _isOneOrTwo = YES;
                _moveView.frame = CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
                //[[AppUtil appTopViewController] showHint:@"启用一天模式"];
                _bigBtn.backgroundColor = [UIColor blueColor];
                [self onedayView];
                [_timeBtn1 setTitle:array[0] forState:UIControlStateNormal];
                [_timeBtn2 setTitle:array[1] forState:UIControlStateNormal];
                [_timeBtn3 setTitle:array[2] forState:UIControlStateNormal];
                [_timeBtn4 setTitle:array[3] forState:UIControlStateNormal];
            }else{
                _oneDayButton.selected = NO;
                _twoDayButton.selected = YES;
                _isOneOrTwo = NO;
                _moveView.frame = CGRectMake(42 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
               // [[AppUtil appTopViewController] showHint:@"启用两天模式"];
                _bigBtn.backgroundColor = [UIColor redColor];
                [self twoDayView];
                [_timeBtn5 setTitle:array[0] forState:UIControlStateNormal];
                [_timeBtn6 setTitle:array[1] forState:UIControlStateNormal];
            }

        }else{
            [self onedayView];
            //[self onedayButtonTouch];
            _sureBtn2.backgroundColor = [UIColor grayColor];
            _sureBtn2.userInteractionEnabled = NO;
            [_timeBtn1 setTitle:@"00:00" forState:UIControlStateNormal];
            [_timeBtn2 setTitle:@"00:00" forState:UIControlStateNormal];
            [_timeBtn3 setTitle:@"00:00" forState:UIControlStateNormal];
            [_timeBtn4 setTitle:@"00:00" forState:UIControlStateNormal];

            _oneDayButton.selected = YES;
            _twoDayButton.selected = NO;
            _isOneOrTwo = YES;
            _moveView.frame = CGRectMake(2 * W_Wide_Zoom, 2 * W_Hight_Zoom, 36 * W_Wide_Zoom, 26 * W_Hight_Zoom);
        }
    }];


}


-(void)setupData{
    [super setupData];

}




@end