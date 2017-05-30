//
//  CheckOutViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/18/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "OrderDetails.h"


@interface CheckOutViewController : UIViewController<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

- (IBAction)backBtn:(id)sender;

// billing
@property (strong, nonatomic) IBOutlet UIView *view1;
//@property (strong, nonatomic) IBOutlet UITextField *billingNameTxt;
@property (strong, nonatomic) IBOutlet UIScrollView *landingScrollView;
@property (strong, nonatomic) IBOutlet UITextField *billingName;
@property (strong, nonatomic) IBOutlet UITextField *billingState;
@property (strong, nonatomic) IBOutlet UITextField *billingAddress1;
@property (strong, nonatomic) IBOutlet UITextField *billingAddress2;
@property (strong, nonatomic) IBOutlet UITextField *billingCountry;
@property (strong, nonatomic) IBOutlet UITextField *billingZip;
@property (strong, nonatomic) IBOutlet UITextField *billincity;

//shipping
@property (strong, nonatomic) IBOutlet UIView *view2;
//@property (strong, nonatomic) IBOutlet UITextField *shippingNameTxt;
//@property (strong, nonatomic) IBOutlet UIScrollView *landingScrollView;
@property (strong, nonatomic) IBOutlet UITextField *shippingName;
@property (strong, nonatomic) IBOutlet UITextField *shippingState;
@property (strong, nonatomic) IBOutlet UITextField *shippingAddress1;
@property (strong, nonatomic) IBOutlet UITextField *shippingAddress2;
@property (strong, nonatomic) IBOutlet UITextField *shippingCountry;
@property (strong, nonatomic) IBOutlet UITextField *shippingZip;
@property (strong, nonatomic) IBOutlet UITextField *shippingcity;
//contect
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UILabel *contectLab;

@property (strong, nonatomic) IBOutlet UITextField *contectPhone;
@property (strong, nonatomic) IBOutlet UITextField *contectMe;
@property (strong, nonatomic) IBOutlet UITextField *contectEmail;
@property (strong, nonatomic) IBOutlet UITextField *contectComment;


- (IBAction)submitBtn:(id)sender;
- (IBAction)addressCopy:(id)sender;

//picker
@property (strong, nonatomic) IBOutlet UIButton *counteyBtn;
@property (strong, nonatomic) IBOutlet UIButton *stateBtn;
@property (strong, nonatomic) IBOutlet UIButton *shippingCountryButton;
@property (strong, nonatomic) IBOutlet UIButton *shippingStateButton;
- (IBAction)contectMe:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *contectBtn;

- (IBAction)statePickerBtn:(id)sender;
- (IBAction)countryPickerBtn:(id)sender;

- (IBAction)shippingPickerBtn:(id)sender;

- (IBAction)sippingCountryBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *checkImage;


@end
