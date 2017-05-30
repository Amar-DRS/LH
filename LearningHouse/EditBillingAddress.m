//
//  EditBillingAddress.m
//  LearningHouse
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "EditBillingAddress.h"
#import "MyAccountViewController.h"

@interface EditBillingAddress ()<WebServiceResponseProtocal>
{
    NIDropDown *dropDown;
    UIPickerView*pickerView;
    UIView*timeBackgroundView;
    NSArray * stateArray;
    NSArray * countryArray;
    NSString*pickercheck;
    NSUInteger pickerRow;
      MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    NSInteger tag;
    CGPoint point;
}

@end

@implementation EditBillingAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.billingState.tag=101;
    self.billingcountry.tag=102;
    self.shippingStatebtn.tag=103;
    self.shippingCuntrybtn.tag=104;
    

    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    //self.landingScrollView.contentSize = CGSizeMake(0,1500);
    self.landingScrollView.delegate=self;

    self.view1.layer.borderWidth = 1;
    self.view1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.titleBillingLab.backgroundColor = [UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1];
    self.view2.layer.borderWidth = 1;
    self.view2.layer.borderColor = [[UIColor grayColor] CGColor];
    self.shippingTitleLab.backgroundColor = [UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    
//    self.provinceBtn.tag=101;
//    self.counteyBtn.tag=102;
//    self.shippingState.tag=103;
//    self.counteyBtn.tag=104;
//    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.username.leftView = paddingView;
    self.username.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.organizationtext.leftView = paddingView1;
    self.organizationtext.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.phoneText.leftView = paddingView2;
    self.phoneText.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.alternatePhoneText.leftView = paddingView3;
    self.alternatePhoneText.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.adress1Text.leftView = paddingView4;
    self.adress1Text.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.adress2Txt.leftView = paddingView5;
    self.adress2Txt.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.cityTxt.leftView = paddingView6;
    self.cityTxt.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.provinenceTxt.leftView = paddingView7;
    self.provinenceTxt.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.postalCodeTxt.leftView = paddingView8;
    self.postalCodeTxt.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.countryTxt.leftView = paddingView9;
    self.countryTxt.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.usernameShipping.leftView = paddingView10;
    self.usernameShipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView11 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.organizationTxt1.leftView = paddingView11;
    self.organizationTxt1.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView12 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.phoneTxtShipping.leftView = paddingView12;
    self.phoneTxtShipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView13 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.alternatePhoneShipping.leftView = paddingView13;
    self.alternatePhoneShipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView14 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.adress1Shipping.leftView = paddingView14;
    self.adress1Shipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView15 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.adress2Shipping.leftView = paddingView15;
    self.adress2Shipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView16 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.cityTxtShipping.leftView = paddingView16;
    self.cityTxtShipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView17 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.provinenceShipping.leftView = paddingView17;
    self.provinenceShipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView18 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.postalCodeShipping.leftView = paddingView18;
    self.postalCodeShipping.leftViewMode = UITextFieldViewModeAlways;
    UIView *paddingView19 = [[UIView alloc] initWithFrame:CGRectMake(0, 0,5,20)];
    self.countryShipping.leftView = paddingView19;
    self.countryShipping.leftViewMode = UITextFieldViewModeAlways;
    
    // text field delegate billing
    
    self.username.delegate=self;
    self.organizationtext.delegate=self;
    self.phoneText.delegate=self;
    self.alternatePhoneText.delegate=self;
    self.adress1Text.delegate=self;
    self.adress2Txt.delegate=self;
    self.cityTxt.delegate=self;
    self.provinenceTxt.delegate=self;
    self.postalCodeTxt.delegate=self;
    self.countryTxt.delegate=self;
    
    // text field delegate shipping
    
    self.usernameShipping.delegate=self;
    self.organizationTxt1.delegate=self;
    self.phoneTxtShipping.delegate=self;
    self.alternatePhoneShipping.delegate=self;
    self.adress1Shipping.delegate=self;
    self.adress2Shipping.delegate=self;
    self.cityTxtShipping.delegate=self;
    self.provinenceShipping.delegate=self;
    self.postalCodeShipping.delegate=self;
    self.countryShipping.delegate=self;
    


   // [MyCustomClass removeNullValueFromDictionary];
    self.username.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"name_customer"];
        self.organizationtext.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"organization"];
        self.phoneText.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"mobile_no"];
       self.alternatePhoneText.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"alternate_no"];
       self.adress1Text.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"address"];
       self.adress2Txt.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"address1"];
        self.cityTxt.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"city"];
       self.provinenceTxt.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"Province"];
        self.postalCodeTxt.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"postcode"];
       self.countryTxt.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"Country"];
    
        self.usernameShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_name_customer"];
    self.organizationTxt1.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_organization"];
       self.phoneTxtShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_mobile_no"];
       self.alternatePhoneShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_alternate_no"];
        self.adress1Shipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_address"];
        self.adress2Shipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_address1"];
        self.cityTxtShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_city"];
       self.provinenceShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_Province"];
       self.postalCodeShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_postcode"];
       self.countryShipping.text=[[historyModel sharedhistoryModel].myAccountData objectForKey:@"shipping_Country"];
   

    stateArray = [NSArray arrayWithObjects:@"Province/State",@"Alberta", @"British Columbia", @"Manitoba", @"Newfoundland", @"Nova Scotia", @"Northwest Territories", @"Nunavit", @"Ontario", @"Prince Edward Island",@"Quebec",@"Saskatchewan",@"Yukon",@"Alaska",@"Alabama",@"Arkansas",@"Arizona",@"California",@"Colorado",@"Connecticut",@"District of Columbia",@"Delaware",@"Florida",@"Georgia",@"Hawaii",@"Iowa",@"Idaho",@"Illinois",@"Indiana",@"Kansas",@"Kentucky",@"Louisiana",@"Massachusetts",@"Maryland",@"Maine",@"Michigan",@"Minnesota",@"Missouri",@"Mississippi",@"Montana",@"North Carolina",@"North Dakota",@"Nebraska",@"New Hampshire",@"New Jersey",@"New Mexico",@"Nevada",@"New York",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Puerto Rico",@"Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texas",@"Utah",@"Virginia",@"Virgin Islands",@"Vermont",@"Washington",@"Wisconsin",@"West Virginia",@"Wyoming",nil];
    countryArray = [NSArray arrayWithObjects:@"country",@"Canada", @"USA",nil];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
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
    if ([self.backtoController isEqualToString:@"RightMenu"])
    {
        MyAccountViewController *HomeViewControllerVC=[[MyAccountViewController alloc]init];
        
        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
        HomeViewControllerVC.backtoHome=@"right";
        
    }
    else
    {
  
    [self.navigationController popViewControllerAnimated:YES];
    }

}
- (IBAction)billingSaveBtn:(id)sender {
    [SVProgressHUD show];
    if(self.username.text==nil || [self.username.text length]<=0)
    {
        [self.username becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter username" timeDalay:1.0f];
    }
    else if(self.organizationtext.text==nil || [self.organizationtext.text length]<=0)
    {
        [self.organizationtext becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter organigation Name" timeDalay:1.0f];
    }
    
    else if(self.phoneText.text==nil || [self.phoneText.text length]<=0)
        
        //[self validateEmailWithString:emailTextfield.text]==NO)
    {
        [self.phoneText becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Phone Number" timeDalay:1.0f];
        // [self validateEmailWithString:self];
    }
    else if(self.adress1Text.text==nil || [self.adress1Text.text length]<=0)
    {
        [self.adress1Text becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Address" timeDalay:1.0f];
    }
    else if(self.cityTxt.text==nil || [self.cityTxt.text length]<=0)
    {
        [self.cityTxt becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter City Name" timeDalay:1.0f];
    }
    else if([self.provinenceTxt.text isEqualToString:@"Province/State"]||self.provinenceTxt.text==nil || [self.provinenceTxt.text length]<=0)
    {
        [self.provinenceTxt becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Province/state" timeDalay:1.0f];
    }
    else if(self.postalCodeTxt.text==nil || [self.postalCodeTxt.text length]<=0)
    {
        [self.postalCodeTxt becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter PostalCode" timeDalay:1.0f];
    }
    else if([self.countryTxt.text isEqualToString:@"country"]||self.countryTxt.text==nil || [self.countryTxt.text length]<=0)
    {
        [self.countryTxt becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Country Name" timeDalay:1.0f];
    }
    
    else
    {
        [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
        if (!savedValue) {
            savedValue=@"";
        }
       
        dic=@{@"id_customer":savedValue,@"area":@"account",@"action":@"update",@"mode":@"billing",@"name_customer":self.username.text,@"organization":self.organizationtext.text,@"address":self.adress1Text.text,@"address1": self.adress2Txt.text,@"alternate_no":self.alternatePhoneText.text,@"mobile_no":self.phoneText.text,@"postcode":self.postalCodeTxt.text,@"Province":self.provinenceTxt.text,@"city":self.cityTxt.text,@"Country":self.countryTxt.text};
       // NSLog(@"dic>>>%@",dic);
        
        [helper myAccount:dic];
    }
    

}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAccount"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info);
        
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [historyModel sharedhistoryModel].BillingDetail=info;
             //   [MyCustomClass SVProgressHUD appearance] setHudFont:[UIFont fontWithName:@"MarkerFelt-Wide" size:16]] ];
 
                [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:1.0];
                
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
    
    
    
}
- (IBAction)shippinSaveBtn:(id)sender {
    [SVProgressHUD show];
    if(self.usernameShipping.text==nil || [self.usernameShipping.text length]<=0)
    {
        [self.usernameShipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter username" timeDalay:1.0f];
    }
    else if(self.organizationTxt1.text==nil || [self.organizationTxt1.text length]<=0)
    {
        [self.organizationTxt1 becomeFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter organigation Name" timeDalay:1.0f];
    }
    
    else if(self.phoneTxtShipping.text==nil || [self.phoneTxtShipping.text length]<=0)
        
        //[self validateEmailWithString:emailTextfield.text]==NO)
    {
        [self.phoneTxtShipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Phone Number" timeDalay:1.0f];
        // [self validateEmailWithString:self];
    }
    else if(self.adress1Shipping.text==nil || [self.adress1Shipping.text length]<=0)
    {
        [self.adress1Shipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Address" timeDalay:1.0f];
    }
    else if(self.cityTxtShipping.text==nil || [self.cityTxtShipping.text length]<=0)
    {
        [self.cityTxtShipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter City Name" timeDalay:1.0f];
    }
    else if([self.provinenceShipping.text isEqualToString:@"Province/State"]||self.provinenceShipping.text==nil || [self.provinenceShipping.text length]<=0)
    {
        [self.provinenceShipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Province/state" timeDalay:1.0f];
    }
    else if(self.postalCodeShipping.text==nil || [self.postalCodeShipping.text length]<=0)
    {
        [self.postalCodeShipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter PostalCode" timeDalay:1.0f];
    }
    else if([self.countryShipping.text isEqualToString:@"country"]||self.countryShipping.text==nil || [self.countryShipping.text length]<=0)
    {
        [self.countryShipping becomeFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Country Name" timeDalay:1.0f];
      }
    else
    {
        [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
        if (!savedValue) {
            savedValue=@"";
        }
      
        NSDictionary*dicPar=@{@"id_customer":savedValue,@"area":@"account",@"action":@"update",@"mode":@"shipping",
            @"shipping_name_customer":self.usernameShipping.text,
            @"shipping_organization":self.organizationTxt1.text,
            @"shipping_address":self.adress1Shipping.text,
            @"shipping_address1":self.adress2Shipping.text,
            @"shipping_alternate_no":self.alternatePhoneShipping.text,
            @"shipping_mobile_no":self.phoneTxtShipping.text,
           @"shipping_postcode":self.postalCodeShipping.text,
            @"shipping_Province":self.provinenceShipping.text,
            @"shipping_city":self.cityTxtShipping.text,
            @"shipping_Country":self.countryShipping.text,
                           };
        
        [helper myAccount:dicPar];
    }
    
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
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnDoneButtonOnActionSheet:)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
 timeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0,Window_Height-160, Window_Width, 170)];    [timeBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [timeBackgroundView addSubview:pickerToolbar];
    [timeBackgroundView addSubview:pickerView];
    [[AppDelegate appDelegate].window addSubview:timeBackgroundView];
    [pickerToolbar setItems:itemArray animated:YES];
    

    }

//self.billingState.tag=101;
//self.billingcountry.tag=102;
//self.shippingStatebtn.tag=103;
//self.shippingCuntrybtn.tag=104;

- (IBAction)billingcountry:(id)sender
{
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    [self keyboardReturn];
    pickercheck=@"country";
    self.billingcountry.userInteractionEnabled=NO;


    [self CreatePicker];
}



- (IBAction)billingState:(id)sender {
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    [self keyboardReturn];
    pickercheck=@"state";
    self.billingState.userInteractionEnabled=NO;

    
    [self CreatePicker];
    
    
}

- (IBAction)shippingCuntrybtn:(id)sender {
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    [self keyboardReturn];
    pickercheck=@"country";
    self.shippingCuntrybtn.userInteractionEnabled=NO;
    
    
    [self CreatePicker];
    
}

- (IBAction)shippingStatebtn:(id)sender {
    UIButton *button=(UIButton *)sender;
    tag = [button tag];
    [self keyboardReturn];
    
    pickercheck=@"state";
    self.shippingStatebtn.userInteractionEnabled=NO;
    
    
    [self CreatePicker];
}

- (IBAction)shippingSaveBtn:(id)sender {
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if ([pickercheck isEqualToString:@"country"])
    {
    return [countryArray count];
    }
    else
        {
            return [stateArray count];
         }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([pickercheck isEqualToString:@"country"])
{
    return [countryArray objectAtIndex:row];
   }
    else
        {
            return [stateArray objectAtIndex:row];
         }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    pickerRow=row;
    NSLog(@"pickerRow....>%ld",(long)pickerRow);
}

-(void)clickOnDoneButtonOnActionSheet:(id)sender
{    if ([pickercheck isEqualToString:@"country"])
    {
        
        if (tag==102)
        {
            self.countryTxt.text= [countryArray objectAtIndex:pickerRow];
            self.billingcountry.userInteractionEnabled=YES;
            
        }
        else if (tag==104)
        {
        
            self.countryShipping.text= [countryArray objectAtIndex:pickerRow];
            
            self.shippingCuntrybtn.userInteractionEnabled=YES;
        }

//    self.countryTxt.text= [countryArray objectAtIndex:pickerRow];
//        self.countryShipping.text= [countryArray objectAtIndex:pickerRow];
//
//        self.counteyBtn.userInteractionEnabled=YES;
        }
    else
        {
            
            
            if (tag==101)
            {
               
                self.provinenceTxt.text= [stateArray objectAtIndex:pickerRow];
                self.billingState.userInteractionEnabled=YES;
                
            }
            else if (tag==103)
            {
             
                self.provinenceShipping.text= [stateArray objectAtIndex:pickerRow];
                
                self.shippingStatebtn.userInteractionEnabled=YES;
                
            }
//            self.provinenceTxt.text= [stateArray objectAtIndex:pickerRow];
//            self.provinenceShipping.text= [stateArray objectAtIndex:pickerRow];
//
//            
//  
//            self.provinceBtn.userInteractionEnabled=YES;

        }
            
        
    timeBackgroundView.hidden=YES;
}

-(void)clickOnCancelButtonOnActionSheet:(id)sender
{
    if ([pickercheck isEqualToString:@"country"])
    {
        
        if (tag==102)
        {
            self.billingcountry.userInteractionEnabled=YES;
            
        }
        else if (tag==104)
        {
            
            
            self.shippingCuntrybtn.userInteractionEnabled=YES;
        }

    }
    else
    {
        
        
        if (tag==101)
        {
            
            self.billingState.userInteractionEnabled=YES;
            
        }
        else if (tag==103)
        {
            
            
            self.shippingStatebtn.userInteractionEnabled=YES;
            
        }

        
    }
    

    timeBackgroundView.hidden=YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //self.landingScrollView.contentSize = CGSizeMake(0,1500);
    [self scrollVievEditingFinished:textField];
    return YES;
}
-(void)keyboardReturn
// text field delegate billing
{
    [self.username resignFirstResponder];
    [self.organizationtext resignFirstResponder];
    [self.phoneText resignFirstResponder];
    [self.alternatePhoneText resignFirstResponder];
    [self.adress1Text resignFirstResponder];
    [self.cityTxt resignFirstResponder];
    [self.provinenceTxt resignFirstResponder];
    [self.postalCodeTxt resignFirstResponder];
    [self.countryTxt resignFirstResponder];
    [self.usernameShipping resignFirstResponder];
    [self.organizationTxt1 resignFirstResponder];
    [self.phoneTxtShipping resignFirstResponder];
    [self.alternatePhoneShipping resignFirstResponder];
    [self.adress1Shipping resignFirstResponder];
    [self.adress2Shipping resignFirstResponder];
    [self.cityTxtShipping resignFirstResponder];
    [self.provinenceShipping resignFirstResponder];
    [self.postalCodeShipping resignFirstResponder];
    [self.countryShipping resignFirstResponder];
    timeBackgroundView.hidden=YES;

    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    timeBackgroundView.hidden=YES;
    self.billingcountry.userInteractionEnabled=YES;
    self.shippingCuntrybtn.userInteractionEnabled=YES;
    self.billingState.userInteractionEnabled=YES;
    self.shippingStatebtn.userInteractionEnabled=YES;




    //self.landingScrollView.contentSize = CGSizeMake(0,self.view1.frame.size.height+self.view2.frame.size.height);

    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{

    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone 4s
    self.landingScrollView.contentSize= CGSizeMake(0,self.view1.frame.size.height+self.view2.frame.size.height+self.view2.frame.origin.y-200);        }
        if(result.height == 568)
        {
            // iPhone 5s
    self.landingScrollView.contentSize= CGSizeMake(0,1482);        }
        if(result.height == 667)
            
        {
            // iPhone 6
    self.landingScrollView.contentSize= CGSizeMake(0,1581);
        }
        if(result.height == 736 )
        {
            
            // iPhone 6 Plus$6splus
            
    self.landingScrollView.contentSize= CGSizeMake(0,1650);
        }
    }


    [super viewWillAppear:animated];
    
}
#pragma mark -
#pragma mark UITextFieldDelegate

- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.landingScrollView];
    pt = rc.origin;
    CGPoint point1 = CGPointMake(0,pt.y - 1.5 * textField.frame.size.height);
    [self.landingScrollView setContentOffset:point1 animated:YES];
}
-(void)scrollVievEditingFinished:(UITextField*)textField
{
    //CGPoint point = CGPointMake(0, 0);
    [self.landingScrollView setContentOffset:point animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"%f", scrollView.contentOffset.y);
    point=CGPointMake(0,scrollView.contentOffset.y);
    
}
@end
