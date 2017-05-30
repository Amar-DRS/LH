//
//  LeftMenuViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 7/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "LeftMenuViewController.h"

@interface LeftMenuViewController ()
{

    NSArray*dataArray;
    NSArray*imageArray;
    
}

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
   
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuImage"]];
    [self->_leftMenuTable setFrame:self->_leftMenuTable.frame];
    
    self->_leftMenuTable.backgroundView = tempImageView;
    self.leftMenuTable.delegate=self;
    self.leftMenuTable.dataSource=self;
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"TLH Press",@" BJU Press",@"AOP Press",@"Events",@"Bargain Bin",@"Publishers",@"About LEARNING HOUSE",@"Quick Contact",@"Create Account",@"Login",nil];
    //NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                           // stringForKey:@"preferenceName"];

    [self.leftMenuTable reloadData];
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"LeftMenuTableViewCell";
    LeftMenuTableViewCell *cell = (LeftMenuTableViewCell *)[self.leftMenuTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuTableViewCell" owner:self options:nil];
        cell = [cellArray objectAtIndex:0];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font=[UIFont systemFontOfSize:15.0];

    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    

    cell.textLabel.text=[dataArray objectAtIndex:indexPath.row];

    if (indexPath.row==0)
    {
        cell.textLabel.textColor = [UIColor colorWithRed:255/255.0 green:186/255.0 blue:0/255.0 alpha:1];
        
        
        
    }
    else if (indexPath.row==1)
    {
        cell.textLabel.textColor = [UIColor colorWithRed:1/255.0 green:147/255.0 blue:207/255.0 alpha:1];
       
    }
    else if (indexPath.row==2)
    {
        cell.textLabel.textColor = [UIColor colorWithRed:102/255.0 green:153/255.0 blue:52/255.0 alpha:1];
        
    }
    else if (indexPath.row==8)
    {
      NSString*  savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];

       // savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];

        if ([savedValue length]==0)
        {
            savedValue=@"";
        }

        if (![savedValue isEqualToString:@""])
        {
            cell.textLabel.text=@"My Account";

        
        }
        else
        {
        cell.textLabel.text=@"Create Account";
        }
        
    }
    else if (indexPath.row==9)
    {
       
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"preferenceName"];
        if ([savedValue length]==0)
        {
           savedValue=@"";
        }

        if (![savedValue isEqualToString:@""])
        {
            cell.textLabel.text=@"Logout";
            
            
        }
        else
        {
            cell.textLabel.text=@"Login";
        }


        
    }


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSString*  savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    if ([savedValue length]==0)
    {
        [historyModel sharedhistoryModel].myAccount=@"NotmyAccountVC";

    }
    else
    {
    if (indexPath.row==8) {
        [historyModel sharedhistoryModel].myAccount=@"myAccountVC";
        
    } else {
        [historyModel sharedhistoryModel].myAccount=@"NotmyAccountVC";
        
    }
    }
    
    if (indexPath.row==0)
    {
        
        NSString *backButtonHide = @"hide";
        [[NSUserDefaults standardUserDefaults] setObject:backButtonHide forKey:@"backButtonHideValue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SWRevealViewController *revealController = self.revealViewController;
        MenuSubCategoriesViewController*MenuSubCategoriesVC=[[MenuSubCategoriesViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        //MenuSubCategoriesVC.codeCatalog=@"TLH";
        [historyModel sharedhistoryModel].codeCatalog=@"TLH";
        MenuSubCategoriesVC.rightORleftMenu=@"leftMenu";
        [historyModel sharedhistoryModel].subcategoryName=@"TLH Press";

        
    }
    else if (indexPath.row==1)
        
    {
        
        SWRevealViewController *revealController = self.revealViewController;
        MenuSubCategoriesViewController*MenuSubCategoriesVC=[[MenuSubCategoriesViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        
        //[self.navigationController pushViewController:MenuSubCategoriesVC animated:YES];

       // MenuSubCategoriesVC.codeCatalog=@"BJU";
        [historyModel sharedhistoryModel].codeCatalog=@"BJU";
        [historyModel sharedhistoryModel].subcategoryName=@"BJU Press";

        MenuSubCategoriesVC.rightORleftMenu=@"leftMenu";

    }
    else if (indexPath.row==2)
    {
        SWRevealViewController *revealController = self.revealViewController;
        MenuSubCategoriesViewController*MenuSubCategoriesVC=[[MenuSubCategoriesViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MenuSubCategoriesVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        [historyModel sharedhistoryModel].codeCatalog=@"AO";
        [historyModel sharedhistoryModel].subcategoryName=@"AOP press";


        MenuSubCategoriesVC.rightORleftMenu=@"leftMenu";

    }
    else if (indexPath.row==3)
    {
        SWRevealViewController *revealController = self.revealViewController;
        EventsViewController*EventsVC=[[EventsViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:EventsVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        //MenuSubCategoriesVC.rightORleftMenu=@"leftMenu";
        
    }
    else if (indexPath.row==4)
    {
        SWRevealViewController *revealController = self.revealViewController;
        leftMenuSubCategoryViewController*leftMenuSubCategoryVC=[[leftMenuSubCategoryViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leftMenuSubCategoryVC];
        leftMenuSubCategoryVC.titleLab=@"Bargain Bin";
        [revealController pushFrontViewController:navigationController animated:YES];
        [historyModel sharedhistoryModel].codeCatalog=@"TLH";
        leftMenuSubCategoryVC.categoryId=@"34";
        leftMenuSubCategoryVC.rightORleftMenu=@"leftMenu";

        
    }
    else if (indexPath.row==5)
    {
        SWRevealViewController *revealController = self.revealViewController;
        PublishersViewController*PublishersViewVC=[[PublishersViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:PublishersViewVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        
    }
    else if (indexPath.row==6)
    {
        SWRevealViewController *revealController = self.revealViewController;
        AboutLearningHouse*AboutLearningHouseVC=[[AboutLearningHouse alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:AboutLearningHouseVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        [historyModel sharedhistoryModel].subcategoryName=@"About Learning House";
 
    }
    else if (indexPath.row==7)
    {
        SWRevealViewController *revealController = self.revealViewController;
        AboutLearningHouse*AboutLearningHouseVC=[[AboutLearningHouse alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:AboutLearningHouseVC];
        [revealController pushFrontViewController:navigationController animated:YES];
        AboutLearningHouseVC.aboutROcontect=@"contect";
        [historyModel sharedhistoryModel].subcategoryName=@"Contact Learning House";


    }
    
    else if (indexPath.row==8)
    {
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"preferenceName"];
        if ([savedValue length]==0)
        {
            savedValue=@"";
        }
        if (![savedValue isEqualToString:@""])
        {
            SWRevealViewController *revealController = self.revealViewController;
            MyAccountViewController*MyProfileVC=[[MyAccountViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:MyProfileVC];
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else
        {
            SWRevealViewController *revealController = self.revealViewController;
            RegisterViewController*leftMenuSubCategoryVC=[[RegisterViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:leftMenuSubCategoryVC];
            [revealController pushFrontViewController:navigationController animated:YES];

        }


        
    }
    else if (indexPath.row==9)
    {
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                stringForKey:@"preferenceName"];
        if ([savedValue length]==0)
        {
            savedValue=@"";
        }
        // NSString *CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
        if (![savedValue isEqualToString:@""])
        {
            NSString *valueToSave = @"";
            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"preferenceName"];
//            NSString *CookieCartID=@"";
//             [[NSUserDefaults standardUserDefaults] setObject:CookieCartID forKey:@"CookieCart"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            HomeViewController*HomeViewVC=[[HomeViewController alloc]init];
            SWRevealViewController *revealController = self.revealViewController;
           // LoginViewController*LoginViewVC=[[LoginViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:HomeViewVC];
            [revealController pushFrontViewController:navigationController animated:YES];        }
        else
        {
            SWRevealViewController *revealController = self.revealViewController;
            LoginViewController*LoginViewVC=[[LoginViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:LoginViewVC];
            [revealController pushFrontViewController:navigationController animated:YES];
            //leftMenuSubCategoryVC.rightORleftMenu=@"leftMenu";
            
            //leftMenuSubCategoryVC.aboutROcontect=@"contect";
            LoginViewVC.rightORleftMenu=@"leftMenu";
        
        }

 
        
    }


}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    //[headerView setBackgroundColor:[UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1]];
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(15,0,25,25)];
    dot.image=[UIImage imageNamed:@"phone"];
    //dot.backgroundColor=[UIColor redColor];
    UIImageView *dot1 =[[UIImageView alloc] initWithFrame:CGRectMake(158,0,25,20)];
    dot1.image=[UIImage imageNamed:@"flag-image"];
   // dot1.backgroundColor=[UIColor redColor];
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(50,0,300,20)];
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.font = [UIFont systemFontOfSize:15];
    
    tempLabel.text=@"866.875.5550";
    [headerView addSubview:tempLabel];
    [headerView addSubview:dot];
    [headerView addSubview:dot1];

    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.leftMenuTable reloadData];
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

@end
