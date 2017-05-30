//
//  MyAccountViewController.m
//  LearningHouse
//
//  Created by Amar DRS on 8/8/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "MyAccountViewController.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"

@interface MyAccountViewController ()<WebServiceResponseProtocal>

{
    SWRevealViewController *revealController ;
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    BOOL isShown;
    UIView *myView;
    AppDelegate *delegate;
    RightMenuViewController*RightMenuVC;
    NSMutableDictionary *replaced;
    
}
- (NSDictionary *) dictionaryByReplacingNullsWithStrings;

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.titleLab.text=@"My Profile";
    
    self.view1.layer.borderWidth = 1;
    self.view1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.view2.layer.borderWidth = 1;
    self.view2.layer.borderColor = [[UIColor blackColor] CGColor];
    self.view3.layer.borderWidth = 1;
    self.view3.layer.borderColor = [[UIColor blackColor] CGColor];
    self.view4.layer.borderWidth = 1;
    self.view4.layer.borderColor = [[UIColor blackColor] CGColor];
    [historyModel sharedhistoryModel].myAccount=@"myAccountVC";
    
    self.myProfilLab.backgroundColor = [UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1];
    self.billingLab.backgroundColor = [UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1];
    self.shippingLAB.backgroundColor = [UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1];
    
    
    revealController = [self revealViewController];
    [self.revealViewController panGestureRecognizer];
    [self.revealViewController tapGestureRecognizer];
    
    NSString*myproFile=@"  MY PROFILE";
    self.myProfilLab.text=[NSString stringWithFormat:@"  %@",myproFile];
    NSString*billing=@"  BILLING ADDRESS";
    self.billingLab.text=[NSString stringWithFormat:@"  %@",billing];
    NSString*shipping=@"  SHIPPING ADDRESS";
    self.shippingLAB.text=[NSString stringWithFormat:@"  %@",shipping];
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceName"];
    
    if (![savedValue isEqualToString:@""])
    {
        
        
    }
    if (!savedValue) {
        savedValue=@"";
    }
    
    
    dic=  @{@"id_customer":savedValue,@"area":@"account",@"mode":@"",};
    [self myAccountInfo:dic];
    self.myAccountTitle.text=@"From your Dashboard you have the ability to view a snapshot of your recent account activity and update your account information. Select a link below to view or edit information.";
    
    
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
    info =[dataDic objectForKey:@"info"];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"myAccount"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"loginApi--->,%@",info);
        
        if (info.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary*info2=[info objectAtIndex:0];
                NSDictionary*AddressData=[MyCustomClass getValuesWithOutNull:info2];
                
                [historyModel sharedhistoryModel].myAccountData=AddressData;
                self.emailLab.text=[NSString stringWithFormat:@"Email: %@",[AddressData objectForKey:@"customer_email"]];
                self.nameLab.text=[NSString stringWithFormat:@"Name: %@",[AddressData objectForKey:@"name_customer"]];
                self.userNamLab.text=[[NSString stringWithFormat:@"HELLO %@",[AddressData objectForKey:@"username"]] uppercaseString];
                
                if ([[AddressData objectForKey:@"address"] isEqualToString:@""])
                    
                {
                    self.billingAddressLab.text =@"No billing address available.";
                    [self.billingAddressLab sizeToFit];
                }
                else
                {
//                    self.billingAddressLab.text=[NSString stringWithFormat:@"%@\n%@\n%@, %@, %@",[AddressData objectForKey:@"address"],[AddressData objectForKey:@"address1"],[AddressData objectForKey:@"city"],[AddressData objectForKey:@"Province"],[AddressData objectForKey:@"postcode"]];
                     self.billingAddressLab.text=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",[AddressData objectForKey:@"address"],[AddressData objectForKey:@"address1"],[AddressData objectForKey:@"city"],[AddressData objectForKey:@"Province"],[AddressData objectForKey:@"postcode"]];

                }
                if ([[AddressData objectForKey:@"shipping_address"] isEqualToString:@""])
                {
                    self.shippingAddressLab.text =@"No shipping address available.";
                    [self.shippingAddressLab sizeToFit];
                    
                }
                else
                {
                    
//                    self.shippingAddressLab.text=[NSString stringWithFormat:@"%@\n%@\n%@, %@, %@",[[info objectAtIndex:0]objectForKey:@"shipping_address"],[AddressData objectForKey:@"shipping_address1"],[AddressData objectForKey:@"shipping_city"],[AddressData objectForKey:@"shipping_Province"],[AddressData objectForKey:@"shipping_postcode"]];
                     self.shippingAddressLab.text=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",[[info objectAtIndex:0]objectForKey:@"shipping_address"],[AddressData objectForKey:@"shipping_address1"],[AddressData objectForKey:@"shipping_city"],[AddressData objectForKey:@"shipping_Province"],[AddressData objectForKey:@"shipping_postcode"]];
                    [self.shippingAddressLab sizeToFit];
                }
                
                
                
                
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
    
    HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
    HomeViewControllerVC.menuString=@"BackLeft";
    [historyModel sharedhistoryModel].myAccount=@"NotmyAccountVC";
    
    
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];}
- (IBAction)changePassword:(id)sender
{
    ChangePasswordViewController*ChangePasswordVC=[[ChangePasswordViewController alloc]init];
    [self.navigationController pushViewController:ChangePasswordVC animated:YES];
    ChangePasswordVC.titleStr= @"Edit Profile";
}

- (IBAction)editAddress:(id)sender {
    EditBillingAddress*EditBillingAddressVC=[[EditBillingAddress alloc]init];
    [self.navigationController pushViewController:EditBillingAddressVC animated:YES];
    EditBillingAddressVC.address=@"billingAddress";
}

- (IBAction)editshipingAddress:(id)sender
{
    EditBillingAddress*EditBillingAddressVC=[[EditBillingAddress alloc]init];
    [self.navigationController pushViewController:EditBillingAddressVC animated:YES];
    EditBillingAddressVC.address=@"shippingAddress";
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"preferenceName"];
    if (!savedValue) {
        savedValue=@"";
    }
    
    dic=  @{@"id_customer":savedValue,@"area":@"account",@"mode":@"",};
    [self myAccountInfo:dic];
    self.myAccount=@"myAccountVC";
    if ([self.backtoHome isEqualToString:@"right"])
    {
        
        [revealController rightRevealToggle:self];
        
    }
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone 4s
             self.landingScrollView.contentSize= CGSizeMake(0,714);
        }
        if(result.height == 568)
        {
            // iPhone 5s
            self.landingScrollView.contentSize= CGSizeMake(0,802);        }
        if(result.height == 667)
            
        {
            // iPhone 6
            self.landingScrollView.contentSize= CGSizeMake(0,901);
        }
        if(result.height == 736 )
        {
            
            // iPhone 6 Plus$6splus
            
            self.landingScrollView.contentSize= CGSizeMake(0,970);
        }
    }


    
}
- (IBAction)rightMenu:(id)sender
{
    self.myAccount=@"myAccountVC";
    [self.menuBtn addTarget:revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
}

@end
