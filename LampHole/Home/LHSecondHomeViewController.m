//
//  LHSecondHomeViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/21.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHSecondHomeViewController.h"
#import "LHBlueToothManager.h"
#import "LHGroupModel.h"
#import "DDPMeLandscapeCollectionViewCell.h"

@interface LHSecondHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGr;

@property (nonatomic, strong) NSMutableArray *arrayGroup;

@end

@implementation LHSecondHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.arrayGroup = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= 16; i ++)
    {
        
        NSString *groupName = [NSString stringWithFormat:@"%d", i];
        LHGroupModel *model = [[LHGroupModel alloc] init];
        model.groupName = groupName;
        [self.arrayGroup addObject:model];
    }
}

- (void)initUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeZero;
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = YES;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [DDPMeLandscapeCollectionViewCell registerNibForCollectionView:self.collectionView];
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
//        UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        /**
         进入情景模式编辑页，编辑页包括修改情景模式名字，添加和删除设备
         */
        //......
        
    }
}

#pragma mark - ......::::::: UICollectionViewDataSource,UICollectionViewDelegate :::::::......
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayGroup.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHGroupModel *model = [self.arrayGroup objectAtIndex:indexPath.row];
    DDPMeLandscapeCollectionViewCell *cell = [DDPMeLandscapeCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.groupModel = model;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methos
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.width - 40;
    return CGSizeMake(width, 50);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

// 最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

#pragma mark - UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /**
     单击cell，一键设置所有
     */
    //.......
}

@end
