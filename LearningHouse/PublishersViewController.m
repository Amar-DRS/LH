//
//  PublishersViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/17/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "PublishersViewController.h"

@interface PublishersViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary* dic;
    NSArray*info;
    BOOL IsSearch;
    NSString *searchTextString;
    NSArray*searchArray;
    NSMutableArray *ProductResArr;
    NSMutableArray *CategoryResArr;
    NSMutableArray *PublisherResArr;
}

@end

@implementation PublishersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"LH.sqlite"];

    ProductResArr = [[NSMutableArray alloc] init];
    CategoryResArr = [[NSMutableArray alloc] init];
    PublisherResArr = [[NSMutableArray alloc] init];
    
    self.navigationController.navigationBarHidden=YES;
    self.pubilisherTable.delegate=self;
    self.pubilisherTable.dataSource=self;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.searchTextField.delegate=self;
    [self.searchTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.searchTextField.leftView = paddingView;
    self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
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


    // Do any additional setup after loading the view from its nib.
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
    return 1; //one male and other female
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [PublisherResArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"InnerTableCell";
    InnerTableCell *cell = (InnerTableCell *)[self.pubilisherTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"InnerTableCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }

    
        cell.titleLab.text = [NSString stringWithFormat:@"  %@",[[PublisherResArr objectAtIndex:indexPath.row] objectAtIndex:1]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ViewAllViewController *detailViewController = [[ViewAllViewController alloc] initWithNibName:@"ViewAllViewController" bundle:nil];
    [self.navigationController pushViewController:detailViewController animated:NO];
   
     detailViewController.codeCategory=[[PublisherResArr objectAtIndex:indexPath.row] objectAtIndex:2];
     detailViewController.titleStr=[[PublisherResArr objectAtIndex:indexPath.row] objectAtIndex:1];
     detailViewController.menuClass=@"leftMenu";
     detailViewController.publisher=@"publisherList";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchTextField becomeFirstResponder];

    
}
NSMutableArray *arrSearch;

-(void)textFieldDidChange:(UITextField*)textField
{
    if ([self.searchTextField.text length]>2)
        {
             [PublisherResArr removeAllObjects];

            
            NSString *PublisherQuery =[NSString stringWithFormat:@"select PubID,PubName,PubCode FROM Publisher WHERE PubName like '%%%@%%' ORDER BY PubName COLLATE NOCASE",self.searchTextField.text];
            [PublisherResArr addObjectsFromArray:[self.dbManager loadDataFromDB:PublisherQuery]];
            NSLog(@"PublisherResArr>>%@",PublisherResArr);
            

            
            [self.pubilisherTable reloadData];
            self.pubilisherTable.hidden=NO;
        }

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)searchDoneAction
{
    
}

- (IBAction)backBtn:(id)sender {
    HomeViewController *HomeViewControllerVC=[[HomeViewController alloc]init];
    HomeViewControllerVC.menuString=@"BackLeft";
    [self.navigationController pushViewController:HomeViewControllerVC animated:NO];

}

-(void)ProductCatalog:(NSArray *)ProductArr
{
    if([ProductArr count]>0)
    {
        
        if([ProductArr count]>0)
        {
            for (NSInteger i=0; i<[ProductArr count]; i++) {
                
                NSString *query = [NSString stringWithFormat:@"insert or Replace into Products(ProdID,ProdName,ProdType) values( '%@','%@','%@')", [[ProductArr objectAtIndex:i] valueForKey:@"id"],[[ProductArr objectAtIndex:i] valueForKey:@"title"],[[ProductArr objectAtIndex:i] valueForKey:@"ptype"]];
               // NSLog(@"Created quiz query:%@",query);
                [self.dbManager executeQuery:query];
                
                
//                NSLog(@"loop Counter%ld",i);
//                // If the query was successfully executed then pop the view controller.
//                if (self.dbManager.affectedRows != 0) {
//                    NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//                    
//                }
//                else{
//                    NSLog(@"Could not execute the query.");
//                }
                
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
           // NSLog(@"Created quiz query:%@",query);
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
           // NSLog(@"Created quiz query:%@",query);
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


@end
