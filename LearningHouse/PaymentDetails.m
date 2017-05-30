//
//  PaymentDetails.m
//  LearningHouse
//
//  Created by Alok Singh on 8/31/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PaymentDetails.h"
#define kPayPalEnvironment PayPalEnvironmentProduction
/*
 [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
 
 [PayPalPaymentViewController setEnvironment:PayPalEnvironmentSandbox];
 
 [PayPalPaymentViewController setEnvironment:PayPalEnvironmentProduction];
 */

@interface PaymentDetails ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dataDic;
    NSArray*info;
    UIPickerView*pickerView;
    UIView*timeBackgroundView;
    NSUInteger pickerRow;
    NSString*orderid;
    NSString* savedValue;
    NSString *CookieCartID;
    NSMutableArray*pickerArray;

}
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation PaymentDetails
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    pickerView.delegate=self;
    pickerView.dataSource=self;
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1;
    self.view1.layer.borderColor = [[UIColor blackColor] CGColor];
    self.purcheseOrderTxt.delegate=self;
    self.authorisedByTxt.delegate=self;
    scrollView.delegate=self;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 20)];
    self.purcheseOrderTxt.leftView = paddingView;
    self.purcheseOrderTxt.leftViewMode = UITextFieldViewModeAlways;
    

    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 20)];
    self.authorisedByTxt.leftView = paddingView1;
    self.authorisedByTxt.leftViewMode = UITextFieldViewModeAlways;
    
    savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }

    NSDictionary*dic=@{
                       @"name_customer":[historyModel sharedhistoryModel].name_customer,
                       @"address":[historyModel sharedhistoryModel].address,
                       @"address1":[historyModel sharedhistoryModel].address1,
                       @"postcode":[historyModel sharedhistoryModel].postcode,
                       @"Province":[historyModel sharedhistoryModel].Province,
                       @"city":[historyModel sharedhistoryModel].city,
                       @"Country":[historyModel sharedhistoryModel].Country,
                       @"shipping_name_customer":[historyModel sharedhistoryModel].shipping_name_customer,
                       @"shipping_address":[historyModel sharedhistoryModel].shipping_address,
                       @"shipping_address1":[historyModel sharedhistoryModel].shipping_address1,
                       @"shipping_postcode":[historyModel sharedhistoryModel].shipping_postcode,
                       @"shipping_Province":[historyModel sharedhistoryModel].shipping_Province,
                       @"shipping_city":[historyModel sharedhistoryModel].shipping_city,
                       @"shipping_Country":[historyModel sharedhistoryModel].shipping_Country,
                       @"customer_email":[historyModel sharedhistoryModel].customer_email,
                       @"mobile_no":[historyModel sharedhistoryModel].mobile_no,
                       @"contact_me":[historyModel sharedhistoryModel].contact_me,
                       @"comments":[historyModel sharedhistoryModel].comments,
                       @"CookieCart":CookieCartID,
                       @"id_customer":savedValue,
                       @"HSTTotal":[historyModel sharedhistoryModel].HSTTotal,
                       @"PSTTotal":[historyModel sharedhistoryModel].PSTTotal,
                       @"ShipTotal":[historyModel sharedhistoryModel].ShipTotal,
                       @"GSTTotal":[historyModel sharedhistoryModel].GSTTotal,
                       @"SubTotal":[historyModel sharedhistoryModel].SubTotal,
                       @"cartTotal":[historyModel sharedhistoryModel].cartTotal,
                       @"coupan_code":[historyModel sharedhistoryModel].coupan_code,
                       @"discApmount":[historyModel sharedhistoryModel].discApmount,
                       };
    
    
    [helper PaymentApi:dic];
    /*////////////////////////////////////////////
     PayPal Setup
    /////////////////////////////////////////// */
    
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;

//    #if HAS_CARDIO
//      // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
//      // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
//      // for more details.
//      _payPalConfig.acceptCreditCards = YES;
//    #else
//      _payPalConfig.acceptCreditCards = NO;
//    #endif
    _payPalConfig.merchantName = @"Learning House, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    
    
   // _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    _payPalConfig.languageOrLocale = [[[NSBundle mainBundle] preferredLocalizations] firstObject];

    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);

    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];

    return NO;
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSString*  result = [NSJSONSerialization JSONObjectWithData:responseDictionary options:kNilOptions error:nil];
    NSLog(@"Result = %@",result);
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"PaymentApi"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //[pickerView reloadAllComponents];
                 if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                 {
                     
                     orderid=[[info objectAtIndex:0] objectForKey:@"OrderID"];
                     
                                  }
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:1.0];
            });
        }
    }
    else if ([apiName isEqualToString:@"schoolData"])
    {
        info = [dataDic objectForKey:@"info"];
        pickerArray=[info mutableCopy];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                NSLog(@"info>>%@",info);
                [pickerView reloadAllComponents];
              
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:1.0];
            });
        }
    }
    else if ([apiName isEqualToString:@"orderApi"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    HomeViewController*HomeVC=[[HomeViewController alloc]init];
                    [self.navigationController pushViewController:HomeVC animated:NO];
                    [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:1.0];

                }
                else
                {
                [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:1.0];
                }
                
            });
        }
    }
    else if ([apiName isEqualToString:@"payPalConfirmation"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    HomeViewController*HomeVC=[[HomeViewController alloc]init];
                    [self.navigationController pushViewController:HomeVC animated:NO];
                    [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:1.0];
                    
                }
                else
                {
                    [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:1.0];
                }
                
            });
        }
    }
    
    else
    {
        NSString *msg = [dataDic objectForKey:@"msg"];
        [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:2.0];
    }
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}

//dic=@{@"order_id":self.orderid,@"id_customer":savedValue,@"area":@"vieworder",@"mode":@"",};
//[self orderDetail:dic];



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)pickerBtn:(id)sender {
    [self keyboardDismiss];

   NSDictionary*dic=@{};
    [helper schoolData:dic];
    [self CreatePicker];

    self.pickerBtn.userInteractionEnabled=NO;
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerArray objectAtIndex:row];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    pickerRow=row;
    NSLog(@"pickerRow....>%ld",(long)pickerRow);
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        //[tView setTextAlignment:UITextAlignmentLeft];
        tView.numberOfLines=0;
    }
    // Fill the label text here
    tView.text=[pickerArray objectAtIndex:row];
    return tView;
}

-(void)clickOnDoneButtonOnActionSheet1:(id)sender
{
//    if([self.schoolName.text isEqualToString:@"Schoolboard Name"])
//    {
//    self.schoolName.text=@"";
//    }
//    else
//    {
    self.schoolName.text= [NSString stringWithFormat:@"%@",[pickerArray objectAtIndex:pickerRow]];
    
   // }
    
   self.pickerBtn.userInteractionEnabled=YES;
    
    timeBackgroundView.hidden=YES;
}

-(void)clickOnCancelButtonOnActionSheet:(id)sender
{
    self.pickerBtn.userInteractionEnabled=YES;

    timeBackgroundView.hidden=YES;
    
}
-(void)CreatePicker
{
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(5,30, self.view.frame.size.width,200)];
    
    pickerView.hidden = NO;
    pickerView.delegate=self;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(clickOnCancelButtonOnActionSheet:)];
    
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *titleButton;
    //float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target: nil action: nil];
    
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionSheet1:)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,Window_Height-160, Window_Width, 170)];
    [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [timeBackgroundView addSubview:pickerToolbar];
    [timeBackgroundView addSubview:pickerView];
    [[AppDelegate appDelegate].window addSubview:timeBackgroundView];
    [pickerToolbar setItems:itemArray animated:YES];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    scrollView.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+10);
    [self setPayPalEnvironment:self.environment];

    
}
#pragma mark -
#pragma mark UITextFieldDelegate
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y - 1.5 * textField.frame.size.height);
    [scrollView setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, 0);
    [scrollView setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    timeBackgroundView.hidden=YES;
    self.pickerBtn.userInteractionEnabled=YES;
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

-(void)keyboardDismiss
{
    [self.purcheseOrderTxt resignFirstResponder];
    [self.authorisedByTxt resignFirstResponder];
    self.pickerBtn.userInteractionEnabled=YES;
  
    
}

- (IBAction)payByPurchaseBtn:(id)sender
{
    [SVProgressHUD show];
    
    if(self.purcheseOrderTxt.text==nil || [self.purcheseOrderTxt.text length]<=0)
    {
        [self.purcheseOrderTxt resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Purchase Order" timeDalay:1.0f];
    }
    else if(self.schoolName.text==nil || [self.schoolName.text length]<=0||[self.schoolName.text isEqualToString:@"Schoolboard Name"])
    {
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Select Schoolboard Name" timeDalay:1.0f];
    }
    else if(self.authorisedByTxt.text==nil || [self.authorisedByTxt.text length]<=0)
    {
        [self.authorisedByTxt resignFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Authorized By" timeDalay:1.0f];
    }
  
    else
    {
        if (!savedValue) {
            savedValue=@"";
        }
        if (!CookieCartID) {
            CookieCartID=@"";
        }
        
        NSDictionary*dic=@{
                           @"CookieCart":CookieCartID,
                           @"id_customer":savedValue,
                           @"purchase_order":self.purcheseOrderTxt.text,
                           @"school_name":self.schoolName.text,
                           @"purchase_authorized":self.authorisedByTxt.text,
                           @"OrderID":orderid,@"action":@"COD",};
        NSLog(@"dic>>>%@",dic);
        [helper orderApi:dic];
 
    
    }
}


// paypal
- (IBAction)PayByPayPalAction:(id)sender {


    [self pay];
}

- (BOOL)acceptCreditCards {
    return self.payPalConfig.acceptCreditCards;
}

- (void)setAcceptCreditCards:(BOOL)acceptCreditCards {
    self.payPalConfig.acceptCreditCards = acceptCreditCards;
}
- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}

#pragma mark - Receive Single Payment

- (void)pay {
    // Remove our last completed payment, just for demo purposes.
    self.resultText = nil;
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
    NSMutableArray *items=[NSMutableArray array];
    
    int i;
    
    for (i=0; i<[self.CartData count]; i++) {
        PayPalItem *item = [PayPalItem itemWithName:[[self.CartData objectAtIndex:i] valueForKey:@"Title"]
                                       withQuantity:[[[self.CartData objectAtIndex:i] valueForKey:@"ItemQty"] integerValue]
                                        //  withPrice:[NSDecimalNumber decimalNumberWithString:[[self.CartData objectAtIndex:i] valueForKey:@"CdnPrice"]]
                                          withPrice:[NSDecimalNumber decimalNumberWithString:@"1"]

                                       withCurrency:@"USD"
                                            withSku:[[self.CartData objectAtIndex:i] valueForKey:@"OrderNo"]];
        [items addObject:item];
    }
    
//    for (i=0; i<[self.CartData count]; i++) {
//        PayPalItem *item = [PayPalItem itemWithName:[[self.CartData objectAtIndex:i] valueForKey:@"Title"]
//                                       withQuantity:[[[self.CartData objectAtIndex:i] valueForKey:@"ItemQty"] integerValue]
//                                          withPrice:[NSDecimalNumber decimalNumberWithString:@"1"]
//                                       withCurrency:@"USD"
//                                            withSku:[[self.CartData objectAtIndex:i] valueForKey:@"OrderNo"]];
//        [items addObject:item];
//    }
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSLog(@"_CartDataTotalValue>>%@",_CartDataTotalValue);
    
    NSString *ShipValue;
    NSString *TaxValue;
    ShipValue=[[self.CartDataTotalValue objectAtIndex:0] valueForKey:@"shipTotal"];
    TaxValue=  [NSString stringWithFormat:@"%.2f",[[[self.CartDataTotalValue objectAtIndex:0] valueForKey:@"tax"] floatValue]];

//    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:ShipValue ];
//    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:TaxValue ];
    
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0.00" ];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0.00" ];

    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    NSLog(@"%@",total);
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = [NSString stringWithFormat:@"OrderId:%@",orderid];
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    
    
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }

    
    NSDictionary*dic=@{
                       @"CookieCart":CookieCartID,
                       @"id_customer":savedValue,
                       @"purchase_authorized":self.authorisedByTxt.text,
                       @"OrderID":orderid,@"action":@"paypal",};
    NSLog(@"dic>>>%@",dic);
    [helper payPalConfirmation:dic];
    
}
#pragma mark - Authorize Future Payments

- (IBAction)getUserAuthorizationForFuturePayments:(id)sender {
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalFuturePaymentDelegate methods

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
    NSLog(@"PayPal Future Payment Authorization Success!");
    self.resultText = [futurePaymentAuthorization description];
    [self showSuccess];
    
    [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
    // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}


#pragma mark - Authorize Profile Sharing

- (IBAction)getUserAuthorizationForProfileSharing:(id)sender {
    
    NSSet *scopeValues = [NSSet setWithArray:@[kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone]];
    
    PayPalProfileSharingViewController *profileSharingPaymentViewController = [[PayPalProfileSharingViewController alloc] initWithScopeValues:scopeValues configuration:self.payPalConfig delegate:self];
    [self presentViewController:profileSharingPaymentViewController animated:YES completion:nil];
}


#pragma mark PayPalProfileSharingDelegate methods

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = [profileSharingAuthorization description];
    [self showSuccess];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
}


#pragma mark - Helpers
- (void)showSuccess
{
    //  self.successView.hidden = NO;
    //  self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    // self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (IBAction)beanStreamAction:(id)sender
{
    [self pay];
    
}
@end
