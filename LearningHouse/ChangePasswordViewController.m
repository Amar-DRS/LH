//
//  ChangePasswordViewController.m
//  LearningHouse
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info1;

}

@end

@implementation ChangePasswordViewController
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;

    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.nameCoustomer.delegate=self;
    self.changePasword.delegate=self;
    self.repeatPasword.delegate=self;
    self.titleLab.text=[NSString stringWithFormat:@"  %@",self.titleStr];
    NSDictionary*info=[historyModel sharedhistoryModel].myAccountData;
    self.emailTextField.text=[NSString stringWithFormat:@"%@",[info  objectForKey:@"customer_email"]];
    self.userNameTextField.text=[NSString stringWithFormat:@"%@",[info objectForKey:@"username"]];
    self.nameCoustomer.text=[NSString stringWithFormat:@"%@",[info objectForKey:@"name_customer"]];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 20)];
    self.emailTextField.leftView = paddingView;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.userNameTextField.leftView = paddingView1;
    self.userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.nameCoustomer.leftView = paddingView2;
    self.nameCoustomer.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.changePasword.leftView = paddingView3;
    self.changePasword.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.repeatPasword.leftView = paddingView4;
    self.repeatPasword.leftViewMode = UITextFieldViewModeAlways;
    [self.changePasword setValue:[UIColor blackColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.repeatPasword setValue:[UIColor blackColor]
                      forKeyPath:@"_placeholderLabel.textColor"];

    // Do any additional setup after loading the view from its nib.
}

-(void)myAccountInfo:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper myAccount:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAccount"])
    {
        info1 = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info1);
        
        if (info1.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:[[info1 objectAtIndex:0]objectForKey:@"msg"] timeDalay:1.0];
                
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
        [self.navigationController popViewControllerAnimated:NO];

    }

}
- (IBAction)saveBtn:(id)sender
{
    
    [SVProgressHUD show];
    NSLog(@"name>%@>>name",self.nameCoustomer.text);
    //if ([[self.nameCoustomer.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    if (self.nameCoustomer.text==nil || [self.nameCoustomer.text length]<=0)
    {
        [self.nameCoustomer resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter UserName" timeDalay:1.0f];
    }
   else if (self.changePasword.text==nil || [self.changePasword.text length]<=0)
   {
       [self.changePasword resignFirstResponder];
       [MyCustomClass SVProgressMessageDismissWithError:@"Enter Password" timeDalay:1.0f];
   }
   else if (self.repeatPasword.text==nil || [self.repeatPasword.text length]<=0)
   {
       [self.repeatPasword resignFirstResponder];
       [MyCustomClass SVProgressMessageDismissWithError:@"Enter Repeat Password" timeDalay:1.0f];
   }

    else if(!(self.changePasword.text==self.repeatPasword.text))
    {
        [self.changePasword resignFirstResponder];
        [self.repeatPasword resignFirstResponder];

        [MyCustomClass SVProgressMessageDismissWithError:@"Password Missmatch" timeDalay:1.0f];
    }
    else
    {

    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
        
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"preferenceName"];
        if (!savedValue) {
            savedValue=@"";
        }
      


    dic=  @{@"id_customer":savedValue,@"area":@"editprofile",@"mode":@"",@"name_customer":self.nameCoustomer.text,@"password":self.changePasword.text,};
    
    [helper myAccount:dic];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    self.titleLab.text=@"Edit Profile";

    scrollView.contentSize= CGSizeMake(0, self.view.frame.size.height);
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

@end
