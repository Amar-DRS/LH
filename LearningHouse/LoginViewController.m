//
//  LoginViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 6/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"


@interface LoginViewController ()<WebServiceResponseProtocal>
{
    SWRevealViewController *revealController ;
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    

}
@end

@implementation LoginViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    revealController=[[SWRevealViewController alloc] init];
    self.userNameText.delegate=self;
    self.passwordtext.delegate=self;
    scrollView.delegate=self;
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    
    // TextField padding
   // UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
   // self.userNameText.leftView = paddingView;
   // self.userNameText.leftViewMode = UITextFieldViewModeAlways;
    
    //UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    //self.passwordtext.leftView = paddingView1;
   // self.passwordtext.leftViewMode = UITextFieldViewModeAlways;
    
    // Do any additional setup after loading the view from its nib.
}
-(void)OTPVerification:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper loginApi:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"loginApi"])
    {
        info = [dataDic objectForKey:@"info"];
        //NSLog(@"loginApi--->,%@",info);
        [SVProgressHUD dismiss];

        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==1)
                {
                    
                    NSString *valueToSave = [[info objectAtIndex:0]objectForKey:@"customer_id"];
                    NSString *CookieCartId = [[info objectAtIndex:0]objectForKey:@"CookieCart"];
                    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
                     [[NSUserDefaults standardUserDefaults] setObject:CookieCartId forKey:@"CookieCart"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    NSString *userNameStr = [[info objectAtIndex:0]objectForKey:@"username"];
                    [[NSUserDefaults standardUserDefaults] setObject:userNameStr forKey:@"userName"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                 
                    HomeViewController*HomeViewVC=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
                    [self.navigationController pushViewController:HomeViewVC animated:YES];
                    [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:2.0];
;
                    
                }
                
               else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==0)
                {
                    [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Error"];

                }
                
               else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==2)
               {
                   [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                           withTitle:@""];
                   OTPViewController*OTPViewViewVC=[[OTPViewController alloc]init];
                   [self.navigationController pushViewController:OTPViewViewVC animated:NO];
                   OTPViewViewVC.customerID=[[info objectAtIndex:0] objectForKey:@"customer_id"];

               }
                
               else if ([[[info objectAtIndex:0]objectForKey:@"status"] intValue]==3)
               {
                   [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                           withTitle:@""];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtn:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {
        HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
                HomeViewControllerVC.menuString=@"BackLeft";
        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];

    }
    else{
 
    
    [self.navigationController popViewControllerAnimated:YES];
    }


}

- (IBAction)loginBtn:(id)sender
{
    [SVProgressHUD show];
    
    if(self.userNameText.text==nil || [self.userNameText.text length]<=0)
    {
        [self.userNameText resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Username" timeDalay:1.0f];
    }
   else if(self.passwordtext.text==nil || [self.passwordtext.text length]<=0)
    {
        [self.passwordtext resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Password" timeDalay:1.0f];
    }
    else{
        
        dic=  @{@"username":self.userNameText.text,@"password":self.passwordtext.text,@"CookieCart":@"",@"area":@"login",@"mode":@"login",};
        [self OTPVerification:dic];
    }
}

- (IBAction)forgotPassword:(id)sender
{
    
    ForgotPassword *ForgotPasswordVC=[[ForgotPassword alloc]init];
    [self.navigationController pushViewController:ForgotPasswordVC animated:YES];
    
}

- (IBAction)registerBtn:(id)sender
{
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {
        RegisterViewController *HomeViewControllerVC=[[RegisterViewController alloc]init];
        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
        
    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    scrollView.contentSize= CGSizeMake(0, self.view.frame.size.height+100);
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

-(IBAction)resignKeyboard:(id)sender
{
    [self.userNameText resignFirstResponder];
    [self.passwordtext resignFirstResponder];
    
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
