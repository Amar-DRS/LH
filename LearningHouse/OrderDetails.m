//
//  OrderDetails.m
//  LearningHouse
//
//  Created by Alok Singh on 8/22/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "OrderDetails.h"

#define FONT_SIZE 10.0f
#define CELL_CONTENT_WIDTH 77.0f
#define CELL_CONTENT_MARGIN 15.0f
@interface OrderDetails ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray*info;
    NSDictionary*dic;
    NSString*savedValue;
    int ProdType;
    NSInteger counter ;
    int imagecounter;
    NSMutableDictionary*dataDic;
    UILabel *itemLab;
    UILabel *eachLab;
    UILabel *qtyLab;
    UILabel *priceLab;
    UILabel *total;
    float RowheightValue;
    orderCellTableViewCell *cell;
    NSString*coupon;
    CGRect frame;
    CGRect viewFream;
}

@end

@implementation OrderDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    RowheightValue=0.0f;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.orderTable.delegate=self;
    self.orderTable.dataSource=self;
    self.couponCodeTxt.delegate=self;
    dataDic =[[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.landingScrollView.delegate=self;
    [self.landingScrollView setContentSize:CGSizeMake(320,1500)];
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.borderWidth = 1;
    self.view1.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.view2.layer.masksToBounds = YES;
    self.view2.layer.borderWidth = 1;
    self.view2.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.view3.layer.masksToBounds = YES;
    self.view3.layer.borderWidth = 1;
    self.view3.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.detailView.layer.masksToBounds = YES;
    self.detailView.layer.borderWidth = 1;
    self.detailView.layer.borderColor = [[UIColor blackColor] CGColor];
    
     UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
     self.couponCodeTxt.leftView = paddingView;
     self.couponCodeTxt.leftViewMode = UITextFieldViewModeAlways;
    self.orderTable.tableFooterView.hidden = YES;

    
    /* NSString*str=@"By clicking &quot;Continue&quot; below you will confirm that all billing, shipping and contact information is correct. You will be forwarded to a secure server area where you will be prompted for your credit card information in order that we may complete your transaction.";
    
    */
    NSString*str=@"By clicking \"Continue\" below you will confirm that all billing, shipping and contact information is correct. You will be forwarded to a secure server area where you will be prompted for your credit card information in order that we may complete your transaction.";
    self.titleLab.text=[NSString stringWithFormat:@"%@",str];
    
//    self.titleLab.layer.masksToBounds = YES;
//    self.titleLab.layer.borderWidth = 1;
//    self.titleLab.layer.borderColor = [[UIColor blackColor] CGColor];
  
    
    self.orderTable.layer.masksToBounds = YES;
    self.orderTable.layer.borderWidth = 1;
    self.orderTable.layer.borderColor = [[UIColor blackColor] CGColor];
    
        //[historyModel sharedhistoryModel].orderDetailArray
    self.contectPhone.text=[NSString stringWithFormat:@" Phone:%@",[historyModel sharedhistoryModel].mobile_no];
    self.contectEmail.text=[NSString stringWithFormat:@" Email:%@",[historyModel sharedhistoryModel].customer_email];
    self.contectMe.text=[NSString stringWithFormat:@" The best time to contect me is:%@",[historyModel sharedhistoryModel].contact_me];
    
    
    self.billingName.text=[NSString stringWithFormat:@" Name:%@",[historyModel sharedhistoryModel].name_customer];
     self.billinAddress1.text=[NSString stringWithFormat:@" Address1:%@",[historyModel sharedhistoryModel].address];
     self.billinAddress2.text=[NSString stringWithFormat:@" Address2:%@",[historyModel sharedhistoryModel].address1];
     self.billincity.text=[NSString stringWithFormat:@" City:%@",[historyModel sharedhistoryModel].city];
     self.billinState.text=[NSString stringWithFormat:@" Province:%@ %@ %@",[historyModel sharedhistoryModel].Province,[historyModel sharedhistoryModel].Country,[historyModel sharedhistoryModel].postcode];
    
    self.shippingName.text=[NSString stringWithFormat:@" Name:%@",[historyModel sharedhistoryModel].shipping_name_customer];
    self.shippingAddress1.text=[NSString stringWithFormat:@" Address1:%@",[historyModel sharedhistoryModel].shipping_address];
    self.shippingAddress2.text=[NSString stringWithFormat:@" Address2:%@",[historyModel sharedhistoryModel].shipping_address1];
    self.shippingCity.text=[NSString stringWithFormat:@" City:%@",[historyModel sharedhistoryModel].shipping_city];
    self.shippingState.text=[NSString stringWithFormat:@" Province:%@ %@ %@",[historyModel sharedhistoryModel].shipping_Province,[historyModel sharedhistoryModel].shipping_Country,[historyModel sharedhistoryModel].shipping_postcode];
    

    
    savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
         NSString *CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
   // dic=@{@"id_customer":savedValue,@"area":@"account",@"mode":@""};shipping_Country
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }

    dic=@{@"CookieCart":CookieCartID,@"ShipCountry":[historyModel sharedhistoryModel].shipping_Country,@"ShipProvince":@"ON",@"id_customer":savedValue,@"area":@"orders",@"mode":@""};
    [self orderDetail:dic];


}

-(void)orderDetail:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper orderDetail:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSString*result =  [[NSString alloc] initWithData:responseDictionary encoding:NSUTF8StringEncoding];

    NSLog(@"Result = %@",result);
    dataDic=[[MyCustomClass dictionaryFromJSON:responseDictionary] mutableCopy];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"orderDetail"])
    {
        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //Set the height of the tableview
                
                if (![coupon isEqualToString:@"coupon"])
                {
                     frame = self.orderTable.frame;
                    int i;
                    for (i=0;i<[info count]; i++) {
                        RowheightValue=RowheightValue+[self GetHeight:[[info objectAtIndex:i] objectForKey:@"Title"]];
                    }
                    frame.size.height=RowheightValue+40;
                    [self.orderTable setFrame:frame];
                }
               
              //  frame.size.height = (count *75)+10;//+(self.orderTable.frame.size.height);
               // self.couponCodeTxt=CGRectMake(0,9,self.couponCodeTxt.frame.size.width,self.couponCodeTxt.frame.size.height)];
                
                [self.detailView setFrame:CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y,self.detailView.frame.size.width,self.detailView.frame.size.height)];
                viewFream=CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y,self.detailView.frame.size.width,self.detailView.frame.size.height);
               [self.couponCodeTxt setFrame:CGRectMake(10,frame.size.height+self.orderTable.frame.origin.y+10+self.detailView.frame.size.height,self.couponCodeTxt.frame.size.width,self.couponCodeTxt.frame.size.height)];
                 [self.applyCouponBtn setFrame:CGRectMake(self.couponCodeTxt.frame.size.width+20,frame.size.height+self.orderTable.frame.origin.y+10+self.detailView.frame.size.height,self.applyCouponBtn.frame.size.width,self.applyCouponBtn.frame.size.height)];
                 [self.titleLab setFrame:CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y+10+self.applyCouponBtn.frame.size.height+10+self.detailView.frame.size.height,self.titleLab.frame.size.width,self.titleLab.frame.size.height)];
                 [self.continueBtn setFrame:CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y+10+self.applyCouponBtn.frame.size.height+10+self.titleLab.frame.size.height+10+self.detailView.frame.size.height,self.continueBtn.frame.size.width,self.continueBtn.frame.size.height)];
                 [self.editOrder setFrame:CGRectMake(163,frame.size.height+self.orderTable.frame.origin.y+10+self.applyCouponBtn.frame.size.height+10+self.titleLab.frame.size.height+10+self.detailView.frame.size.height,self.editOrder.frame.size.width,self.editOrder.frame.size.height)];
                 [self.continueEditBackground setFrame:CGRectMake(8,frame.size.height+self.orderTable.frame.origin.y+10+self.applyCouponBtn.frame.size.height+10+self.titleLab.frame.size.height+10+self.detailView.frame.size.height,self.continueEditBackground.frame.size.width,self.continueEditBackground.frame.size.height)];
             
                [self.landingScrollView setContentSize:CGSizeMake(320,self.detailView.frame.size.height+self.view1.frame.size.height+self.view2.frame.size.height+frame.size.height+self.view3.frame.size.height+300+self.couponCodeTxt.frame.size.height+self.titleLab.frame.size.height+self.continueBtn.frame.size.height)];
                
               // [[info objectAtIndex:indexPath.row] objectForKey:@"Title"]
                
                //CGRect frame1 = self.orderTable.tableFooterView.frame;
//                frame.size.height = 3;
//                UIView *headerView = [[UIView alloc] initWithFrame:frame1];
//                [self.orderTable setTableFooterView:headerView];
                [self.orderTable reloadData];
                [self priceDetail];


        [MyCustomClass SVProgressMessageDismissWithSuccess:@"" timeDalay:1.0];
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:2.0];
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [info count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return [self GetHeight:[[info objectAtIndex:indexPath.row] objectForKey:@"Title"]];
   // return 70;
}

-(CGFloat)GetHeight:(NSString*)text
{

    //NSString *text = [[info objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint ];
     CGFloat height = MAX(size.height, 44.0f);
   // CGFloat height = size.height;
    
    return height + (CELL_CONTENT_MARGIN * 2);
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
    cell.orderLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"OrderNo"];
    cell.itemLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"Title"];
    [cell.itemLab sizeToFit];
    cell.itemLab.numberOfLines=0;
    
    CGRect frameItem = cell.itemLab.frame;
    frameItem.origin.y=cell.center.y-frameItem.size.height/2;//pass the cordinate which you want
    cell.itemLab.frame= frameItem;
  

    cell.eachLab.text=[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row] objectForKey:@"CdnPrice"]];
    cell.qtyLab.text=[[info objectAtIndex:indexPath.row] objectForKey:@"ItemQty"];
    cell.pticeLab.text=[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row] objectForKey:@"lineTotal"]];
   //[cell.pticeLab sizeToFit];
    
    
    NSArray* getProductType = [[[info objectAtIndex:indexPath.row] objectForKey:@"product_type"] componentsSeparatedByString: @"|"];
    getProductType = [getProductType sortedArrayUsingSelector: @selector(compare:)];
    
    NSLog(@"getProductType--->%@",getProductType);
    
    if (getProductType.count>0)
    {
        //int counter;
        
        for(counter=0;counter<getProductType.count;counter++)
        {
            NSLog(@"counter value>>%ld",(long)counter);
           // int ProdType;
            ProdType=[[getProductType objectAtIndex:counter] intValue];
            NSLog(@"counter value>>%ld",(long)counter);
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
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width,100)];
    [headerView setBackgroundColor:[UIColor colorWithRed:26/255.0 green:38/255.0 blue:71/255.0 alpha:1]];
    
    UILabel *orderLab=[[UILabel alloc]initWithFrame:CGRectMake(cell.orderLab.frame.origin.x+7,12,55,15)];
    orderLab.textAlignment=NSTextAlignmentLeft;

    orderLab.textColor = [UIColor whiteColor];
    orderLab.font = [UIFont systemFontOfSize:9];
    
    UILabel*itemLab1=[[UILabel alloc]initWithFrame:CGRectMake(cell.itemLab.frame.origin.x+10,12,55,15)];
    itemLab1.textColor = [UIColor whiteColor];
    itemLab1.font = [UIFont systemFontOfSize:9];
    itemLab1.textAlignment=NSTextAlignmentCenter;

    
    UILabel*eachLab1=[[UILabel alloc]initWithFrame:CGRectMake(cell.eachLab.frame.origin.x+23,12,55,15)];
    eachLab1.textColor = [UIColor whiteColor];
    eachLab1.font = [UIFont systemFontOfSize:9];

    
   UILabel* qtyLab1=[[UILabel alloc]initWithFrame:CGRectMake(cell.qtyLab.frame.origin.x+11,12,55,15)];
    qtyLab1.textColor = [UIColor whiteColor];
    qtyLab1.font = [UIFont systemFontOfSize:9];

    
   UILabel* priceLab1=[[UILabel alloc]initWithFrame:CGRectMake(cell.pticeLab.frame.origin.x+18,12,55,15)];
    priceLab1.textColor = [UIColor whiteColor];
    priceLab1.font = [UIFont systemFontOfSize:9];
    
    orderLab.numberOfLines=0;
    itemLab1.numberOfLines=0;
    eachLab1.numberOfLines=0;
    qtyLab1.numberOfLines=0;
    priceLab1.numberOfLines=0;


    
    orderLab.text=@"ORDER";
    itemLab1.text=@"ITEM";
    eachLab1.text=@"EACH";
    qtyLab1.text=@"QTY";
    priceLab1.text=@"PRICE";


    [headerView addSubview:orderLab];
    [headerView addSubview:itemLab1];
    [headerView addSubview:eachLab1];
    [headerView addSubview:qtyLab1];
    [headerView addSubview:priceLab1];
    return headerView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)priceDetail
{
    itemLab.text=@"";
    eachLab.text=@"";
    qtyLab.text=@"";
    priceLab.text=@"";
    total.text=@"";
    
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
    qtyLabName.text=@"Taxes";
    qtyLabName.textAlignment = NSTextAlignmentCenter;
    UILabel*priceLabName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,70,100,15)];
    priceLabName.textColor = [UIColor darkGrayColor];
    priceLabName.font = [UIFont systemFontOfSize:13];
    priceLabName.text=@"Discount";
    priceLabName.textAlignment = NSTextAlignmentCenter;
    UILabel*totalName=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-200,100,100,15)];
    totalName.textColor = [UIColor orangeColor];
    totalName.font = [UIFont systemFontOfSize:13];
    totalName.text=@"Total";
    totalName.textAlignment = NSTextAlignmentCenter;

    
    itemLab.textColor = [UIColor darkGrayColor];
    itemLab.font = [UIFont systemFontOfSize:13];
    
    itemLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,12,85,15)];
    itemLab.textColor = [UIColor darkGrayColor];
    itemLab.font = [UIFont systemFontOfSize:13];
    
    
    eachLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,30,85,15)];
    eachLab.textColor = [UIColor darkGrayColor];
    eachLab.font = [UIFont systemFontOfSize:13];
    
    
    qtyLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,50,85,15)];
    qtyLab.textColor = [UIColor darkGrayColor];
    qtyLab.font = [UIFont systemFontOfSize:13];
    
    
    priceLab=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,70,85,15)];
    priceLab.textColor = [UIColor darkGrayColor];
    priceLab.font = [UIFont systemFontOfSize:13];
    
   total=[[UILabel alloc]initWithFrame:CGRectMake(viewFream.size.width-95,100,85,15)];
    total.textColor = [UIColor orangeColor];
    total.font = [UIFont systemFontOfSize:13];
    
    itemLab.text=[NSString stringWithFormat:@"$%@",[[[dataDic objectForKey:@"resultTotalCollection"]objectAtIndex:0] objectForKey:@"subTotal"]];
    eachLab.text=[NSString stringWithFormat:@"$%@",[[[dataDic objectForKey:@"resultTotalCollection"]objectAtIndex:0] objectForKey:@"shipTotal"]];
    qtyLab.text=[NSString stringWithFormat:@"$%@",[[[dataDic objectForKey:@"resultTotalCollection"]objectAtIndex:0] objectForKey:@"tax"]];
    
    priceLab.text=[NSString stringWithFormat:@"$%@",[[[dataDic objectForKey:@"resultTotalCollection"]objectAtIndex:0] objectForKey:@"discApmount"]];
    total.text=[NSString stringWithFormat:@"$%@",[[[dataDic objectForKey:@"resultTotalCollection"]objectAtIndex:0] objectForKey:@"total"]];
    itemLab.textAlignment = NSTextAlignmentRight;
    eachLab.textAlignment = NSTextAlignmentRight;
    qtyLab.textAlignment = NSTextAlignmentRight;
    priceLab.textAlignment = NSTextAlignmentRight;
    total.textAlignment = NSTextAlignmentRight;
    
    
    [self.detailView addSubview:itemLab];
    [self.detailView addSubview:eachLab];
    [self.detailView addSubview:qtyLab];
    [self.detailView addSubview:priceLab];
    [self.detailView addSubview:total];
    [self.detailView addSubview:itemLabName];
    [self.detailView addSubview:eachLabName];

    [self.detailView addSubview:qtyLabName];
    [self.detailView addSubview:priceLabName];
    [self.detailView addSubview:totalName];




}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)applyCouponBtn:(id)sender {
    [SVProgressHUD show];
 coupon=@"coupon";
   NSString*CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
    if(self.couponCodeTxt.text==nil || [self.couponCodeTxt.text length]<=0)
    {
        [self.couponCodeTxt resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Enter Coupon Code" timeDalay:1.0f];
    }
    else{
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }
     dic=@{@"CookieCart":CookieCartID,@"ShipCountry":[historyModel sharedhistoryModel].shipping_Country,@"ShipProvince":@"ON",@"id_customer":savedValue,@"area":@"orders",@"mode":@"",@"coupon_code":self.couponCodeTxt.text,@"action":@"apply_coupon"};
    
    [self orderDetail:dic];
    }
}
- (IBAction)continueBtn:(id)sender {
//    [self saveDataOnModelClass];
//    PaymentDetails*PaymentDetailsVC=[[PaymentDetails alloc]init];
//    [self.navigationController pushViewController:PaymentDetailsVC animated:NO];
    //resultTotalCollection
    [self saveDataOnModelClass];
    PaymentDetails*PaymentDetailsVC=[[PaymentDetails alloc]init];
    PaymentDetailsVC.CartData=info;
    PaymentDetailsVC.CartDataTotalValue=[dataDic valueForKey:@"resultTotalCollection"];

    [self.navigationController pushViewController:PaymentDetailsVC animated:NO];

}
- (IBAction)editOrder:(id)sender {
    AddToCartViewController*AddToCartVC=[[AddToCartViewController alloc]init];
    [self.navigationController pushViewController:AddToCartVC animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self scrollVievEditingFinished:textField];


    return YES;
}
-(void)saveDataOnModelClass
{

    [historyModel sharedhistoryModel].HSTTotal=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"HSTTotal"];
    [historyModel sharedhistoryModel].PSTTotal=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"PSTTotal"];
    [historyModel sharedhistoryModel].ShipTotal=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"shipTotal"];
    [historyModel sharedhistoryModel].SubTotal=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"subTotal"];
    [historyModel sharedhistoryModel].cartTotal=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"total"];
    [historyModel sharedhistoryModel].coupan_code=self.couponCodeTxt.text;
    [historyModel sharedhistoryModel].discApmount=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"discApmount"];[historyModel sharedhistoryModel].GSTTotal=[[[dataDic objectForKey:@"resultTotalCollection"] objectAtIndex:0] objectForKey:@"GSTTotal"];
    
}
- (void) scrollViewAdaptToStartEditingTextField:(UITextField*)textField
{
    CGPoint point = CGPointMake(0, textField.frame.origin.y -2.5 * textField.frame.size.height);
    [self.landingScrollView setContentOffset:point animated:YES];
}

- (void) scrollVievEditingFinished:(UITextField*)textField
{
CGPoint point = CGPointMake(0, textField.frame.origin.y -5.5 * textField.frame.size.height);    [self.landingScrollView setContentOffset:point animated:YES];
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self scrollViewAdaptToStartEditingTextField:textField];
    return YES;
}



@end
