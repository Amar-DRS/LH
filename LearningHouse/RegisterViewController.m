//
//  RegisterViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/3/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "RegisterViewController.h"
#import "HomeViewController.h"

@interface RegisterViewController ()<WebServiceResponseProtocal,UIAlertViewDelegate>
{

   SWRevealViewController *revealController ;
    MyWebServiceHelper *helper;
    UIAlertController *myAlertController;
}

@end

@implementation RegisterViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
   revealController=[[SWRevealViewController alloc] init];
    helper = [[MyWebServiceHelper alloc] init];
    
    helper.webApiDelegate = self;
    self.fullname.delegate=self;
    self.emil.delegate=self;
    self.userName.delegate=self;
    self.password.delegate=self;
    self.confermpassword.delegate=self;
    scrollView.delegate=self;
    
    // TextField padding
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 20)];
    self.fullname.leftView = paddingView;
    self.fullname.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.emil.leftView = paddingView1;
    self.emil.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.userName.leftView = paddingView2;
    self.userName.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.password.leftView = paddingView3;
    self.password.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.confermpassword.leftView = paddingView4;
    self.confermpassword.leftViewMode = UITextFieldViewModeAlways;


    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSMutableDictionary *dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    [SVProgressHUD dismiss];

    if([apiName isEqualToString:@"register"])
    {
        NSString*status=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"status"];
       
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([status intValue] == 0)
            {
                //[MyCustomClass SVProgressMessageDismissWithSuccess:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"] timeDalay:1.0];
[self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                        withTitle:@"Error"];

            }
           else if ([status intValue] == 1)
            {
                OTPViewController *OTPViewControllerVC = [[OTPViewController alloc]init];
                [self.navigationController pushViewController:OTPViewControllerVC animated:YES];
                OTPViewControllerVC.customerID=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"id_customer"];
                OTPViewControllerVC.messageStr=[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"];
                [self showMessage:[[[dataDic objectForKey:@"info"] objectAtIndex:0] objectForKey:@"msg"]
                        withTitle:@"Success"];
                


            }

        
        });
    }
    
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}



- (IBAction)backBtn:(id)sender
{
    
    HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
    HomeViewControllerVC.menuString=@"BackLeft";
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
}


- (IBAction)registerBtn:(id)sender {
   
    [SVProgressHUD show];
   
        if(self.fullname.text==nil || [self.fullname.text length]<=0)
    {
        [self.fullname resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Full Name" timeDalay:1.0f];
    }
    else if(self.emil.text==nil || [self.emil.text length]<=0)
    {
        [self.emil resignFirstResponder];
        
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Email ID" timeDalay:1.0f];
    }
    
    else if(self.userName.text==nil || [self.userName.text length]<=0)
        
        //[self validateEmailWithString:emailTextfield.text]==NO)
    {
        [self.userName resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter User Name" timeDalay:1.0f];
        // [self validateEmailWithString:self];
    }
    else if(self.password.text==nil || [self.password.text length]<=0)
    {
        [self.password resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Password" timeDalay:1.0f];
    }
    else if(self.confermpassword.text==nil || [self.confermpassword.text length]<=0)
    {
        [self.confermpassword resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Conferm Password" timeDalay:1.0f];
    }
    
    else if (!([self.fullname.text length]<=0)||[self.emil.text length]<=0||[self.userName.text length]<=0||[self.password.text length]<=0||[self.confermpassword.text length]<=0)
    {
        [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];

        NSDictionary*dic=@{
                           @"name_customer":self.fullname.text,
                           @"email": self.emil.text,
                           @"username":self.userName.text,
                           @"password":self.password.text,
                           @"password_verify":self.confermpassword.text,
                           @"area":@"registration",
                           @"mode":@"add",
                           };
        NSLog(@"dic>>>%@",dic);

        [helper registerApi:[NSDictionary dictionaryWithDictionary:dic]];
    }

}

- (IBAction)loginBtn:(id)sender
{
    
    LoginViewController*LoginViewVC=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:LoginViewVC animated:YES];
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
    [self.fullname resignFirstResponder];
    [self.emil resignFirstResponder];
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
    [self.confermpassword resignFirstResponder];

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
