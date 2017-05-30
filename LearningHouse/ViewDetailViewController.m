//
//  ViewDetailViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "ViewDetailViewController.h"
#define FONT_SIZE 10.0f
#define CELL_CONTENT_WIDTH 77.0f
#define CELL_CONTENT_MARGIN 15.0f
@interface ViewDetailViewController ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    NSDictionary* dataDic;
    NSArray*info2;
    NSString*address2;
    orderCellTableViewCell *cell;
    float RowheightValue;
    CGRect viewFream;
    

}
@end

@implementation ViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderTable.delegate=self;
    self.orderTable.dataSource=self;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;

    
    //[self.landingScrollView setContentSize:CGSizeMake(320,1500)];
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1;
    self.view1.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.view2.layer.masksToBounds = YES;
    self.view2.layer.borderWidth = 1;
    self.view2.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.orderTable.layer.masksToBounds = YES;
    self.orderTable.layer.borderWidth = 1;
    self.orderTable.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.totalAmountDetailView.layer.masksToBounds = YES;
    self.totalAmountDetailView.layer.borderWidth = 1;
    self.totalAmountDetailView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.view1.hidden=YES;
    self.view2.hidden=YES;
    self.orderTable.hidden=YES;
    

    
    NSString* savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    if (!savedValue) {
        savedValue=@"";
    }
    if (!self.orderid) {
        self.orderid=@"";
    }
       dic=@{@"order_id":self.orderid,@"id_customer":savedValue,@"area":@"vieworder",@"mode":@"",};
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
 dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"myAccount"])
    {
        info = [dataDic objectForKey:@"info0"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.view1.hidden=NO;
                self.view2.hidden=NO;
                self.orderTable.hidden=NO;
            info2=[dataDic objectForKey:@"info2"];
                NSDictionary*addressData=[info2 objectAtIndex:0];
                
               NSDictionary* AddressData1=[MyCustomClass getValuesWithOutNull:addressData];

                self.billingAddressLab.text=[NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@",[AddressData1 objectForKey:@"BillName"],[AddressData1 objectForKey:@"BillAddress01"],[AddressData1 objectForKey:@"BillAddress02"],[AddressData1 objectForKey:@"BillCity"],[AddressData1 objectForKey:@"BillProvince"],[AddressData1 objectForKey:@"BillCountry"],[AddressData1 objectForKey:@"BillPostal"]];
                
                self.shippingaddressLab.text=[NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@",[AddressData1 objectForKey:@"ShipName"],[AddressData1 objectForKey:@"ShipAddress01"],[AddressData1 objectForKey:@"ShipAddress02"],[AddressData1 objectForKey:@"ShipCity"],[AddressData1 objectForKey:@"ShipProvince"],[AddressData1 objectForKey:@"ShipCountry"],[AddressData1 objectForKey:@"ShipPostal"]];
                
                
                self.billingAddressLab.numberOfLines = 0;
                [self.billingAddressLab sizeToFit];
                
                self.shippingaddressLab.numberOfLines = 0;
                [self.shippingaddressLab sizeToFit];
                
//                NSInteger count = [info count];
//                
//                //Set the height of the tableview
//                CGRect frame = self.orderTable.frame;
              //  NSInteger count = [info count];
                
                //Set the height of the tableview
                CGRect frame = self.orderTable.frame;
                int i;
                for (i=0;i<[info count]; i++) {
                    RowheightValue=RowheightValue+[self GetHeight:[[info objectAtIndex:i] objectForKey:@"Title"]];
                }
                frame.size.height=RowheightValue+40;
                [self.orderTable setFrame:frame];
                
                //frame.size.height = (count *65)+20;
                 [self.totalAmountDetailView setFrame:CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y,self.view1.frame.size.width,self.totalAmountDetailView.frame.size.height)];
                viewFream=CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y,self.view1.frame.size.width,self.view2.frame.size.height);

                
                //(self.orderTable.frame.size.height);
                [self.landingScrollView setContentSize:CGSizeMake(self.view.frame.origin.x,self.view1.frame.size.height+self.view2.frame.size.height+frame.size.height+30+self.totalAmountDetailView.frame.size.height)];
                //[self.orderTable setFrame:frame];
                [self priceDetail];
                [self.orderTable reloadData];
                
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:1.0];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self GetHeight:[[info objectAtIndex:indexPath.row] objectForKey:@"Title"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"orderCellTableViewCell";
    cell = (orderCellTableViewCell *)[self.orderTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"orderCellTableViewCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"OrderID"];
    cell.itemLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"Title"];
    cell.eachLab.text=[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row] objectForKey:@"Price"]];
    cell.qtyLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"Quantity"];
    cell.pticeLab.text=[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row] objectForKey:@"Total"]];
    NSArray* getProductType = [[[info objectAtIndex:indexPath.row] objectForKey:@"product_type"] componentsSeparatedByString: @"|"];
    getProductType = [getProductType sortedArrayUsingSelector: @selector(compare:)];
    
    NSLog(@"getProductType--->%@",getProductType);
    
    if (getProductType.count>0)
    {
        int counter;
        
        for(counter=0;counter<getProductType.count;counter++)
        {
            NSLog(@"counter value>>%d",counter);
            int ProdType;
            ProdType=[[getProductType objectAtIndex:counter] intValue];
            NSLog(@"counter value>>%d",counter);
            NSString *imaneName;
            switch (ProdType) {
                    
                case 1:
                    imaneName=@"hard-book";
                    break;
                case 2:
                    imaneName=@"ebook";
                    break;
                case 3:
                    imaneName=@"mp3";
                    break;
                case 4:
                    imaneName=@"compact-disc";
                    break;
                default:
                    break;
            }
            
            switch (counter) {
                case 0:
                    cell.hardBook.image=[UIImage imageNamed:imaneName];
                    break;
                case 1:
                    cell.eBook.image=[UIImage imageNamed:imaneName];
                    break;
                case 2:
                    cell.mp3.image=[UIImage imageNamed:imaneName];
                    break;
                case 3:
                    cell.disk.image=[UIImage imageNamed:imaneName];
                    break;
                default:
                    break;
            }
        }
        
    }

    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width,80)];
    [headerView setBackgroundColor:[UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1]];
    
    
    UILabel *orderLab=[[UILabel alloc]initWithFrame:CGRectMake(cell.orderLab.frame.origin.x+7,12,55,15)];
    orderLab.textAlignment=NSTextAlignmentLeft;

    orderLab.textColor = [UIColor whiteColor];
    orderLab.font = [UIFont systemFontOfSize:9];
    
    UILabel *itemLab=[[UILabel alloc]initWithFrame:CGRectMake(cell.itemLab.frame.origin.x+10,12,55,15)];
    itemLab.textAlignment=NSTextAlignmentCenter;
    itemLab.textColor = [UIColor whiteColor];
    itemLab.font = [UIFont systemFontOfSize:9];
    
    
    UILabel *eachLab=[[UILabel alloc]initWithFrame:CGRectMake(cell.eachLab.frame.origin.x+23,12,55,15)];
    eachLab.textColor = [UIColor whiteColor];
    eachLab.font = [UIFont systemFontOfSize:9];
    
    
    UILabel *qtyLab=[[UILabel alloc]initWithFrame:CGRectMake(cell.qtyLab.frame.origin.x+11,12,55,15)];
    qtyLab.textColor = [UIColor whiteColor];
    qtyLab.font = [UIFont systemFontOfSize:9];
    
    
    UILabel *priceLab=[[UILabel alloc]initWithFrame:CGRectMake(cell.pticeLab.frame.origin.x+18,12,55,15)];
    priceLab.textColor = [UIColor whiteColor];
    priceLab.font = [UIFont systemFontOfSize:9];
    
    
    orderLab.text=@"ORDER";
    itemLab.text=@"ITEM";
    eachLab.text=@"EACH";
    qtyLab.text=@"QTY";
    priceLab.text=@"PRICE";
    
    
    [headerView addSubview:orderLab];
    [headerView addSubview:itemLab];
    [headerView addSubview:eachLab];
    [headerView addSubview:qtyLab];
    [headerView addSubview:priceLab];
    return headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)priceDetail
{
    
    UILabel*itemLabName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,12,100,15)];
    itemLabName.textColor = [UIColor darkGrayColor];
    itemLabName.font = [UIFont systemFontOfSize:13];
    itemLabName.text=@"Sub-Total";
    itemLabName.textAlignment = NSTextAlignmentCenter;
    UILabel*eachLabName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,30,100,15)];
    eachLabName.textColor = [UIColor darkGrayColor];
    eachLabName.font = [UIFont systemFontOfSize:13];
    eachLabName.text=@"Shipping";
    eachLabName.textAlignment = NSTextAlignmentCenter;
    UILabel*qtyLabName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,50,100,15)];
    qtyLabName.textColor = [UIColor darkGrayColor];
    qtyLabName.font = [UIFont systemFontOfSize:13];
    qtyLabName.text=@"GST";
    qtyLabName.textAlignment = NSTextAlignmentCenter;
    UILabel*priceLabName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,70,100,15)];
    priceLabName.textColor = [UIColor darkGrayColor];
    priceLabName.font = [UIFont systemFontOfSize:13];
    priceLabName.text=@"HST";
    priceLabName.textAlignment = NSTextAlignmentCenter;
    
    UILabel*totalName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,100,100,15)];
    totalName.textColor = [UIColor orangeColor];
    totalName.font = [UIFont systemFontOfSize:13];
    totalName.text=@"Total";
    totalName.textAlignment = NSTextAlignmentCenter;
    
    

        UILabel *itemLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,12,85,15)];
        itemLab.textColor = [UIColor darkGrayColor];
        itemLab.font = [UIFont systemFontOfSize:13];
    
    
        UILabel *eachLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,30,85,15)];
        eachLab.textColor = [UIColor darkGrayColor];
        eachLab.font = [UIFont systemFontOfSize:13];
    
    
        UILabel *qtyLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,50,85,15)];
        qtyLab.textColor = [UIColor darkGrayColor];
        qtyLab.font = [UIFont systemFontOfSize:13];
    
    
        UILabel *priceLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,70,85,15)];
        priceLab.textColor = [UIColor darkGrayColor];
        priceLab.font = [UIFont systemFontOfSize:13];
    
        UILabel *total=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,100,85,15)];
        total.textColor = [UIColor orangeColor];
        total.font = [UIFont systemFontOfSize:13];
  
    
    
    
        itemLab.text=[NSString stringWithFormat:@"$%@",[[info2 objectAtIndex:0] objectForKey:@"SubTotal"]];
    
        eachLab.text=[NSString stringWithFormat:@"$%@",[[info2 objectAtIndex:0] objectForKey:@"Shipping"]];
    
        qtyLab.text=[NSString stringWithFormat:@"$%@",[[info2 objectAtIndex:0] objectForKey:@"GST"]];
    
        priceLab.text=[NSString stringWithFormat:@"$%@",[[info2 objectAtIndex:0] objectForKey:@"HST"]];
        total.text=[NSString stringWithFormat:@"$%@",[[info2 objectAtIndex:0] objectForKey:@"Total"]];
    
    itemLab.textAlignment = NSTextAlignmentRight;
    eachLab.textAlignment = NSTextAlignmentRight;
    qtyLab.textAlignment = NSTextAlignmentRight;
    priceLab.textAlignment = NSTextAlignmentRight;
    total.textAlignment = NSTextAlignmentRight;


        [self.totalAmountDetailView addSubview:itemLab];
        [self.totalAmountDetailView addSubview:eachLab];
        [self.totalAmountDetailView addSubview:qtyLab];
        [self.totalAmountDetailView addSubview:priceLab];
        [self.totalAmountDetailView addSubview:total];
    
    [self.totalAmountDetailView addSubview:itemLabName];
    [self.totalAmountDetailView addSubview:eachLabName];
    [self.totalAmountDetailView addSubview:qtyLabName];
    [self.totalAmountDetailView addSubview:priceLabName];
    [self.totalAmountDetailView addSubview:totalName];
}
-(CGFloat)GetHeight:(NSString*)text
{
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint ];
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
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
    [self.navigationController popViewControllerAnimated:NO];
}
@end
