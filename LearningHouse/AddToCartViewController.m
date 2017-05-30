//
//  AddToCartViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 8/16/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "AddToCartViewController.h"
#import "UIImageView+WebCache.h"


@interface AddToCartViewController ()<WebServiceResponseProtocal>
{

    MyWebServiceHelper *helper;
    NSDictionary*dic;
    NSArray*info;
    NSDictionary*dataDic;
    NSString *savedValue;
    NSString *CookieCartID;
    NSInteger counter ;
    AatoCartTableViewCell *cell;

}

@end

@implementation AddToCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.addtoCartTable.delegate=self;
    self.addtoCartTable.dataSource=self;
     savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
     CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
    
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }
   
    dic=  @{@"CookieCart":CookieCartID,@"id_customer":savedValue,@"area":@"",@"mode":@"",};
    
    [self cartData:dic];

    // Do any additional setup after loading the view from its nib.
}
-(void)cartData:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper ShowCartData:dataString];
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    [SVProgressHUD dismiss];
    if([apiName isEqualToString:@"ShowCartData"])
    {
        info = [dataDic objectForKey:@"info"];
        NSLog(@"ShowCartData--->,%@",info);
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([[[info objectAtIndex:0] objectForKey:@"status"] intValue]==0)
                {
                    self.buttonBackgroundView.hidden=YES;

                    self.addtoCartTable.hidden=YES;


                    
                   // [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0] objectForKey:@"msg"] timeDalay:1.0];
                
                    
                    [self showMessage:[[info objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Success"];
                    
                }
                else{
                    
                    NSString*total=[NSString stringWithFormat:@" TOTAL$%@",[dataDic objectForKey:@"subTotal"]];
                    [self.totalBtn setTitle:total forState:UIControlStateNormal];
                [self.addtoCartTable reloadData];
                    
                
                //[MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0] objectForKey:@"msg"] timeDalay:1.0];
   // [self showMessage:[[info objectAtIndex:0] objectForKey:@"msg"]
                           // withTitle:@"Success"];
                }
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
   else if([apiName isEqualToString:@"AddTOCart"])

    {
       NSArray* info1 = [dataDic objectForKey:@"info"];
        NSLog(@"ShowCartData--->,%@",info1);
        if (info1.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cartData:dic];
                if ([[[info1 objectAtIndex:0] objectForKey:@"TotalCartItems"] intValue]==0)
                {
                    self.addtoCartTable.hidden=YES;
                    self.buttonBackgroundView.hidden=YES;
                    //[self showMessage:[[info objectAtIndex:0] objectForKey:@"status"]
                           // withTitle:@"msg"];

                    
                }
                else
                {
                    
                   [self.addtoCartTable reloadData];
                    

                }

              //  [MyCustomClass SVProgressMessageDismissWithSuccess:[[info1 objectAtIndex:0] objectForKey:@"msg"] timeDalay:3.0];
                [self showMessage:[[info1 objectAtIndex:0] objectForKey:@"msg"]
                        withTitle:@"Success"];

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
    return 1; //one male and other female
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [info count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"AatoCartTableViewCell";
    cell = (AatoCartTableViewCell *)[self.addtoCartTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"AatoCartTableViewCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    [cell.removeBtn addTarget: self
              action: @selector(removeDataCart:)
    forControlEvents: UIControlEventTouchUpInside];
    [cell.updateBtn addTarget: self
              action: @selector(updateDataCart:)
    forControlEvents: UIControlEventTouchUpInside];
    cell.removeBtn.tag=indexPath.row;
   cell.updateBtn.tag=indexPath.row;
    NSString*jpg=@"sm.jpg";
    NSString * urlString = [NSString stringWithFormat:@"https://www.learninghouse.ca/media/product-photos_new/%@_%@",[[[info objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString],jpg];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    [cell.cartImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    cell.lab1.text =[[[info objectAtIndex:indexPath.row]objectForKey:@"Title"] uppercaseString] ;
    //[cell.lab1 sizeToFit];
    cell.authorLab.text=[[info objectAtIndex:indexPath.row]objectForKey:@"Author"];
    cell.authorLab.numberOfLines=0;
    
    cell.totalLab.text =[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row]objectForKey:@"lineTotal"]];
    cell.itemQtyLab.text =[NSString stringWithFormat:@"%@",[[info objectAtIndex:indexPath.row]objectForKey:@"ItemQty"]];
//    NSString*total=[NSString stringWithFormat:@" TOTAL$%@",[dataDic objectForKey:@"subTotal"]];
//[self.totalBtn setTitle:total forState:UIControlStateNormal];
    
    if ([[[info objectAtIndex:indexPath.row]objectForKey:@"CdnSale"]intValue]==0)
    {
    cell.priceLab.text =[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row]objectForKey:@"CdnPrice"]] ;
    }
    else
    {
           cell.priceLab.text =[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row]objectForKey:@"CdnPrice"]] ;
        cell.salePrice.text=[NSString stringWithFormat:@"$%@",[[info objectAtIndex:indexPath.row]objectForKey:@"CdnSale"]];
        cell.salePrice.textColor=[UIColor redColor];
    
    }
    
    NSArray* getProductType = [[[info objectAtIndex:indexPath.row] objectForKey:@"product_type"] componentsSeparatedByString: @"|"];
    getProductType = [getProductType sortedArrayUsingSelector: @selector(compare:)];
    
    NSLog(@"getProductType--->%@",getProductType);
    
    if (getProductType.count>0)
    {
        //int counter;
        
        for(counter=0;counter<getProductType.count;counter++)
        {
            NSLog(@"counter value>>%ld",(long)counter);
            int ProdType;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)removeDataCart:(id)sender
{
   
    
    NSDictionary*datadic=  @{@"cartorderno":[[info objectAtIndex:[sender tag]]objectForKey:@"code_product"],@"id_customer":savedValue,@"product_type":[[info objectAtIndex:[sender tag]]objectForKey:@"product_type"],@"ItemQty":[[info objectAtIndex:[sender tag]]objectForKey:@"ItemQty"],@"CookieCart":CookieCartID,@"area":@"products",@"mode":@"remove",};
    [helper AddTOCart:datadic];
   // [self.addtoCartTable reloadData];


}
-(void)updateDataCart:(id)sender
{
   // NSString*item=[historyModel sharedhistoryModel].counterValue;
    NSDictionary*datadic;
    if ([[historyModel sharedhistoryModel].counterValue length]==0)
    {
     datadic=  @{@"cartorderno":[[info objectAtIndex:[sender tag]]objectForKey:@"code_product"],@"id_customer":savedValue,@"product_type":[[info objectAtIndex:[sender tag]]objectForKey:@"product_type"],@"ItemQty":[[info objectAtIndex:[sender tag]] objectForKey:@"ItemQty"],@"CookieCart":CookieCartID,@"area":@"products",@"mode":@"update",};
    }
    else
    {
        datadic=  @{@"cartorderno":[[info objectAtIndex:[sender tag]]objectForKey:@"code_product"],@"id_customer":savedValue,@"product_type":[[info objectAtIndex:[sender tag]]objectForKey:@"product_type"],@"ItemQty":[historyModel sharedhistoryModel].counterValue,@"CookieCart":CookieCartID,@"area":@"products",@"mode":@"update",};
        [historyModel sharedhistoryModel].counterValue=@"";
    
    }
   
    [helper AddTOCart:datadic];
   // [self.addtoCartTable reloadData];

}


- (IBAction)backBtn:(id)sender {
    if ([self.backController isEqualToString:@"home"])
    {
        HomeViewController*HomeViewVC=[[HomeViewController alloc] init];
        
        [self.navigationController pushViewController:HomeViewVC animated:NO];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];

    }
    
   
}
- (IBAction)checkOut:(id)sender
{
    CheckOutViewController*CheckOutVC=[[CheckOutViewController alloc]init];
    [self.navigationController pushViewController:CheckOutVC animated:NO];

    
}
-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}
@end
