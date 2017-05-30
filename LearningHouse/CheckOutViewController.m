//
//  CheckOutViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/18/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "CheckOutViewController.h"


@interface CheckOutViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    NSString*savedValue;
    UIPickerView*pickerView;
    UIView*timeBackgroundView;
    NSString*pickercheck;
    NSArray * stateArray;
    NSArray * countryArray;
    NSUInteger pickerRow;
    NSArray*contactArray;
    NSInteger tag;
    NSDictionary*AddressData;
    BOOL addressBtnCheck;
    CGSize content;
    CGPoint point;
}

@end

@implementation CheckOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    addressBtnCheck=YES;
    self.billingState.userInteractionEnabled=NO;
    self.billingCountry.userInteractionEnabled=NO;
    self.shippingState.userInteractionEnabled=NO;
    self.billingCountry.userInteractionEnabled=NO;
    self.contectMe.userInteractionEnabled=NO;
    
    self.contectLab.text=@"In order to complete your order one of our representatives may need to contact you to verify your information. Please ensure that the contact information you supply is accurate. If you are ordering from a country other than Canada shipping rates will be based on actual shipping costs. We appreciate your business and count it a privilege to serve you in this way.";
    NSString*str=@"Please provide your billing and shipping information.fields in * are required.";
    self.stateBtn.tag=101;
    self.counteyBtn.tag=102;
    self.shippingStateButton.tag=103;
    self.shippingCountryButton.tag=104;
    
    [self.checkImage setImage:[UIImage imageNamed:@"unchecked"]];
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1;
    self.view1.layer.borderColor = [[UIColor blackColor] CGColor];
    self.view2.layer.masksToBounds = YES;
    self.view2.layer.borderWidth = 1;
    self.view2.layer.borderColor = [[UIColor blackColor] CGColor];
    self.view3.layer.masksToBounds = YES;
    self.view3.layer.borderWidth = 1;
    self.view3.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.landingScrollView.delegate=self;
    // [self.landingScrollView setContentSize:CGSizeMake(320,self.landingScrollView.frame.size.height)];
    
    //delegare
    self.billingName.delegate=self;
    self.billingState.delegate=self;
    self.billingCountry.delegate=self;
    self.billincity.delegate=self;
    self.billingZip.delegate=self;
    self.billingAddress1.delegate=self;
    self.billingAddress2.delegate=self;
    self.shippingName.delegate=self;
    self.shippingCountry.delegate=self;
    self.shippingZip.delegate=self;
    self.shippingAddress1.delegate=self;
    self.shippingAddress2.delegate=self;
    self.shippingState.delegate=self;
    self.shippingcity.delegate=self;
    self.contectComment.delegate=self;
    self.contectEmail.delegate=self;
    self.contectMe.delegate=self;
    self.contectPhone.delegate=self;
    
    // padding
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billingName.leftView = paddingView;
    self.billingName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billingState.leftView = paddingView1;
    self.billingState.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billingCountry.leftView = paddingView2;
    self.billingCountry.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billincity.leftView = paddingView3;
    self.billincity.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billingZip.leftView = paddingView4;
    self.billingZip.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billingAddress1.leftView = paddingView5;
    self.billingAddress1.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.billingAddress2.leftView = paddingView6;
    self.billingAddress2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingName.leftView = paddingView7;
    self.shippingName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingCountry.leftView = paddingView8;
    self.shippingCountry.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingZip.leftView = paddingView9;
    self.shippingZip.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingAddress1.leftView = paddingView10;
    self.shippingAddress1.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingAddress2.leftView = paddingView11;
    self.shippingAddress2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingcity.leftView = paddingView12;
    self.shippingcity.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.shippingState.leftView = paddingView13;
    self.shippingState.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.contectComment.leftView = paddingView14;
    self.contectComment.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView15 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.contectEmail.leftView = paddingView15;
    self.contectEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView16 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    self.contectMe.leftView = paddingView16;
    self.contectMe.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView17 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5, 20)];
    self.contectPhone.leftView = paddingView17;
    self.contectPhone.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    self.titleLab.text=[NSString stringWithFormat:@" %@",str];
    
    pickerView.delegate=self;
    pickerView.dataSource=self;
    
    //stateArray = [[NSArray alloc] init];
    stateArray = [NSArray arrayWithObjects:@"Province/State",@"Alberta", @"British Columbia", @"Manitoba", @"Newfoundland", @"Nova Scotia", @"Northwest Territories", @"Nunavit", @"Ontario", @"Prince Edward Island",@"Quebec",@"Saskatchewan",@"Yukon",@"Alaska",@"Alabama",@"Arkansas",@"Arizona",@"California",@"Colorado",@"Connecticut",@"District of Columbia",@"Delaware",@"Florida",@"Georgia",@"Hawaii",@"Iowa",@"Idaho",@"Illinois",@"Indiana",@"Kansas",@"Kentucky",@"Louisiana",@"Massachusetts",@"Maryland",@"Maine",@"Michigan",@"Minnesota",@"Missouri",@"Mississippi",@"Montana",@"North Carolina",@"North Dakota",@"Nebraska",@"New Hampshire",@"New Jersey",@"New Mexico",@"Nevada",@"New York",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Puerto Rico",@"Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Virginia",@"Virgin Islands",@"Vermont",@"Washington",@"Wisconsin",@"West Virginia",@"Wyoming",nil];
    // countryArray = [[NSArray alloc] init];
    countryArray = [NSArray arrayWithObjects:@"Country",@"Canada", @"USA",nil];
    //
    contactArray = [[NSArray alloc] init];
    contactArray=[NSArray arrayWithObjects:@"Contact me*",@"Anytime",@"Morning",@"Afternoon",@"Evening",nil];
    
    savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    if (!savedValue) {
        savedValue=@"";
    }
    
    
    dic=@{@"id_customer":savedValue,@"area":@"account",@"mode":@"",};
    [helper myAccount:dic];
    
    
}
-(void)checkOut:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper checkOutData:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAccount"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary*info2=[info objectAtIndex:0];
                AddressData=[MyCustomClass getValuesWithOutNull:info2];
                
                [historyModel sharedhistoryModel].orderDetailDictionary=AddressData;
                self.billingName.text=[AddressData objectForKey:@"name_customer"];
                self.billingState.text=[AddressData objectForKey:@"Province"];
                self.billingCountry.text=[AddressData objectForKey:@"Country"];
                self.billingAddress1.text=[AddressData objectForKey:@"address"];
                self.billingAddress2.text=[AddressData objectForKey:@"address1"];
                self.billingZip.text=[AddressData objectForKey:@"postcode"];
                self.billincity.text=[AddressData objectForKey:@"city"];
                
                //shipping
                self.shippingName.text=[AddressData objectForKey:@"shipping_name_customer"];
                self.shippingState.text=[AddressData objectForKey:@"shipping_Province"];
                self.shippingcity.text=[AddressData objectForKey:@"shipping_city"];
                self.shippingAddress1.text=[AddressData objectForKey:@"shipping_address"];
                self.shippingAddress2.text=[AddressData objectForKey:@"shipping_address1"];
                self.shippingZip.text=[AddressData objectForKey:@"shipping_postcode"];
                self.shippingCountry.text=[AddressData objectForKey:@"shipping_Country"];
                
                //contect
                
                self.contectPhone.text=[AddressData objectForKey:@"mobile_no"];
                self.contectMe.text=[AddressData objectForKey:@"shipping_address1"];
                self.contectEmail.text=[AddressData objectForKey:@"customer_email"];
                // self.contectComment.text=[[info objectAtIndex:0]objectForKey:@"shipping_Country"];
                
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:1.0];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CreatePicker
{
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 100)];
    
    pickerView.hidden = NO;
    pickerView.delegate=self;
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
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
- (IBAction)submitBtn:(id)sender {
    [SVProgressHUD show];
    
    if(self.billingName.text==nil || [self.billingName.text length]<=0)
    {
        [self.billingName becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter BillingName" timeDalay:1.0f];
    }
    else if([self.billingState.text isEqualToString:@"Province/State"]||self.billingState.text==nil || [self.billingState.text length]<=0)
        
    {
        [self.billingState becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Billingprovince" timeDalay:1.0f];
    }
    else if(self.billingAddress1.text==nil || [self.billingAddress1.text length]<=0)
    {
        [self.billingAddress1 becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter BillingAddress" timeDalay:1.0f];
    }
    else if([self.billingCountry.text isEqualToString:@"Country"]||self.billingCountry.text==nil || [self.billingCountry.text length]<=0)
    {
        [self.billingCountry becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter BillingCountry" timeDalay:1.0f];
    }
    else if(self.billingZip.text==nil || [self.billingZip.text length]<=0)
    {
        [self.billingZip becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter BillingZip" timeDalay:1.0f];
    }
    else if(self.billincity.text==nil || [self.billincity.text length]<=0)
    {
        [self.billincity becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Billincity" timeDalay:1.0f];
    }
    else if(self.shippingName.text==nil || [self.shippingName.text length]<=0)
    {
        [self.shippingName becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter shippingName" timeDalay:1.0f];
    }
    else if([self.shippingState.text isEqualToString:@"Province/State"]||self.shippingState.text==nil || [self.shippingState.text length]<=0)
    {
        [self.shippingState becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Shippingprovince" timeDalay:1.0f];
    }
    else if(self.shippingZip.text==nil || [self.shippingZip.text length]<=0)
    {
        [self.shippingZip becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter shippingZip" timeDalay:1.0f];
    }
    else if(self.shippingcity.text==nil || [self.shippingcity.text length]<=0)
    {
        [self.shippingcity becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter shippingcity" timeDalay:1.0f];
    }
    else if([self.shippingCountry.text isEqualToString:@"Country"]||self.shippingCountry.text==nil || [self.shippingCountry.text length]<=0)
    {
        [self.shippingCountry becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter shippingCountry" timeDalay:1.0f];
    }
    else if(self.shippingAddress1.text==nil || [self.shippingAddress1.text length]<=0)
    {
        [self.shippingAddress1 becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter shippingAddress" timeDalay:1.0f];
    }
    else if(self.contectPhone.text==nil || [self.contectPhone.text length]<=0)
    {
        [self.contectPhone becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Phone number" timeDalay:1.0f];
    }
    else if([self.contectMe.text isEqualToString:@"Contact me*"]||self.contectMe.text==nil || [self.contectMe.text length]<=0)
    {
        [self.contectMe becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter contactMe" timeDalay:1.0f];
    }
    else if(self.contectEmail.text==nil || [self.contectEmail.text length]<=0)
    {
        [self.contectEmail becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter contectEmail" timeDalay:1.0f];
    }
   // else if(!(self.contectEmail.text==nil || [self.contectEmail.text length]<=0))
//    {
//        [MyCustomClass validateEmail:self.contectEmail.text];
//
//        if(true)
//        {
//       [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:1.0f];
//        }
//        else
//        {
//        [MyCustomClass SVProgressMessageDismissWithError:@"Enter contectEmail" timeDalay:1.0f];
//        }
//    }
    
    else
    {
        
        OrderDetails*OrderDetailsVC=[[OrderDetails alloc]init];
        [self.navigationController pushViewController:OrderDetailsVC animated:NO];
        OrderDetailsVC.contectStr=self.contectMe.text;//[contactArray objectAtIndex:pickerRow];
        [self saveDataOnModelClass];
        
    }
}

- (IBAction)addressCopy:(id)sender {
    
    if (addressBtnCheck==YES)
    {
        //    self.shippingName.text=[AddressData objectForKey:@"name_customer"];
        //    self.shippingState.text=[AddressData objectForKey:@"Province"];
        //    self.shippingcity.text=[AddressData objectForKey:@"city"];
        //    self.shippingAddress1.text=[AddressData objectForKey:@"address"];
        //    self.shippingAddress2.text=[AddressData objectForKey:@"address1"];
        //    self.shippingZip.text=[AddressData objectForKey:@"postcode"];
        //    self.shippingCountry.text=[AddressData objectForKey:@"Country"];
        //        [self.checkImage setImage:[UIImage imageNamed:@"checked"]];
        
        self.shippingName.text=self.billingName.text;
        self.shippingState.text=self.billingState.text;
        self.shippingcity.text=self.billincity.text;
        self.shippingAddress1.text=self.billingAddress1.text;
        self.shippingAddress2.text=self.billingAddress2.text;
        self.shippingZip.text=self.billingZip.text;
        self.shippingCountry.text=self.billingCountry.text;
        [self.checkImage setImage:[UIImage imageNamed:@"checked"]];
        
        
        [historyModel sharedhistoryModel].shipping_name_customer=self.shippingName.text;
        [historyModel sharedhistoryModel].shipping_address=self.shippingAddress1.text;
        [historyModel sharedhistoryModel].shipping_address1=self.shippingAddress2.text;
        [historyModel sharedhistoryModel].shipping_postcode=self.shippingZip.text;
        [historyModel sharedhistoryModel].shipping_Province=self.shippingState.text;
        [historyModel sharedhistoryModel].shipping_city=self.shippingcity.text;
        [historyModel sharedhistoryModel].shipping_Country=self.shippingCountry.text;
        
        
        addressBtnCheck=NO;
        
    }
    else
    {
        
        self.shippingName.text=[AddressData objectForKey:@"shipping_name_customer"];
        self.shippingState.text=[AddressData objectForKey:@"shipping_Province"];
        self.shippingcity.text=[AddressData objectForKey:@"shipping_city"];
        self.shippingAddress1.text=[AddressData objectForKey:@"shipping_address"];
        self.shippingAddress2.text=[AddressData objectForKey:@"shipping_address1"];
        self.shippingZip.text=[AddressData objectForKey:@"shipping_postcode"];
        self.shippingCountry.text=[AddressData objectForKey:@"shipping_Country"];
        [self.checkImage setImage:[UIImage imageNamed:@"unchecked"]];
        
        [historyModel sharedhistoryModel].shipping_name_customer=self.shippingName.text;
        [historyModel sharedhistoryModel].shipping_address=self.shippingAddress1.text;
        [historyModel sharedhistoryModel].shipping_address1=self.shippingAddress2.text;
        [historyModel sharedhistoryModel].shipping_postcode=self.shippingZip.text;
        [historyModel sharedhistoryModel].shipping_Province=self.shippingState.text;
        [historyModel sharedhistoryModel].shipping_city=self.shippingcity.text;
        [historyModel sharedhistoryModel].shipping_Country=self.shippingCountry.text;
        
        addressBtnCheck=YES;
        
    }
    
    
}

- (IBAction)contectMe:(id)sender
{
    [self keyboardReturn];

    UITextField *textField = (UITextField *)sender;
    [textField resignFirstResponder];
    pickercheck=@"contect";
    
    [self CreatePicker];
    self.contectBtn.userInteractionEnabled=NO;
    
}

- (IBAction)statePickerBtn:(id)sender {
    [self keyboardReturn];
    //UITextField *textField = (UITextField *)sender;
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    pickercheck=@"state";
    self.stateBtn.userInteractionEnabled=NO;
    
    
    [self CreatePicker];
}
- (IBAction)countryPickerBtn:(id)sender {
    [self keyboardReturn];
    
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    pickercheck=@"country";
    self.counteyBtn.userInteractionEnabled=NO;
    [self CreatePicker];
}

- (IBAction)shippingPickerBtn:(id)sender {
    [self keyboardReturn];
    
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    
    pickercheck=@"state";
    self.shippingStateButton.userInteractionEnabled=NO;
    
    
    [self CreatePicker];
    
}

- (IBAction)sippingCountryBtn:(id)sender {
    [self keyboardReturn];
    
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    
    pickercheck=@"country";
    self.shippingCountryButton.userInteractionEnabled=NO;
    
    
    [self CreatePicker];
}



- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if ([pickercheck isEqualToString:@"country"])
        return [countryArray count];
    else if ([pickercheck isEqualToString:@"state"])
        return [stateArray count];
    else
        return contactArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([pickercheck isEqualToString:@"country"])
        return [countryArray objectAtIndex:row];
    else if ([pickercheck isEqualToString:@"state"])
        return [stateArray objectAtIndex:row];
    else
        return [contactArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    pickerRow=row;
    NSLog(@"pickerRow....>%ld",(long)pickerRow);
}

-(void)clickOnDoneButtonOnActionSheet1:(id)sender
{
    if ([pickercheck isEqualToString:@"country"])
    {
        if (tag==102)
        {
            self.billingCountry.text= [countryArray objectAtIndex:pickerRow];
            self.counteyBtn.userInteractionEnabled=YES;
            
        }
        else if (tag==104)
        {
            self.shippingCountry.text= [countryArray objectAtIndex:pickerRow];
            
            self.shippingCountryButton.userInteractionEnabled=YES;
            
        }
    }
    else if ([pickercheck isEqualToString:@"state"])
    {
        
        if (tag==101)
        {
            self.billingState.text= [stateArray objectAtIndex:pickerRow];
            self.stateBtn.userInteractionEnabled=YES;
            
            
        }
        else if (tag==103)
        {
            self.shippingState.text= [stateArray objectAtIndex:pickerRow];
            
            
            self.shippingStateButton.userInteractionEnabled=YES;
            
        }
        
    }
    else
    {
        self.contectMe.text= [contactArray objectAtIndex:pickerRow];
        
        self.contectBtn.userInteractionEnabled=YES;
        
    }
    
    
    timeBackgroundView.hidden=YES;
}

-(void)clickOnCancelButtonOnActionSheet:(id)sender
{
    if ([pickercheck isEqualToString:@"country"])
    {
        if (tag==102)
        {
            self.counteyBtn.userInteractionEnabled=YES;
            
        }
        else if (tag==104)
        {
            
            self.shippingCountryButton.userInteractionEnabled=YES;
            
        }
    }
    else if ([pickercheck isEqualToString:@"state"])
    {
        
        if (tag==101)
        {
            self.stateBtn.userInteractionEnabled=YES;
            
        }
        else if (tag==103)
        {
            self.shippingStateButton.userInteractionEnabled=YES;
            
        }
        
    }
    else
    {
        
        self.contectBtn.userInteractionEnabled=YES;
        
    }
    
    
    timeBackgroundView.hidden=YES;
    
}



-(void)keyboardReturn
{
    [self.billingName resignFirstResponder];
    [self.billingState resignFirstResponder];
    [self.billingCountry resignFirstResponder];
    [self.billingAddress1 resignFirstResponder];
    [self.billingAddress2 resignFirstResponder];
    [self.billingZip resignFirstResponder];
    [self.billincity resignFirstResponder];
    
    
    [self.shippingName resignFirstResponder];
    [self.shippingState resignFirstResponder];
    [self.shippingcity resignFirstResponder];
    [self.shippingAddress1 resignFirstResponder];
    [self.shippingAddress2 resignFirstResponder];
    [self.shippingZip resignFirstResponder];
    [self.shippingCountry resignFirstResponder];
    [self.contectMe resignFirstResponder];
    [self.contectPhone resignFirstResponder];
    [self.contectEmail resignFirstResponder];
    self.counteyBtn.userInteractionEnabled=YES;
    self.shippingCountryButton.userInteractionEnabled=YES;
    self.stateBtn.userInteractionEnabled=YES;
    self.shippingStateButton.userInteractionEnabled=YES;
    self.contectBtn.userInteractionEnabled=YES;
    timeBackgroundView.hidden=YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{//self.landingScrollView.contentSize
    content  = CGSizeMake(320,self.landingScrollView.frame.origin.y+self.view1.frame.size.height+self.view2.frame.size.height+self.view3.frame.size.height+220);
    self.landingScrollView.contentSize=content;
    [super viewWillAppear:animated];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    timeBackgroundView.hidden=YES;
    self.counteyBtn.userInteractionEnabled=YES;
    self.shippingCountryButton.userInteractionEnabled=YES;
    self.stateBtn.userInteractionEnabled=YES;
    self.shippingStateButton.userInteractionEnabled=YES;
    self.contectBtn.userInteractionEnabled=YES;
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

-(void)saveDataOnModelClass
{
    [historyModel sharedhistoryModel].name_customer=self.billingName.text;
    [historyModel sharedhistoryModel].address=self.billingAddress1.text;
    [historyModel sharedhistoryModel].address1=self.billingAddress2.text;
    [historyModel sharedhistoryModel].postcode=self.billingZip.text;
    [historyModel sharedhistoryModel].Province=self.billingState.text;
    [historyModel sharedhistoryModel].city=self.billincity.text;
    [historyModel sharedhistoryModel].Country=self.billingCountry.text;
    [historyModel sharedhistoryModel].shipping_name_customer=self.shippingName.text;
    [historyModel sharedhistoryModel].shipping_address=self.shippingAddress1.text;
    [historyModel sharedhistoryModel].shipping_address1=self.shippingAddress2.text;
    [historyModel sharedhistoryModel].shipping_postcode=self.shippingZip.text;
    [historyModel sharedhistoryModel].shipping_Province=self.shippingState.text;
    [historyModel sharedhistoryModel].shipping_city=self.shippingcity.text;
    [historyModel sharedhistoryModel].shipping_Country=self.shippingCountry.text;
    [historyModel sharedhistoryModel].mobile_no=self.contectPhone.text;
    [historyModel sharedhistoryModel].contact_me=self.contectMe.text;
    [historyModel sharedhistoryModel].comments=self.contectComment.text;
    [historyModel sharedhistoryModel].customer_email=self.contectEmail.text;
    
}
#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    
    
    return YES;
    
}
-(void)scrollVievEditingFinished:(UITextField*)textField
{
    //CGPoint point = CGPointMake(0, 0);
    [self.landingScrollView setContentOffset:point animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //self.landingScrollView.contentSize  = CGSizeMake(320,self.landingScrollView.frame.origin.y+self.view1.frame.size.height+self.view2.frame.size.height+self.view3.frame.size.height+200);
    [textField resignFirstResponder];
}

- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.landingScrollView];
    pt = rc.origin;
    CGPoint point1 = CGPointMake(0,pt.y - 1.5 * textField.frame.size.height);
    [self.landingScrollView setContentOffset:point1 animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"%f", scrollView.contentOffset.y);
    point=CGPointMake(0,scrollView.contentOffset.y);
    
}

@end
