//
//  LHFirstHomeViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/21.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHCategorySingleDevViewController.h"
#import "DDPMeHorizontallyCollectionViewCell.h"
#import "LHBlueToothManager.h"

#import "LHDevSingleColorSetViewController.h"
#import "LHDevDoubleColorSetViewController.h"
#import "LHDevRGBWSetViewController.h"
#import "LHDevRGBCWSetViewController.h"

@interface LHCategorySingleDevViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGr;

@property (nonatomic, strong) NSMutableArray<LHDeviceModel *> *arrayDev;

@end

@implementation LHCategorySingleDevViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

// 初始化数据
- (void)initData
{
    self.arrayDev = [[NSMutableArray alloc] init];
    
    LHDeviceModel *model;
    
    for (NSInteger i = 1; i < 20; i ++)
    {
        model = [[LHDeviceModel alloc] init];
        model.device_id = [NSString stringWithFormat:@"TestID%@", @(i)];
        model.device_name = [NSString stringWithFormat:@"TestName%@", @(i)];
        [self.arrayDev addObject:model];
    }
}

// 初始化UI
- (void)initUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeZero;
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [DDPMeHorizontallyCollectionViewCell registerNibForCollectionView:self.collectionView];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeaderID"];
    
    //长按手势
    self.longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    self.longPressGr.minimumPressDuration = 1.0;
    self.longPressGr.delegate = self;
    self.longPressGr.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:self.longPressGr];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];

    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        LHDeviceModel *model = [self.arrayDev objectAtIndex:indexPath.row];
        [self handleEditDev:model];
    }
}

- (void)handleEditDev:(LHDeviceModel *)model
{
    if (model.lightType == DEV_LIGHT_TYPE_SINGLE_COLOR)
    {
        LHDevSingleColorSetViewController *vc = [[LHDevSingleColorSetViewController alloc] init];
        vc.devModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (model.lightType == DEV_LIGHT_TYPE_DOUBLE_COLOR)
    {
        LHDevDoubleColorSetViewController *vc = [[LHDevDoubleColorSetViewController alloc] init];
        vc.devModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (model.lightType == DEV_LIGHT_TYPE_RGBW)
    {
        LHDevRGBWSetViewController *vc = [[LHDevRGBWSetViewController alloc] init];
        vc.devModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (model.lightType == DEV_LIGHT_TYPE_RGBCW)
    {
        LHDevRGBCWSetViewController *vc = [[LHDevRGBCWSetViewController alloc] init];
        vc.devModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - ......::::::: UICollectionViewDataSource,UICollectionViewDelegate :::::::......
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayDev.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHDeviceModel *model = [self.arrayDev objectAtIndex:indexPath.row];
    DDPMeHorizontallyCollectionViewCell *cell = [DDPMeHorizontallyCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methos
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70, 70);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(22, 23.5, 20, 23.5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

// 最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark - UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //开或者关，发送蓝牙协议
    
}

@end
