//
//  ViewAllViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 7/26/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "ViewAllViewController.h"
#import "UIImageView+WebCache.h"


@interface ViewAllViewController ()<WebServiceResponseProtocal>

{
    MyWebServiceHelper *helper;
    NSDictionary*dataDic;
    NSDictionary*dic;
    NSArray*imageDataArray;
    NSString*savedValue;
}

@end

@implementation ViewAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewAllTable.hidden=YES;
    self.titleLab.text=self.titleStr;
    self.viewAllTable.delegate=self;
    self.viewAllTable.dataSource=self;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    if (!savedValue) {
        savedValue=@"";
    }
    
    
    if ([self.menuClass isEqualToString:@"RightMenuClass"])
    {
        if (!self.codeCategory) {
            self.codeCategory=@"";
        }
        dic= @{@"id_customer":@"",@"code_publisher":@"",@"code_category":self.codeCategory,@"area":@"product",@"mode":@"productlisting",};
        [self viewAllDetail:dic];
    }
    else if ([self.menuClass isEqualToString:@"leftMenu"])
    {
        if ([self.publisher isEqualToString:@"publisherList"])
        {
            savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
            
            if (!savedValue) {
                savedValue=@"";
            }
            if (!self.codeCategory) {
                self.codeCategory=@"";
            }
            
    dic=@{@"id_customer":savedValue,@"code_publisher":self.codeCategory,@"code_category":@"",@"area":@"product",@"mode":@"productlisting"};
            [self viewAllDetail:dic];
        }
        else
        {
            if (!self.codeCategory) {
                self.codeCategory=@"";
            }
            self.titleLab.text=self.titleStr;
            dic= @{@"id_customer":@"",@"code_publisher":@"",@"code_category":self.codeCategory,@"area":@"product",@"mode":@"productlisting",};
            [self viewAllDetail:dic];
        }
        
        
    }
    else if ([self.publisher isEqualToString:@"HomeSearch"])
    {
        savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
        if (!savedValue) {
            savedValue=@"";
        }
        if (!self.codeCategory) {
            self.codeCategory=@"";
        }
        
dic=@{@"id_customer":savedValue,@"code_publisher":self.codeCategory,@"code_category":@"",@"area":@"product",@"mode":@"productlisting"};
        [self viewAllDetail:dic];
    }
    else
    {
        if (!self.area) {
            self.area=@"";
        }
        dic=@{@"id_customer":@"",@"area":self.area,};
        [self viewAllDetail:dic];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewAllDetail:(NSDictionary*)dataString
{
    
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    if ([self.menuClass isEqualToString:@"RightMenuClass"])
    {
        [helper productAllDetail:dataString];
        
    }
    else if([self.menuClass isEqualToString:@"leftMenu"])
    {
        [helper productAllDetail:dataString];
        
    }
    else if([self.publisher isEqualToString:@"HomeSearch"])
    {
        [helper productAllDetail:dataString];
        
    }
    else
    {
        
        [helper homePageViewAll:dataString];
    }
}


-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    
    NSDictionary*  result = [NSJSONSerialization JSONObjectWithData:responseDictionary options:kNilOptions error:nil];
    NSLog(@"Result = %@",result);
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"Fatch_ViewAll_info"])
    {
        if ([self.area isEqualToString:@"featuredtProduct"])
        {
            
            imageDataArray = [dataDic objectForKey:@"productList"];
        }
        else if ([self.area isEqualToString:@"topSellersProduct"])
        {
            imageDataArray = [dataDic objectForKey:@"productList"];
            
        }
        else
        {
            imageDataArray = [dataDic objectForKey:@"productList"];
            
        }
        
        
        if (imageDataArray.count>0)
            
            
        {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.viewAllTable.hidden=NO;
                
                [self.viewAllTable reloadData];
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"Loaded" timeDalay:1.0];
                
            });
        }
        else
        {
            NSString *msg = [dataDic objectForKey:@"msg"];
            [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
        }
    }
    else if([apiName isEqualToString:@"Fatch_ProductAllDetail_info"])
    {
        
        
        imageDataArray = [dataDic objectForKey:@"info"];
        
        
        
        
        if (imageDataArray.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.viewAllTable.hidden=NO;
                
                [self.viewAllTable reloadData];
                
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
    return [imageDataArray count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"ViewAllTableViewCell";
    ViewAllTableViewCell *cell = (ViewAllTableViewCell *)[self.viewAllTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"ViewAllTableViewCell" owner:self options:nil];
        
        cell = [cellArray objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString*jpg=@"sm.jpg";
    NSString * urlString = [NSString stringWithFormat:@"https://www.learninghouse.ca/media/product-photos_new/%@_%@",[[[imageDataArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString],jpg];
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    [cell.viewAllImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    cell.titlelab.text = [[[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"title"] uppercaseString];
    [cell.titlelab sizeToFit];
    cell.productCode.text = [[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"code_product"];
    
    cell.availabilityLab.text = [NSString stringWithFormat:@"AVAILABILITY IN"];
    
    
    if ([[[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"price_display_sale"] isEqual:[NSNull null]])
    {
        cell.priceSale.text = @"";
    }
    
    else
    {
        //[cell.priceSale setBackgroundColor:[UIColor redColor]];
        cell.priceSale.text = [NSString stringWithFormat:@"$ %@",[[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"price_display_sale"]];
    }
    cell.productPrice.text = [NSString stringWithFormat:@"$ %@",[[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"price_display_retail"]];
    [cell.productCode sizeToFit];
    NSArray* getProductType = [[[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"product_type_all"] componentsSeparatedByString: @"|"];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductAllDetailViewController*ProductAllDetailVC=[[ProductAllDetailViewController alloc]init];
    [self.navigationController pushViewController:ProductAllDetailVC animated:YES];
    ProductAllDetailVC.productId=[[imageDataArray objectAtIndex:indexPath.row] objectForKey:@"product_id"];
    ProductAllDetailVC.imageCode=[[[imageDataArray objectAtIndex:indexPath.row]objectForKey:@"code_product"] lowercaseString];
}

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
