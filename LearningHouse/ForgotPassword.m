//
//  ForgotPassword.m
//  LearningHouse
//
//  Created by Alok Singh on 8/4/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "ForgotPassword.h"

@interface ForgotPassword ()<WebServiceResponseProtocal>
{
    SWRevealViewController *revealController ;
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    
}

@end

@implementation ForgotPassword
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.emailText.leftView = paddingView1;
    self.emailText.leftViewMode = UITextFieldViewModeAlways;
    self.emailText.delegate=self;


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)forgotPassword:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper loginApi:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{ NSDictionary*  result = [NSJSONSerialization JSONObjectWithData:responseDictionary options:kNilOptions error:nil];
    NSLog(@"Result = %@",result);
    
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"loginApi"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info);
        [SVProgressHUD dismiss];
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    
                    NSString *valueToSave = [[info objectAtIndex:0]objectForKey:@"customer_id"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
                    OTPViewController*otpViewVC=[[OTPViewController alloc]init];
                    [self.navigationController pushViewController:otpViewVC animated:YES];
                    [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Success"];
                    otpViewVC.customerID=[[info objectAtIndex:0]objectForKey:@"customer_id"];
                    otpViewVC.messageStr=[[info objectAtIndex:0]objectForKey:@"msg"];
                    otpViewVC.forgetpassword=@"forgetpassword";
                    
                    
                }
                
                else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==0)
                {
                    //[MyCustomClass SVProgressMessageDismissWithError:[[info objectAtIndex:0]objectForKey:@"msg"] timeDalay:2.0];
                    [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Error"];
                }
                
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
    
    
    
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}



- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)forgotPassworsBtn:(id)sender
{
    [SVProgressHUD show];
    
    if(self.emailText.text==nil || [self.emailText.text length]<=0)
    {
        [self.emailText resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Email-id" timeDalay:1.0f];
    }
    else{
    
        
        
        dic=  @{@"email":self.emailText.text,@"area":@"ResetPassword",@"mode":@"PasswordUpdate",};
        [self forgotPassword:dic];
    }
    
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y-200);
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
    [self.emailText resignFirstResponder];
    
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
