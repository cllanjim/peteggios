//
//  MyVideoCollectionViewCell.m
//  petegg
//
//  Created by yulei on 16/4/6.
//  Copyright © 2016年 sego. All rights reserved.
//

#import "MyVideoCollectionViewCell.h"

@implementation MyVideoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.imageV];
        
        self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(-10, -30, 100, 40)];
        self.timeLable.textAlignment = NSTextAlignmentCenter;
        self.timeLable.textColor =[UIColor grayColor];
        self.timeLable.font =[UIFont systemFontOfSize:16];
        [self addSubview:self.timeLable];
        
        self.startImageV = [[UIImageView alloc]initWithFrame:CGRectMake((self.bounds.size.width-30)/2, (self.bounds.size.height-30)/2, 30, 30)];
        self.startImageV.image = [UIImage imageNamed:@"MV.png"];
        self.startImageV.hidden = YES;
        [self addSubview:self.startImageV];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"gou-xuan.png"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"yi_xuan.png"] forState:UIControlStateSelected];
        
        _rightBtn.frame = CGRectMake(self.bounds.size.width-22, self.bounds.size.height-22, 20, 20);
        _rightBtn.userInteractionEnabled = YES;
        _rightBtn.hidden = YES;
        [self addSubview:_rightBtn];
        
        
    }
    
    return self;
}
@end
