//
//  MenuSubCategoriesViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/1/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "MenuSubCategoriesViewController.h"
#import "leftMenuSubCategoryViewController.h"

@interface MenuSubCategoriesViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;

    
        NSDictionary*dic;
    NSDictionary*dataDic;
    NSArray*info;
    SWRevealViewController *revealController ;
        
    
}

@end

@implementation MenuSubCategoriesViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.subCategoryTable.delegate=self;
    self.subCategoryTable.dataSource=self;
    self.titleLab.text=[historyModel sharedhistoryModel].subcategoryName;

    self.navigationController.navigationBarHidden=YES;
    revealController = [self revealViewController];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {
    if ([[historyModel sharedhistoryModel].codeCatalog isEqualToString:@"TLH"])
    {
        dic=   @{@"code_catalog":@"TLH",@"id_parent":@"",@"area":@"category",@"mode":@"",};
    }
   else if ([[historyModel sharedhistoryModel].codeCatalog isEqualToString:@"BJU"])
    {
        dic=   @{@"code_catalog":@"BJU",@"id_parent":@"",@"area":@"category",@"mode":@"",};
    }

   else if ([[historyModel sharedhistoryModel].codeCatalog isEqualToString:@"AO"])
    {
        dic=   @{@"code_catalog":@"AO",@"id_parent":@"",@"area":@"category",@"mode":@"",};
    }
    }
    else
    {
   dic= @{@"code_catalog":@"",@"id_parent":[historyModel sharedhistoryModel].parentId,@"area":@"category",@"mode":@"",};
    }

    [self menuSubCategories:dic];
}

-(void)menuSubCategories:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [helper getSubMenuCategories:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"Fatch_SubCategories_info"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"Fatch_SubCategories_info--->,%@",info);

       if (info.count>0)
           
       {
            dispatch_async(dispatch_get_main_queue(), ^{
              

               [self.subCategoryTable reloadData];
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"Loaded" timeDalay:1.0];
               
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *CellIdentifier=@"SubCategoriesTableViewCell";
SubCategoriesTableViewCell *cell = (SubCategoriesTableViewCell *)[self.subCategoryTable dequeueReusableCellWithIdentifier:CellIdentifier];

if (cell == nil)
{
    NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SubCategoriesTableViewCell" owner:self options:nil];
    
    cell = [cellArray objectAtIndex:0];
}



    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {

   cell.subCategorylab.text = [NSString stringWithFormat:@"%@",[[info objectAtIndex:indexPath.row] objectForKey:@"name_category"]];
    }
    else if([[historyModel sharedhistoryModel].rightORleftMenu isEqualToString:@"RightMenu"])

    {
        cell.subCategorylab.text = [NSString stringWithFormat:@"%@ (%@)",[[info objectAtIndex:indexPath.row] objectForKey:@"name_category"],[[info objectAtIndex:indexPath.row] objectForKey:@"count"]];

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {
        
        leftMenuSubCategoryViewController*leftMenuSubCategoryVC=[[leftMenuSubCategoryViewController alloc ] init];
        [self.navigationController pushViewController:leftMenuSubCategoryVC animated:YES];
        leftMenuSubCategoryVC.titleLab=[[info objectAtIndex:indexPath.row] objectForKey:@"name_category"];
        leftMenuSubCategoryVC.categoryId=[[info objectAtIndex:indexPath.row] objectForKey:@"id_category"];
        
    
    }
    else if ([[historyModel sharedhistoryModel].rightORleftMenu isEqualToString:@"RightMenu"])
    {
    ViewAllViewController*ProductAllDetailVC=[[ViewAllViewController alloc]init];
    [self.navigationController pushViewController:ProductAllDetailVC animated:YES];
    ProductAllDetailVC.menuClass=@"RightMenuClass";
    ProductAllDetailVC.codeCategory=[[info objectAtIndex:indexPath.row] objectForKey:@"id_category"];
    
   ProductAllDetailVC.titleStr = [NSString stringWithFormat:@"%@",[[info objectAtIndex:indexPath.row] objectForKey:@"name_category"]];
    }
}

- (IBAction)backBtn:(id)sender
{
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {
        if ([self.viewAllRigthMenu isEqualToString:@"viewAll"])
        {
            HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
            HomeViewControllerVC.menuString=@"BackRigth";
            
            [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
            
            
        }
        else
        {


        HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
        HomeViewControllerVC.menuString=@"BackLeft";
        
        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
        }
        
    }
   else if ([[historyModel sharedhistoryModel].rightORleftMenu isEqualToString:@"RightMenu"])
   {
       HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
       HomeViewControllerVC.menuString=@"BackRigth";
       
       [self.navigationController pushViewController:HomeViewControllerVC animated:NO];
       

   }
   
    else
    {
      [self.backBtn addTarget:revealController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }

   
}
@end
