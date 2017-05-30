//
//  MyOrder.m
//  LearningHouse
//
//  Created by Alok Singh on 8/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "MyOrder.h"

@interface MyOrder ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;

}

@end

@implementation MyOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.myorderTable.delegate=self;
    self.myorderTable.dataSource=self;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    NSString* savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    if (!savedValue) {
        savedValue=@"";
    }
   

    dic=@{@"id_customer":savedValue,@"area":@"orders",@"mode":@"",};
    [self orderDetail:dic];
    // Do any additional setup after loading the view from its nib.
}
-(void)orderDetail:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper myAccount:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
   NSDictionary* dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAccount"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myorderTable reloadData];
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:1.0];
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:2.0];
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"MyorderCellTableViewCell";
    MyorderCellTableViewCell *cell = (MyorderCellTableViewCell *)[self.myorderTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"MyorderCellTableViewCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dateLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"date_added"];//[[info objectAtIndex:0]objectForKey:@"OrderNo"];
    cell.priceLab.text=[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row] objectForKey:@"thisOrderTotal"]];
    [cell.viewAllBtn setTitle:@"View\nDetail" forState:UIControlStateNormal];
    cell.viewAllBtn.titleLabel.numberOfLines = 2;//if you want unlimited number of lines put 0
    cell.viewAllBtn.tag=indexPath.row;
    [cell.viewAllBtn addTarget: self
              action: @selector(buttonClicked:)
    forControlEvents: UIControlEventTouchUpInside];

    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width,80)];
    [headerView setBackgroundColor:[UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1]];
    UILabel *orderLab=[[UILabel alloc]initWithFrame:CGRectMake(60,20,55,15)];
    orderLab.textColor = [UIColor whiteColor];
    orderLab.font = [UIFont systemFontOfSize:15];
    
    UILabel *itemLab=[[UILabel alloc]initWithFrame:CGRectMake(180,20,80,15)];
    itemLab.textColor = [UIColor whiteColor];
    itemLab.font = [UIFont systemFontOfSize:15];

//    
//    
    orderLab.text=@"Date";
    itemLab.text=@"Amount";
  
    [headerView addSubview:orderLab];
    [headerView addSubview:itemLab];

    return headerView;
    
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
-(void)buttonClicked:(id)sender
{
    ViewDetailViewController *OrderDetailsVC=[[ViewDetailViewController alloc]init];
    [self.navigationController pushViewController:OrderDetailsVC animated:NO];
    OrderDetailsVC.isViewDetai=@"ViewDetail";
    OrderDetailsVC.orderid=[[info objectAtIndex:[sender tag]] objectForKey:@"orderid"];
}

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
@end
