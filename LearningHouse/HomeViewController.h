//
//  HomeViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 7/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "featuredProduct.h"
#import "topSellers.h"
#import "Latestproduct.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "ViewAllViewController.h"
#import "historyModel.h"
#import "AddToCartViewController.h"
#import "HomeSearchViewController.h"



@interface HomeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,WebServiceResponseProtocal>

@property (strong, nonatomic) IBOutlet UIButton *leftMenuBtn;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UICollectionView *featuredProductCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *topSellerCollectionView;
@property (strong, nonatomic) IBOutlet UIScrollView *landingScrollViwe;
@property (strong, nonatomic) IBOutlet UICollectionView *latestProductCollectionView;
@property (strong, nonatomic) IBOutlet UISlider *scroll1;
@property (strong, nonatomic) IBOutlet UILabel *cartItemLab;

- (IBAction)searchBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *firstSlider;
@property (strong, nonatomic) IBOutlet UISlider *secondSlider;
@property (strong, nonatomic) IBOutlet UISlider *thirdSlider;
@property(strong,nonatomic)NSString*menuString;
- (IBAction)featureProductAllDetail:(id)sender;
- (IBAction)topSellerProductAllDetail:(id)sender;

- (IBAction)latestProductAllDetail:(id)sender;
- (IBAction)ShowCartData:(id)sender;

@end
