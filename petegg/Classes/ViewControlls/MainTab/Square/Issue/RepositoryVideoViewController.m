//
//  RepositoryVideoViewController.m
//  petegg
//
//  Created by czx on 16/4/22.
//  Copyright © 2016年 sego. All rights reserved.
//
static NSString *headFootFlg = @"up";
static NSString *kfooterIdentifier = @"footerIdentifier111";
static NSString *kheaderIdentifier = @"headerIdentifier111";
#import "RepositoryVideoViewController.h"
#import "AFHttpClient+Issue.h"
#import "MyVideoCollectionViewCell.h"
#import "IssueZiYuankuModel.h"

@interface RepositoryVideoViewController ()

@end

@implementation RepositoryVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupView{
    [super setupView];
    [self showBarButton:NAV_RIGHT imageName:@"selecting.png"];
    self.collection.frame = CGRectMake(10, 65, SCREEN_WIDTH-20, SCREEN_HEIGHT-110);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.showsVerticalScrollIndicator   = NO;
    [self.collection registerClass:[MyVideoCollectionViewCell class] forCellWithReuseIdentifier:@"imageId"];
    [self.collection registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    [self.collection registerNib:[UINib nibWithNibName:@"HeaderViewCollection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    self.collection.backgroundColor =[UIColor whiteColor];
    [self initRefreshView:@"0"];
}

-(void)setupData{
    [super setupData];
  

}

- (void)data:(NSString *)stateNum
{
    [[AFHttpClient sharedAFHttpClient]getVideoWithMid:[AccountManager sharedAccountManager].loginModel.mid complete:^(BaseModel *model) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:model.list];
        [self handleEndRefresh];
        [self.collection reloadData];
    }];
    
}
#pragma Mark  --- collectionDelegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    IssueZiYuankuModel *model;
    if (self.dataSource.count>0) {
        model = self.dataSource[section];
    }
    NSArray *imageA = [model.thumbnails componentsSeparatedByString:@","];
    
    return imageA.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.dataSource.count;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(MainScreen.width/5+5, MainScreen.width/5+5);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IssueZiYuankuModel * model = self.dataSource[indexPath.section];
    MyVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageId" forIndexPath:indexPath];
    NSArray *imageA = [model.thumbnails componentsSeparatedByString:@","];
     NSString *urlstr = @"";
    if(![AppUtil isBlankString:imageA[indexPath.row]]){
        urlstr = imageA[indexPath.row];
    }
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:urlstr] placeholderImage:[UIImage imageNamed:@"sego.png"]];
   

    
    return cell;
}

//头部
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {350,20};
    return size;
}



//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={350,20};
    return size;
}
// heder和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
        
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UILabel *label = (UILabel *)[view viewWithTag:2222];
        view.backgroundColor =[UIColor whiteColor];
        
        IssueZiYuankuModel *model;
        if (self.dataSource.count>0) {
            model = self.dataSource[indexPath.section];
        }
        
        NSArray *timeTtile =[model.opttime componentsSeparatedByString:@","];
        label.text =timeTtile[indexPath.row];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UILabel *label = (UILabel *)[view viewWithTag:1111];
        view.backgroundColor =[UIColor whiteColor];
        label.backgroundColor =GRAY_COLOR;
        
        
    }
    return view;
    
}



@end