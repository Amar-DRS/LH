//
//  OTPViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 6/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "OTPViewController.h"

@interface OTPViewController ()<WebServiceResponseProtocal>
{
    SWRevealViewController *revealController ;
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    NSString*reSendOtp;
    //OTP Verification

}

@end

@implementation OTPViewController
@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    revealController=[[SWRevealViewController alloc] init];
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.messageLab.text=self.messageStr;
    scrollView.delegate=self;
    self.otpTextField.delegate=self;
    // TextField padding

    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.otpTextField.leftView = paddingView1;
    self.otpTextField.leftViewMode = UITextFieldViewModeAlways;
  if ([self.forgetpassword isEqualToString:@"forgetpassword"])
  {
      self.reSendOtpBtn.hidden=YES;
  }

    //[SVProgressHUD dismissWithSuccess:@"Success!"];
    
  
}
-(void)OTPVerification:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper loginApi:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*  result = [NSJSONSerialization JSONObjectWithData:responseDictionary options:kNilOptions error:nil];
    NSLog(@"Result = %@",result);
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"loginApi"])
    {
        info = [dataDic objectForKey:@"info"];
        [SVProgressHUD dismiss];
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
               // [self.leftSubCategoryTable reloadData];
                if ([reSendOtp isEqualToString:@"genrateNewOtp"])
                {
                    if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                    {
                    
              
                        [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                                withTitle:@"Error"];

                    }
                    
                    else if([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==0)
                    {
                        [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                                withTitle:@"Error"];                    }

                }
                
                else
                {
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    if ([self.forgetpassword isEqualToString:@"forgetpassword"])
                    {
                        NSString *valueToSave = self.customerID;
                        
                        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
                    }

                  
                    
                 HomeViewController*HomeViewVC=[[HomeViewController alloc]init];
                    [self.navigationController pushViewController:HomeViewVC animated:YES];
                //[MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:2.0];
                    [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Success"];
                    [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:2.0];

                    
                }
                
               else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==0)
                {
                
                    [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Error"];
                }
               else{
                   [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:2.0];

               
               }
                   
                }
                
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:2.0];
        }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)verifyOTP:(id)sender {
    [SVProgressHUD show];

    if(self.otpTextField.text==nil || [self.otpTextField.text length]<=0)
    {
        [self.otpTextField resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter OTP" timeDalay:1.0f];
    }
    else
    {
        if (!self.customerID) {
            self.customerID=@"";
        }
        
    if ([self.forgetpassword isEqualToString:@"forgetpassword"])
    {
        
dic=  @{@"id_customer":self.customerID,@"otp":self.otpTextField.text,@"area":@"ResetPassword",@"mode":@"OTPVerification"};
        
        NSLog(@"dic--->%@",dic);
        [self OTPVerification:dic];

    }
        else
        {
    dic=  @{@"id_customer":self.customerID,@"otp":self.otpTextField.text,@"area":@"registration",@"mode":@"customerverfication"};
        
        NSLog(@"dic--->%@",dic);
    [self OTPVerification:dic];
        }
    }

}

- (IBAction)reSendOtp:(id)sender
{
    if (!self.customerID) {
        self.customerID=@"";
    }
       reSendOtp=@"genrateNewOtp";
        dic=  @{@"id_customer":self.customerID,@"area":@"registration",@"mode":@"otpgenerate"};
        [self OTPVerification:dic];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    scrollView.contentSize= CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+10);
    [super viewWillAppear:animated];
    
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
    
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];
    
    return YES;
}

-(IBAction)resignKexfyboard:(id)sender
{
    [self.otpTextField resignFirstResponder];
}
-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}


@end
