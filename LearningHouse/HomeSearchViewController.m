
//
//  HomeSearchViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/23/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "HomeSearchViewController.h"

@interface HomeSearchViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary* dic;
    NSArray*info;
    NSMutableArray *ProductResArr;
    NSMutableArray *CategoryResArr;
    NSMutableArray *PublisherResArr;


}

@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"LH.sqlite"];
    ProductResArr = [[NSMutableArray alloc] init];
    CategoryResArr = [[NSMutableArray alloc] init];
    PublisherResArr = [[NSMutableArray alloc] init];

    
    
    self.searchTable.delegate=self;
    self.searchTable.dataSource=self;
    self.searchTable.contentInset=UIEdgeInsetsMake(-10.0, 0, 0, 0);
    self.searchTextField.delegate=self;
    [self.searchTextField addTarget:self
                             action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged];
    UIColor *borderColor = [UIColor colorWithRed:25/255.0 green:54/255.0 blue:88/255.0 alpha:1];
    [self.headerColour.layer setBorderColor:borderColor.CGColor];
    [self.headerColour.layer setBorderWidth:3.0];

    self.searchTable.hidden=YES;
     UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
     self.searchTextField.leftView = paddingView;
     self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    if([GETVALUE(FirstTime)  isEqualToString:@"Completed"])
    {
       NSInteger HourDifferenc= [MyCustomClass getHoursDifference:[NSDate date] FromDate: GETVALUE(SyncDate)];
        if(HourDifferenc >=6)
        {
        NSString *LastSyncDate =[MyCustomClass setDateFormateWithDate:GETVALUE(SyncDate) dateFormate:@"YYYY-MM-dd HH:mm:ss"];
        dic=@{@"date_edited":LastSyncDate,@"mode":@"data_dump"};
        [self ShowCartData1:dic];
        }
    }
    else
    {
        dic=@{@"date_edited":@"2012-12-14",@"mode":@"data_dump"};
        [self ShowCartData1:dic];
    }

}
-(void)textFieldDidChange:(UITextField*)textField
{
    
    [ProductResArr removeAllObjects];
    [CategoryResArr removeAllObjects];
    [PublisherResArr removeAllObjects];
    if ([self.searchTextField.text length]>2)
    {
       
        
        NSString *ProductQuery = [NSString stringWithFormat:@"select ProdID,ProdName,ProdType FROM Products WHERE ProdName like '%%%@%%'  ORDER BY ProdName COLLATE NOCASE",self.searchTextField.text];
        [ProductResArr addObjectsFromArray:[self.dbManager loadDataFromDB:ProductQuery]];
        NSLog(@"ProductResultArr>>%@",ProductResArr);
        
        NSString *PublisherQuery =[NSString stringWithFormat:@"select PubID,PubName,PubCode FROM Publisher WHERE PubName like '%%%@%%'  ORDER BY PubName COLLATE NOCASE",self.searchTextField.text];
        [PublisherResArr addObjectsFromArray:[self.dbManager loadDataFromDB:PublisherQuery]];
        NSLog(@"PublisherResArr>>%@",PublisherResArr);
        
        NSString *CategoryQuery =[NSString stringWithFormat:@"select CatID,CatName,CatCode FROM Category WHERE CatName like '%%%@%%'  ORDER BY CatName COLLATE NOCASE",self.searchTextField.text];
        [CategoryResArr addObjectsFromArray:[self.dbManager loadDataFromDB:CategoryQuery]];
        NSLog(@"CategoryResArr>>%@",CategoryResArr);
        
        [self.searchTable reloadData];
        self.searchTable.hidden=NO;
    }
    else
        
    {
    
        [self.searchTable reloadData];
        self.searchTable.hidden=YES;
    }
    
}
-(void)ShowCartData1:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper Dump_Data:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"DumpData"])
    {
        NSArray *CategoryArr,*PublisherArr,*ProductArr;
        ProductArr = [dataDic objectForKey:@"CatalogProduct"];
        PublisherArr = [dataDic objectForKey:@"publisher"];
        CategoryArr = [dataDic objectForKey:@"category"];
        
        [self ProductCatalog:ProductArr];
        [self CategoryCatalog:CategoryArr];
        [self PublisherCatalog:PublisherArr];
       
        if (ProductArr.count>0||PublisherArr.count>0||CategoryArr.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                SETVALUE(@"Completed", FirstTime);
                SETVALUE([NSDate date], SyncDate); // Save date
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"Success" timeDalay:1.0];
            });
        }
        else
        {
            [MyCustomClass SVProgressMessageDismissWithError:@"Error" timeDalay:1.0];
        }
    }
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
  if (section==0)
  {
  count=[PublisherResArr count ];
  }
  if (section==1)
  {
    
  count=[ProductResArr count ];
  }
  if(section==2)
  {
  count=[CategoryResArr count ];
  }
    return count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];

    
    if (indexPath.section==0)
    {

        cell.textLabel.text = [[PublisherResArr objectAtIndex:indexPath.row] objectAtIndex:1];
    }
    if (indexPath.section==1)
    {
        
        cell.textLabel.text = [[ProductResArr objectAtIndex:indexPath.row] objectAtIndex:1];
    }
    if (indexPath.section==2)
    {
        cell.textLabel.text = [[CategoryResArr objectAtIndex:indexPath.row] objectAtIndex:1];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.textAlignment = UITextAlignmentCenter;
   // lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    lbl.textColor = [UIColor whiteColor];
    [lbl setFont:[UIFont fontWithName:@"System" size:18]];

    lbl.backgroundColor=[UIColor colorWithRed:25/255.0 green:54/255.0 blue:88/255.0 alpha:1];
    if (section==0)
        lbl.text=@"Publisher";
    if (section==1)
        lbl.text=@"Product";
    if (section==2)
        lbl.text=@"Category";
    return lbl;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.section==0)
    {
        ViewAllViewController *ViewAllVC = [[ViewAllViewController alloc] initWithNibName:@"ViewAllViewController" bundle:nil];
        [self.navigationController pushViewController:ViewAllVC animated:NO];
        
        ViewAllVC.codeCategory=[[PublisherResArr objectAtIndex:indexPath.row] objectAtIndex:2];
        ViewAllVC.titleStr=[[PublisherResArr objectAtIndex:indexPath.row] objectAtIndex:1];
        
//        ViewAllVC.codeCategory=[[[[info objectAtIndex:0] objectForKey:@"aPublisher_ListResult"] objectAtIndex:indexPath.row] objectForKey:@"code_publisher"];
//        ViewAllVC.titleStr=[[[[info objectAtIndex:0] objectForKey:@"aPublisher_ListResult"] objectAtIndex:indexPath.row] objectForKey:@"publisher"];
        ViewAllVC.publisher=@"HomeSearch";
    }
    if (indexPath.section==1)
    {
        ProductAllDetailViewController *ViewAllVC = [[ProductAllDetailViewController alloc] initWithNibName:@"ProductAllDetailViewController" bundle:nil];
        [self.navigationController pushViewController:ViewAllVC animated:NO];
      
        ViewAllVC.productId=[[ProductResArr objectAtIndex:indexPath.row] objectAtIndex:0];
        
       // ViewAllVC.productId=[[[[info objectAtIndex:0] objectForKey:@"aProduct_ListResult"] objectAtIndex:indexPath.row] objectForKey:@"id"];

    }
    if (indexPath.section==2)
    {
        MenuSubCategoriesViewController *ViewAllVC = [[MenuSubCategoriesViewController alloc] initWithNibName:@"MenuSubCategoriesViewController" bundle:nil];
        [self.navigationController pushViewController:ViewAllVC animated:NO];
        [historyModel sharedhistoryModel].parentId=[[CategoryResArr objectAtIndex:indexPath.row] objectAtIndex:0];
        [historyModel sharedhistoryModel].subcategoryName=[[CategoryResArr objectAtIndex:indexPath.row] objectAtIndex:1];
        [historyModel sharedhistoryModel].rightORleftMenu=@"RightMenu";
        
        
//        [historyModel sharedhistoryModel].parentId=[[[[info objectAtIndex:0] objectForKey:@"aCategory_ListResult"] objectAtIndex:indexPath.row] objectForKey:@"id"];
//        [historyModel sharedhistoryModel].subcategoryName=[[[[info objectAtIndex:0] objectForKey:@"aCategory_ListResult"] objectAtIndex:indexPath.row] objectForKey:@"name_category"];
    

    }
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
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
-(void)ProductCatalog:(NSArray *)ProductArr
{
if([ProductArr count]>0)
{

    if([ProductArr count]>0)
    {
        for (NSInteger i=0; i<[ProductArr count]; i++) {
            
            NSString *query = [NSString stringWithFormat:@"insert or Replace into Products(ProdID,ProdName,ProdType) values( '%@','%@','%@')", [[ProductArr objectAtIndex:i] valueForKey:@"id"],[[ProductArr objectAtIndex:i] valueForKey:@"title"],[[ProductArr objectAtIndex:i] valueForKey:@"ptype"]];
          //  NSLog(@"Created Products query:%@",query);
            [self.dbManager executeQuery:query];
            
//            
//            NSLog(@"loop Counter%ld",i);
//            // If the query was successfully executed then pop the view controller.
//            if (self.dbManager.affectedRows != 0) {
//                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//         
//            }
//            else{
//                NSLog(@"Could not execute the query.");
//            }
            
        }
        
    }
    
}

}

-(void)CategoryCatalog:(NSArray *)CategoryArr
{
    if([CategoryArr count]>0)
    {
        for (NSInteger i=0; i<[CategoryArr count]; i++) {
            
            NSString *query = [NSString stringWithFormat:@"insert or Replace into Category(CatID,CatName,CatCode) values( '%@','%@','%@')", [[CategoryArr objectAtIndex:i] valueForKey:@"id"],
                               [[CategoryArr objectAtIndex:i] valueForKey:@"name_category"],
                               [[CategoryArr objectAtIndex:i] valueForKey:@"code_catalog"]];
          //  NSLog(@"Created Category query:%@",query);
            [self.dbManager executeQuery:query];
            
            
//            NSLog(@"loop Counter%ld",i);
//
//            // If the query was successfully executed then pop the view controller.
//            if (self.dbManager.affectedRows != 0) {
//                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//  
//            }
//            else{
//                NSLog(@"Could not execute the query.");
//            }
            
        }
        
    }
}


-(void)PublisherCatalog:(NSArray *)PublisherArr
{
    if([PublisherArr count]>0)
    {
        for (NSInteger i=0; i<[PublisherArr count]; i++) {
   
        NSString *query = [NSString stringWithFormat:@"insert or Replace into Publisher(PubID,PubName,PubCode) values( '%@','%@','%@')", [[PublisherArr objectAtIndex:i] valueForKey:@"id"],[[PublisherArr objectAtIndex:i] valueForKey:@"publisher"],[[PublisherArr objectAtIndex:i] valueForKey:@"code_publisher"]];
      //  NSLog(@"Created Publisher query:%@",query);
        [self.dbManager executeQuery:query];
        
        
//            NSLog(@"loop Counter%ld",i);
//
//        // If the query was successfully executed then pop the view controller.
//        if (self.dbManager.affectedRows != 0) {
//            NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//     
//        }
//        else{
//            NSLog(@"Could not execute the query.");
//        }

        }
    
    }
    
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}
@end
