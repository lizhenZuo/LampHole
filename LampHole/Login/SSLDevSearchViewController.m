//
//  SSLDevSearchViewController.m
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import "SSLDevSearchViewController.h"
#import "DDPMeHorizontallyCollectionViewCell.h"
#import "SSLLoginViewController.h"

@interface SSLDevSearchViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UIView *viewSearching;
@property (nonatomic, weak) IBOutlet UIImageView *iconLoading;

@property (nonatomic, weak) IBOutlet UIView *viewSearchResult;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *lblDesc;

@property (nonatomic, strong) NSMutableArray<LHDeviceModel *> *arrayDev;

@end

@implementation SSLDevSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
}

#pragma mark - IBOutlet methods
- (IBAction)handleBtnAddDev:(id)sender
{
    SSLLoginViewController *vc = [[SSLLoginViewController alloc] init];
    vc.loginType = LOGIN_TYPE_AddDev;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)handleBtnSearchAgain:(id)sender
{
    
}

@end
