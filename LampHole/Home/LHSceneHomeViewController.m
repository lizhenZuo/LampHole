//
//  LHThirdHomeViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/21.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHSceneHomeViewController.h"
#import "DDPMeLandscapeCollectionViewCell.h"
#import "LHSceneModel.h"
#import "LHBlueToothManager.h"
#import "LHSceneEditViewController.h"

@interface LHSceneHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGr;

@property (nonatomic, strong) NSArray<LHSceneModel *> *arrayScene; //所有的情景模式，16种

@property (nonatomic,strong)DDPhotoSelectUtils *photoSelectUtils;

@end

@implementation LHSceneHomeViewController

#pragma mark - cycle methods
- (void)dealloc
{
    NSLog(@"LHThirdHomeViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initData];
}

- (void)initData
{
    
    self.arrayScene = [[LHSceneDBManager shareInstance] getCurSceneArray];
    [self.collectionView reloadData];
//    self.arrayScene = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 16; i ++)
//    {
//
//        NSString *sceneName = [NSString stringWithFormat:@"%c", 'A'+i];
//        LHSceneModel *model = [[LHSceneModel alloc] init];
//        model.sceneName = sceneName;
//        model.iconScene = @"";
//        [self.arrayScene addObject:model];
//    }
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
        LHSceneEditViewController *vc = [[LHSceneEditViewController alloc] init];
        LHSceneModel *model = [self.arrayScene objectAtIndex:indexPath.row];
        vc.curSceneModel = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - ......::::::: UICollectionViewDataSource,UICollectionViewDelegate :::::::......
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayScene.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHSceneModel *model = [self.arrayScene objectAtIndex:indexPath.row];
    DDPMeLandscapeCollectionViewCell *cell = [DDPMeLandscapeCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methos
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.width/2 - 15;
    return CGSizeMake(width, 50);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 10, 0, 10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

// 最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma mark - UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    /**
     单击cell，一键设置所有
     */
    //.......
}

@end
