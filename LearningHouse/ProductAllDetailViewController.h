//
//  ProductAllDetailViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 7/27/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"

@interface ProductAllDetailViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property(strong,nonatomic) NSString*productId;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *productImage;

@property(strong,nonatomic) NSString*imageCode;
@property (strong, nonatomic) IBOutlet UILabel *autherLab;

@property (strong, nonatomic) IBOutlet UILabel *autherName;
@property (strong, nonatomic) IBOutlet UIWebView *showproductDetail;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *productCodeLab;
- (IBAction)incressWebViewSize:(id)sender;
- (IBAction)minusQuantity:(id)sender;
- (IBAction)plusQuantity:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *counterLab;
- (IBAction)addtoCart:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *img4;

@property (strong, nonatomic) IBOutlet UILabel *priceSale;
@property (strong, nonatomic) IBOutlet UIButton *img1;
@property (strong, nonatomic) IBOutlet UIButton *img2;
@property (strong, nonatomic) IBOutlet UIButton *img3;
- (IBAction)AvailabilityFirstBtn:(id)sender;
- (IBAction)AvailabilitySecondBtn:(id)sender;
- (IBAction)AvailabilityThirdBtn:(id)sender;
- (IBAction)AvailabilityFourthBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *qtyLab;
@property (strong, nonatomic) IBOutlet UIView *qtyView;

- (IBAction)buyNowBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *availabilityFirst;
@property (strong, nonatomic) IBOutlet UIButton *availabilitySecond;
@property (strong, nonatomic) IBOutlet UIButton *availabilitythird;
@property (strong, nonatomic) IBOutlet UIButton *availabilityFourth;

@end
