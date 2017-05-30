//
//  PaymentDetails.h
//  LearningHouse
//
//  Created by Alok Singh on 8/31/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "ZZMainViewController.h"
#import "PayPalMobile.h"



@interface PaymentDetails : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UITextField *purcheseOrderTxt;
@property (strong, nonatomic) IBOutlet UITextField *authorisedByTxt;
- (IBAction)pickerBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pickerBtn;
@property (strong, nonatomic) IBOutlet UILabel *schoolName;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)payByPurchaseBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PayByCreditCardAction;
// paypal usage property
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;
@property(nonatomic, strong, readwrite) NSArray *CartData;
@property(nonatomic, strong, readwrite) NSArray *CartDataTotalValue;

- (IBAction)PayByPayPalAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *beanStreamAction;
- (IBAction)beanStreamAction:(id)sender;


@end
