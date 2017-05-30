//
//  RightMenuViewController.m
//  Patient'sAppointment
//
//  Created by Raj Kumar on 07/11/15.
//  Copyright (c) 2015 Raj Kumar. All rights reserved.
//
//@"icon-my-med1.png",,@"icon-vitals1.png",,
#import "RightMenuViewController.h"
#import "RightMenuTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MyOrder.h"



@interface RightMenuViewController ()<WebServiceResponseProtocal>
{
    NSUInteger row;
    MyWebServiceHelper *helper;
    NSDictionary*dataDic;
    NSArray*info;
    MyAccountViewController*MyAccountVC;
    NSArray*MyAccountVCArray;
    UIView *tableFooter;
}

@end

@implementation RightMenuViewController
@synthesize dataArray;
@synthesize imageArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    MyAccountVC=[[MyAccountViewController alloc]init];
    MyAccountVCArray=[NSArray arrayWithObjects:@"Account Information",@"My Address",@"My Orders",@"Deactivate Account",@"Logout", nil];

   
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuImage"]];
    [self->rightSideTable setFrame:self->rightSideTable.frame];
    
    self->rightSideTable.backgroundView = tempImageView;
    
    // [viewAll setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    

    
   
}
-(void)viewAllBtn
{
    SWRevealViewController *revealController = self.revealViewController;
    MenuSubCategoriesViewController*MenuSubCategoriesVC=[[MenuSubCategoriesViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
    [revealController pushFrontViewController:navigationController animated:YES];
    //MenuSubCategoriesVC.codeCatalog=@"TLH";
    [historyModel sharedhistoryModel].codeCatalog=@"TLH";
    [historyModel sharedhistoryModel].subcategoryName=@"TLH Press";
    MenuSubCategoriesVC.rightORleftMenu=@"leftMenu";
    MenuSubCategoriesVC.viewAllRigthMenu=@"viewAll";
//[historyModel sharedhistoryModel].rightORleftMenu=@"RightMenu";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)clickOnViewProfileBtn:(id)sender
{
    NSString *backButtonHide = @"hide";
    [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![[historyModel sharedhistoryModel].myAccount isEqualToString:@"myAccountVC"])
    {
        
        
        tableFooter = [[UIView alloc] initWithFrame:CGRectMake(20, 718, 239, 50)];
        UIButton *viewAll=[UIButton buttonWithType:UIButtonTypeCustom ];
        [viewAll setFrame:CGRectMake(10, 0,160,40)];
        [viewAll setTitle:@"VIEW ALL"forState:UIControlStateNormal];
        viewAll.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [viewAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//set the color this is may be different for iOS 7
        [viewAll setBackgroundImage:[UIImage imageNamed:@"viewAll"] forState:UIControlStateNormal];
        [viewAll addTarget:self action:@selector(viewAllBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [tableFooter addSubview:viewAll];
        rightSideTable.tableFooterView = tableFooter;
        
    }
    else
    {
        tableFooter.hidden=YES;
        
    }
    [rightSideTable reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[historyModel sharedhistoryModel].myAccount isEqualToString:@"myAccountVC"])
        return MyAccountVCArray.count;
    else
    return [historyModel sharedhistoryModel].rigthMenuArray .count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"RightMenuTableViewCell";
    RightMenuTableViewCell *cell = (RightMenuTableViewCell *)[rightSideTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
            NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"RightMenuTableViewCell" owner:self options:nil];
        cell = [cellArray objectAtIndex:0];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font=[UIFont systemFontOfSize:15.0];

    }

  
     row = [indexPath row];

  if ([[historyModel sharedhistoryModel].myAccount isEqualToString:@"myAccountVC"])
  {
      cell.textLabel.text=[MyAccountVCArray objectAtIndex:indexPath.row];
  }
    else
    {
     cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",[[[historyModel sharedhistoryModel].rigthMenuArray objectAtIndex:indexPath.row]objectForKey:@"name_category"],[[[historyModel sharedhistoryModel].rigthMenuArray objectAtIndex:indexPath.row]objectForKey:@"count"]];
    }
    
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView;
    if ([[historyModel sharedhistoryModel].myAccount isEqualToString:@"myAccountVC"])
    {
        NSString *usernameStr = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"userName"];
         headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,5,300,20)];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.font = [UIFont systemFontOfSize:17];
        
        tempLabel.text=usernameStr;
        [headerView addSubview:tempLabel];
        return headerView;
    
    }
    else
    {
         headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        
        UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,5,300,15)];
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.font = [UIFont systemFontOfSize:18];
        
        tempLabel.text=@"CATEGORIES";
        [headerView addSubview:tempLabel];
        return headerView;
    
    }
    return headerView;
  

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[historyModel sharedhistoryModel].myAccount isEqualToString:@"myAccountVC"])
    {
        
     if (indexPath.row==0)
     {
         SWRevealViewController *revealController = self.revealViewController;
         ChangePasswordViewController*MenuSubCategoriesVC=[[ChangePasswordViewController alloc] init];
         UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
         [revealController pushFrontViewController:navigationController animated:YES];
         MenuSubCategoriesVC.backtoController=@"RightMenu";


     }
        if (indexPath.row==1)
        {
            SWRevealViewController *revealController = self.revealViewController;
            EditBillingAddress*MenuSubCategoriesVC=[[EditBillingAddress alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            MenuSubCategoriesVC.backtoController=@"RightMenu";
            
            
        }
        if (indexPath.row==2)
        {
            SWRevealViewController *revealController = self.revealViewController;
            MyOrder*MyOrderVC=[[MyOrder alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MyOrderVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            MyOrderVC.backtoController=@"RightMenu";
            
            
        }
        if (indexPath.row==3)
            
            
        {
            
            
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Deactivate Account"
                                         message:@"Are you sure,you want to deactivate your account"
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Yes"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
            NSString *savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
                                            if (!savedValue) {
                                                savedValue=@"";
                                            }
                                          
                                            
NSDictionary* dic=@{@"id_customer":savedValue,@"area":@"deactivate",@"mode":@""};
                        [helper myAccount :dic];
                                            
                                            
                                           
                                        }];
            
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:@"No"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           
    
                                           //Handle no, thanks button
                                       }];
            
            [alert addAction:yesButton];
            [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        if (indexPath.row==4)
        {
            
            NSString *valueToSave = @"";
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
            SWRevealViewController *revealController = self.revealViewController;
            HomeViewController*MyOrderVC=[[HomeViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MyOrderVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            
            
        }
        
    }
    else
    {
        NSString *backButtonHide = @"hide";
        [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SWRevealViewController *revealController = self.revealViewController;
        UIViewController *newFrontController = nil;
        newFrontController = [[MenuSubCategoriesViewController alloc] init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
        [revealController pushFrontViewController:navigationController animated:YES];
        [historyModel sharedhistoryModel].parentId=[[[historyModel sharedhistoryModel].rigthMenuArray objectAtIndex:indexPath.row]objectForKey:@"id_category"];
        [historyModel sharedhistoryModel].subcategoryName=[[[historyModel sharedhistoryModel].rigthMenuArray objectAtIndex:indexPath.row]objectForKey:@"name_category"];
        [historyModel sharedhistoryModel].rightORleftMenu=@"RightMenu";
        

    }

    
}


-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAccount"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               // NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                    //    stringForKey:@"preferenceName"];
             if ([[[info objectAtIndex:0] objectForKey:@"status"] intValue]==0)
             {
                 NSString *valueToSave = @"";
                 [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
                 SWRevealViewController *revealController = self.revealViewController;
                 HomeViewController*MyOrderVC=[[HomeViewController alloc] init];
                 UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MyOrderVC];
                 [revealController pushFrontViewController:navigationController animated:YES];
             }
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0] objectForKey:@"msg"] timeDalay:1.0];
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





@end
