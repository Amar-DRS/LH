//
//  EditBillingAddress.h
//  LearningHouse
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "NIDropDown.h"



@interface EditBillingAddress : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleBillingLab;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UILabel *shippingTitleLab;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScrollView;
@property (weak, nonatomic) IBOutlet UIView *view2;

// for billing
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *organizationtext;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *alternatePhoneText;
@property (weak, nonatomic) IBOutlet UITextField *adress1Text;


@property (weak, nonatomic) IBOutlet UITextField *adress2Txt;


@property (weak, nonatomic) IBOutlet UITextField *cityTxt;

@property (weak, nonatomic) IBOutlet UITextField *provinenceTxt;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeTxt;
@property (weak, nonatomic) IBOutlet UITextField *countryTxt;

// for shipping

@property (weak, nonatomic) IBOutlet UITextField *usernameShipping;
@property (weak, nonatomic) IBOutlet UITextField *organizationTxt1;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxtShipping;
@property (weak, nonatomic) IBOutlet UITextField *alternatePhoneShipping;
@property (weak, nonatomic) IBOutlet UITextField *adress1Shipping;


@property (weak, nonatomic) IBOutlet UITextField *adress2Shipping;


@property (weak, nonatomic) IBOutlet UITextField *cityTxtShipping;

@property (weak, nonatomic) IBOutlet UITextField *provinenceShipping;
@property (weak, nonatomic) IBOutlet UITextField *postalCodeShipping;
@property (weak, nonatomic) IBOutlet UITextField *countryShipping;
@property (weak, nonatomic) IBOutlet UIButton *billingSaveBtn;
@property (retain, nonatomic) IBOutlet UIButton *billingcountry;
@property (weak, nonatomic) IBOutlet UIButton *billingState;
@property (weak, nonatomic) IBOutlet UIButton *shippingCuntrybtn;
@property (weak, nonatomic) IBOutlet UIButton *shippingStatebtn;
@property(strong,nonatomic)NSString*backtoController;
@property(strong,nonatomic)NSString*address;


- (IBAction)billingSaveBtn:(id)sender;
- (IBAction)shippinSaveBtn:(id)sender;
- (IBAction)billingcountry:(id)sender;
- (IBAction)billingState:(id)sender;
- (IBAction)shippingCuntrybtn:(id)sender;
- (IBAction)shippingStatebtn:(id)sender;

//- (IBAction)shippingSaveBtn:(id)sender;

@end
