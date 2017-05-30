//
//  leftMenuSubCategoryViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/1/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "leftMenuSubCategoryViewController.h"
#import "ViewAllViewController.h"

@interface leftMenuSubCategoryViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    
    
    NSDictionary*dic;
    NSDictionary*dataDic;
    NSArray*info;
    SWRevealViewController *revealController ;

}

@end

@implementation leftMenuSubCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    self.leftSubCategoryTable.delegate=self;
    self.SubCategorytitle.text=self.titleLab;
    self.leftSubCategoryTable.dataSource=self;
    revealController = [self revealViewController];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    
    if (![historyModel sharedhistoryModel].codeCatalog) {
        [historyModel sharedhistoryModel].codeCatalog=@"";
    }
    if (!self.categoryId) {
        self.categoryId=@"";
    }
dic=   @{@"code_catalog":[historyModel sharedhistoryModel].codeCatalog,@"id_parent":self.categoryId,@"area":@"category",@"mode":@"",};
    [self menuSubCategories:dic];

    // Do any additional setup after loading the view from its nib.
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
                
                
                [self.leftSubCategoryTable reloadData];
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
    SubCategoriesTableViewCell *cell = (SubCategoriesTableViewCell *)[self.leftSubCategoryTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SubCategoriesTableViewCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }
    
    
    
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    
    cell.subCategorylab.text = [NSString stringWithFormat:@"%@ (%@)",[[info objectAtIndex:indexPath.row] objectForKey:@"name_category"],[[info objectAtIndex:indexPath.row] objectForKey:@"count"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ViewAllViewController*ViewAllVC=[[ViewAllViewController alloc]init];
    [self.navigationController pushViewController:ViewAllVC animated:YES];
    ViewAllVC.menuClass=@"leftMenu";
    ViewAllVC.codeCategory=[[info objectAtIndex:indexPath.row] objectForKey:@"id_category"];
   ViewAllVC.titleStr=[NSString stringWithFormat:@"%@",[[info objectAtIndex:indexPath.row] objectForKey:@"name_category"]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backBtn:(id)sender
{
    if ([self.rightORleftMenu isEqualToString:@"leftMenu"])
    {

        HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
        HomeViewControllerVC.menuString=@"BackLeft";
        
        [self.navigationController pushViewController:HomeViewControllerVC animated:NO];

    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];

    }
   
}
@end
