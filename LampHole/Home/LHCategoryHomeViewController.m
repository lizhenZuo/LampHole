//
//  LHCategoryHomeViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHCategoryHomeViewController.h"
#import "LHCategoryModel.h"
#import "LHCategoryCollectionViewCell.h"
#import "LHCategorySingleDevViewController.h"
#import "SSLSettingView.h"
#import "SSLUserListView.h"

@interface LHCategoryHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGr;

@property (nonatomic, strong) NSMutableArray *arrayCategory; //所有的分类

@end

@implementation LHCategoryHomeViewController

-(BOOL)dd_isHiddenNaviBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DDNavigationBarView *navBarView = [self addCustomNavigationBar:@"灯具"];
    @weakify(self);
    [navBarView addBackSender:^{
        @strongify(self);
        [self showSettingView];
    }];
    [navBarView addTitleSender:^{
        @strongify(self);
        [self showUserListView];
    }];
    [navBarView addRightSender:^{

    }];
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.arrayCategory = [[NSMutableArray alloc] init];
    
    NSArray *arrayTitle = [NSArray arrayWithObjects:@"照明", @"遥控器", @"面板", @"感应器", @"插座", @"窗帘", nil];
    
    for (NSInteger i = 0; i < 6; i ++)
    {
        LHCategoryModel *model = [[LHCategoryModel alloc] init];
        model.categoryName = [arrayTitle objectAtIndex:i];
        model.nums = 10;
        [self.arrayCategory addObject:model];
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
    [LHCategoryCollectionViewCell registerNibForCollectionView:self.collectionView];
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

- (void)showSettingView
{
    SSLSettingView *settingView = [SSLSettingView shareSettingView];
    [settingView showSettingView:self.view];
}

- (void)showUserListView
{
    SSLUserListView *userListView = [SSLUserListView shareView];
    [userListView showUserListView:self.view];
}

#pragma mark - ......::::::: UICollectionViewDataSource,UICollectionViewDelegate :::::::......
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayCategory.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LHCategoryModel *model = [self.arrayCategory objectAtIndex:indexPath.row];
    LHCategoryCollectionViewCell *cell = [LHCategoryCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methos
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.view.width - 40;
    return CGSizeMake(width, 60);
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
    LHCategorySingleDevViewController *vc = [[LHCategorySingleDevViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
