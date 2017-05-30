//
//  ProductAllDetailViewController.m
//  LearningHouse
//
//  Created by Alok Singh on 7/27/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "ProductAllDetailViewController.h"
#import "UIImageView+WebCache.h"


@interface ProductAllDetailViewController ()<WebServiceResponseProtocal>
{
    
    MyWebServiceHelper *helper;
    NSDictionary*dataDic;
    NSDictionary*dic;
    NSMutableArray* productDetailArray;
    NSMutableArray* productAvailabilityDetailArr;
    
    UIWebView*showproductDetail1;
    UIView*  paintView;
    NSInteger counter ;
    NSArray*info;
    NSInteger quentity;
    NSString*productHtmlDetail;
    int imagecounter;
    //int ProdType;
    NSString *ImageName1;
    NSString *ImageName2;
    NSString *ImageName3;
    NSString *ImageName4;
    NSString *AVLImageName1;
    NSString *AVLImageName2;
    NSString *AVLImageName3;
    NSString *AVLImageName4;
    NSInteger productValue;
    NSString*buyOrAddtoCart;
    
}

@end

@implementation ProductAllDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.showproductDetail.delegate=self;
    self.img2.userInteractionEnabled=YES;
    self.img3.userInteractionEnabled=YES;
    
    
    self.counterLab .backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"quantity"]];
    
    [self.counterLab setText:[NSString stringWithFormat:@"%@",@"1"]];
    
    counter=1;
    if (!self.productId) {
        self.productId=@"";
    }
    dic=@{@"id_customer":@"",@"id_product":self.productId,@"area":@"product",@"mode":@"productdetail"};
    NSLog(@"dic result..>%@",dic);
    
    [self productAllDetail:dic];
    
    
}
-(void)productAllDetail:(NSDictionary*)dataString
{
    
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [helper productAllDetail:dataString];
    
}




-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{   // NSLog(@"dataDicData>>>>%@",responseDictionary);
    NSString* newStr = [[NSString alloc] initWithData:responseDictionary encoding:NSUTF8StringEncoding];
    NSLog(@"responseDictionary>>>>%@",newStr);
    
    dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"Fatch_ProductAllDetail_info"])
    {
        productDetailArray = [dataDic objectForKey:@"info"];
        productAvailabilityDetailArr = [dataDic objectForKey:@"aPtyeInfo"];
        
        if (productDetailArray.count>0)
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [historyModel sharedhistoryModel].productType=[[productDetailArray objectAtIndex:0] objectForKey:@"product_type"];
                
                [self RefreshAvailabilityInData];
                [self showData];
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:@"Loaded" timeDalay:1.0];
                
            });
        }
        else
        {
        [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:3.0];
        }
    }
    else if([apiName isEqualToString:@"AddTOCart"])
    {
        [SVProgressHUD dismiss];

        info = [dataDic objectForKey:@"info"];
        if (info.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];

                
                if ([[[info objectAtIndex:0] objectForKey:@"status"]intValue]==0)
                {
                    //                    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                    //                    // Convert your value to IntegerValue and Save it
                    //                    [prefs setInteger:[[[info objectAtIndex:0] objectForKey:@"TotalCartItems"] integerValue] forKey:@"TotalCartItems"];
                    //                    // Dont forget to synchronize UserDefaults
                    //                    [prefs synchronize];
                    NSString *CookieCartId = [[info objectAtIndex:0]objectForKey:@"CookieCart"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:CookieCartId forKey:@"CookieCart"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    if ([buyOrAddtoCart isEqualToString:@"BuyNow"])
                    {
                    
                        CheckOutViewController*CheckOutVC=[[CheckOutViewController alloc]init];
                        [self.navigationController pushViewController:CheckOutVC animated:NO];
                        
                    }
                    else if ([buyOrAddtoCart isEqualToString:@"addtoCart"])
                    {
                        HomeViewController*HomeViewVC=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
                        [self.navigationController pushViewController:HomeViewVC animated:NO];
                    }
                    
                   // [MyCustomClass SVProgressMessageDismissWithSuccess:[[info objectAtIndex:0] objectForKey:@"msg"] timeDalay:3.0];
                    
                    [self showMessage:[[info objectAtIndex:0] objectForKey:@"msg"]
                            withTitle:@"Success"];
                    
                    
                }
            });
        }
        
        
        
    }
    else
    {
        NSString *msg = [dataDic objectForKey:@"msg"];
        [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
    }
    
    
    
}

-(NSString*)GetImageName:(int)ProductType
{
    NSString *imageName;
    
    switch (ProductType) {
            
            
        case 1:
            imageName=@"hard-book";
            
            
            break;
        case 2:
            imageName=@"ebook";

            break;
        case 3:
            imageName=@"mp3";
            
            break;
        case 4:
            imageName=@"compact-disc";
            
            break;
        default:
            break;
    }
    
    return imageName;
}
-(NSString*)GetImageName:(int)ProductType IsAvail:(int)AvailType
{
    // AvailType Availability selection image 1 for normaal 2 for availibility selection image
    
    NSString *imageName;
    if (AvailType==1)
    {
        switch (ProductType) {
                
            case 1:
                imageName=@"hard-book";
                break;
            case 2:
                imageName=@"ebook";

                break;
            case 3:
                imageName=@"mp3";
                break;
            case 4:
                imageName=@"compact-disc";
                
                break;
            default:
                break;
                
        }
        
    }
    else
    {
        switch (ProductType) {
                
            case 1:
                imageName=@"a-book";
                break;
            case 2:
                imageName=@"a-ebook";
                break;
            case 3:
                imageName=@"a-mp3";
                break;
            case 4:
                imageName=@"a-cd";
                break;
            default:
                break;
                
        }
        
        
    }
    return imageName;
}
-(void)SetImageName:(int)ProductType ImagePlaceNumber:(int)PlaceIdentifier
{
    // PlaceIdentifier postion of image 1...4
    switch (PlaceIdentifier) {
            
            
        case 0:
            ImageName1=[self GetImageName:ProductType IsAvail:1];
            AVLImageName1=[self GetImageName:ProductType IsAvail:2];
            
            break;
        case 1:
            ImageName2=[self GetImageName:ProductType IsAvail:1];
            AVLImageName2=[self GetImageName:ProductType IsAvail:2];
            
            break;
        case 2:
            ImageName3=[self GetImageName:ProductType IsAvail:1];
            AVLImageName3=[self GetImageName:ProductType IsAvail:2];
            break;
        case 3:
            ImageName4=[self GetImageName:ProductType IsAvail:1];
            AVLImageName4=[self GetImageName:ProductType IsAvail:2];
            break;
        default:
            break;
    }
    
}
-(void)RefreshAvailabilityInData
{
    // set all images for different positions
    int Start;
    for (Start=0; Start<productAvailabilityDetailArr.count; Start++) {
        
        [self  SetImageName:[[[productAvailabilityDetailArr objectAtIndex:Start] valueForKey:@"product_type"] intValue] ImagePlaceNumber:Start ];
    }
    
    
    switch (productAvailabilityDetailArr.count) {
        case 1:
            [self.img1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:0] valueForKey:@"product_type"] intValue]]]] forState:UIControlStateNormal];
            NSLog(@"Image name>>%@",[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:0] valueForKey:@"product_type"] intValue]]]);
            //[self.img1 setBackgroundImage:[UIImage imageNamed:@"hard-book" ]forState:UIControlStateNormal];
            self.img2.hidden=YES;
            self.img2.userInteractionEnabled=NO;
            
            self.img3.hidden=YES;
            self.img3.userInteractionEnabled=NO;
            
            self.img4.hidden=YES;
            self.img4.userInteractionEnabled=NO;
            
            
            break;
        case 2:
            [self.img1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:0] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            [self.img2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:1] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            
            
            self.img3.hidden=YES;
            self.img3.userInteractionEnabled=NO;
            
            self.img4.hidden=YES;
            self.img4.userInteractionEnabled=NO;
            
            break;
        case 3:
            [self.img1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:0] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            [self.img2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:1] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            [self.img3 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:2] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            self.img4.hidden=YES;
            self.img4.userInteractionEnabled=NO;
            break;
        case 4:
            [self.img1 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:0] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            [self.img2 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:1] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            [self.img3 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:2] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            [self.img4 setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [self GetImageName:[[[productAvailabilityDetailArr objectAtIndex:3] valueForKey:@"product_type"] intValue]]]]  forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
}
-(void)checkproductType:(id)sender
{
    if ([[[productAvailabilityDetailArr objectAtIndex:productValue] valueForKey:@"product_type"] intValue]==2 ||[[[productAvailabilityDetailArr objectAtIndex:productValue] valueForKey:@"product_type"] intValue]==3)
{
    self.qtyLab.hidden=YES;
    self.qtyView.hidden=YES;
}
    else{
        self.qtyLab.hidden=NO;
        self.qtyView.hidden=NO;
    
    }
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *fontSize=@"320";
    NSString *jsString = [[NSString alloc]      initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",[fontSize intValue]];
    [self.showproductDetail stringByEvaluatingJavaScriptFromString:jsString];
    
}

-(void)showData
{
    // [self SetPriceLable:0];
    [self AvailabilityFirstBtn:@""];
    
    NSString*jpg=@"lg.jpg";
    NSString * urlString = [NSString stringWithFormat:@"https://www.learninghouse.ca/media/product-photos_new/%@_%@",self.imageCode,jpg];
    
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    [self.productImage setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    
    if ([[[productDetailArray objectAtIndex:0] objectForKey:@"title"] isEqual:[NSNull null] ])
    {
        self.autherLab.text=@"";
    }
    else
    {
        self.autherLab.text=[[[productDetailArray objectAtIndex:0] objectForKey:@"title"] uppercaseString];
        
        
        
    }
    if ([[[productDetailArray objectAtIndex:0] objectForKey:@"aPublisher_Name"] isEqual:[NSNull null] ])
    {
        self.autherName.text=[NSString stringWithFormat:@""];
    }
    else
    {
        self.autherName.text=[NSString stringWithFormat:@"by %@",[[productDetailArray objectAtIndex:0] objectForKey:@"aPublisher_Name"]];
        
    }
    if ([[[productDetailArray objectAtIndex:0] objectForKey:@"description"] isEqual:[NSNull null] ])
    {
        productHtmlDetail=[NSString stringWithFormat:@""];
    }
    else
    {
        productHtmlDetail=[[productDetailArray objectAtIndex:0] objectForKey:@"description"];
        
    }
    
    
    
    [self.showproductDetail loadHTMLString:productHtmlDetail baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    // self.priceLab.text=[NSString stringWithFormat:@"$%@",[[productDetailArray objectAtIndex:0] objectForKey:@"price_display_retail"]];
    
    self.productCodeLab.text=[NSString stringWithFormat:@"%@",[[productDetailArray objectAtIndex:0] objectForKey:@"code_product"]];
    
    
    
    
    ///
//    
//    if ([[[productDetailArray objectAtIndex:0] objectForKey:@"price_display_sale"] isEqual:[NSNull null]])
//    {
//        // self.priceSale.text = @"";
//        self.priceSale.textColor=[UIColor blackColor];
//        self.priceSale.text=[NSString stringWithFormat:@"$%@",[[productDetailArray objectAtIndex:0] objectForKey:@"price_display_retail"]];
//        
//        
//        
//    }
//    
//    else
//    {
//        //[cell.priceSale setBackgroundColor:[UIColor redColor]];
//        
//        self.priceSale.text = [NSString stringWithFormat:@"$ %@",[[productDetailArray objectAtIndex:0] objectForKey:@"price_display_sale"]];
//        //  self.priceLab.text=[NSString stringWithFormat:@"$%@",[[productDetailArray objectAtIndex:0] objectForKey:@"price_display_retail"]];
//    }
//    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[self showData];
    
}
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
//    int fontSize = 280;
//    NSString *jsString = [[NSString alloc] initWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'", fontSize];
//    [self.showproductDetail stringByEvaluatingJavaScriptFromString:jsString];
//
//
//
//}


- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)incressWebViewSize:(id)sender {
    float buttonWidth = 30;
    float buttonHeight = 30;
    showproductDetail1=[[UIWebView alloc]init];
    showproductDetail1.frame = CGRectMake(30,100, self.view.frame.size.width-60, self.view.frame.size.height-200);
    showproductDetail1.delegate=self;
    
    
    paintView=[[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [paintView setBackgroundColor:[UIColor yellowColor]];
    if (![[[productDetailArray objectAtIndex:0] objectForKey:@"description"] isEqual:[NSNull null]])
    {
    productHtmlDetail=[[productDetailArray objectAtIndex:0] objectForKey:@"description"];
    }
    [showproductDetail1 loadHTMLString:productHtmlDetail baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    UIButton *cancelBtn =[ [UIButton alloc] initWithFrame:CGRectMake(showproductDetail1.frame.size.width - buttonWidth,0, buttonWidth,buttonHeight)];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close"]
                         forState:UIControlStateNormal];
    //[cancelBtn setBackgroundColor:[UIColor redColor]];
    
    [cancelBtn addTarget:self
                  action:@selector(myAction)
        forControlEvents:UIControlEventTouchUpInside];
    paintView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.6];
    
    [showproductDetail1 addSubview:cancelBtn];
    
    [paintView addSubview:showproductDetail1];
    [self.view addSubview:paintView];
    
}

- (IBAction)minusQuantity:(id)sender {
    
    
    // NSInteger counter = 0;
    
    if (counter <= 1)
        return;
    [self.counterLab setText:[NSString stringWithFormat:@"%ld",(long)--counter]];
    
}

- (IBAction)plusQuantity:(id)sender {
    
    // NSInteger counter = 0;
    
    if (counter > 100 )
        return;
    [self.counterLab setText:[NSString stringWithFormat:@"%ld",(long)++counter]];
    
    
}
-(void)myAction
{
    showproductDetail1.hidden=YES;
    [paintView removeFromSuperview];
    
}

- (IBAction)addtoCart:(id)sender
{
    buyOrAddtoCart=@"addtoCart";
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    NSString *CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
    NSString*cartorderno= [[productDetailArray objectAtIndex:0] objectForKey:@"code_product"];
   // NSString*productType=[historyModel sharedhistoryModel].productType;
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }
    
    dic=@{@"cartorderno":cartorderno,@"id_product":self.productId,@"id_customer":savedValue,@"product_type":[historyModel sharedhistoryModel].productType,@"ItemQty":[NSString stringWithFormat:@"%ld", (long)counter],@"CookieCart":CookieCartID,@"area":@"products",@"mode":@"add",};
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper AddTOCart:dic];
    
}
- (IBAction)AvailabilityFirstBtn:(id)sender {
    
    
    [self SetPriceLable:0];
    [self.img1 setBackgroundImage:[UIImage imageNamed:AVLImageName1] forState:UIControlStateNormal];
    [self.img2 setBackgroundImage:[UIImage imageNamed:ImageName2] forState:UIControlStateNormal];
    [self.img3 setBackgroundImage:[UIImage imageNamed:ImageName3] forState:UIControlStateNormal];
    [self.img4 setBackgroundImage:[UIImage imageNamed:ImageName4] forState:UIControlStateNormal];
    productValue=0;
     [historyModel sharedhistoryModel].productType=[[productAvailabilityDetailArr objectAtIndex:0] objectForKey:@"product_type"];
    [self checkproductType:self];
    
    
    
}

- (IBAction)AvailabilitySecondBtn:(id)sender {
    
    [self SetPriceLable:1];
    
    self.qtyLab.hidden=YES;
    self.qtyView.hidden=YES;
    [self.img2 setBackgroundImage:[UIImage imageNamed:AVLImageName2] forState:UIControlStateNormal];
    [self.img1 setBackgroundImage:[UIImage imageNamed:ImageName1] forState:UIControlStateNormal];
    [self.img3 setBackgroundImage:[UIImage imageNamed:ImageName3] forState:UIControlStateNormal];
    [self.img4 setBackgroundImage:[UIImage imageNamed:ImageName4] forState:UIControlStateNormal];
    productValue=1;
     [historyModel sharedhistoryModel].productType=[[productAvailabilityDetailArr objectAtIndex:1] objectForKey:@"product_type"];

    [self checkproductType:self];
    
    
}

- (IBAction)AvailabilityThirdBtn:(id)sender {
    [self SetPriceLable:2];
    [self.img1 setBackgroundImage:[UIImage imageNamed:ImageName1] forState:UIControlStateNormal];
    [self.img2 setBackgroundImage:[UIImage imageNamed:ImageName2] forState:UIControlStateNormal];
    [self.img3 setBackgroundImage:[UIImage imageNamed:AVLImageName3] forState:UIControlStateNormal];
    [self.img4 setBackgroundImage:[UIImage imageNamed:ImageName4] forState:UIControlStateNormal];
    productValue=2;
     [historyModel sharedhistoryModel].productType=[[productAvailabilityDetailArr objectAtIndex:2] objectForKey:@"product_type"];

    [self checkproductType:self];
    
}

- (IBAction)AvailabilityFourthBtn:(id)sender {
    [self SetPriceLable:3];
    [self.img1 setBackgroundImage:[UIImage imageNamed:ImageName1] forState:UIControlStateNormal];
    [self.img2 setBackgroundImage:[UIImage imageNamed:ImageName2] forState:UIControlStateNormal];
    [self.img3 setBackgroundImage:[UIImage imageNamed:ImageName3] forState:UIControlStateNormal];
    [self.img4 setBackgroundImage:[UIImage imageNamed:AVLImageName4] forState:UIControlStateNormal];
    productValue=3;
     [historyModel sharedhistoryModel].productType=[[productAvailabilityDetailArr objectAtIndex:3] objectForKey:@"product_type"];
    [self checkproductType:self];
    
}

- (IBAction)buyNowBtn:(id)sender
{
    buyOrAddtoCart=@"BuyNow";
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]stringForKey:@"preferenceName"];
    NSString *CookieCartID = [[NSUserDefaults standardUserDefaults]stringForKey:@"CookieCart"];
    NSString*cartorderno= [[productDetailArray objectAtIndex:0] objectForKey:@"code_product"];
  //  NSString*productType=[historyModel sharedhistoryModel].productType;
    if (!savedValue) {
        savedValue=@"";
    }
    if (!CookieCartID) {
        CookieCartID=@"";
    }
    NSLog(@"cartorderno%@",cartorderno);
    dic=@{@"cartorderno":cartorderno,
          @"id_product":self.productId,
          @"id_customer":savedValue,
          @"product_type":[historyModel sharedhistoryModel].productType,
          @"ItemQty":[NSString stringWithFormat:@"%ld", (long)counter],
          @"CookieCart":CookieCartID,
          @"area":@"products",
          @"mode":@"add",};
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper AddTOCart:dic];
    
}
-(void)SetPriceLable:(NSInteger)BtnNumber
{
    
    
    NSString *PriceSale=[NSString stringWithFormat:@" %@",[[productAvailabilityDetailArr objectAtIndex:BtnNumber] objectForKey:@"price_display_sale"]];
    NSString *PriceLab=[NSString stringWithFormat:@" %@",[[productAvailabilityDetailArr objectAtIndex:BtnNumber] objectForKey:@"price_display_retail"]];
    //self.priceLab.text =[NSString stringWithFormat:@"$ %@\n$ %@",PriceSale,PriceLab];
    //[self.priceLab sizeToFit];
    
    //    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
    //    [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,[PriceSale length]+2)];
    //    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([PriceSale length]+3,[PriceLab length]+2)];
    //   self.priceLab.attributedText = string;
    
    if ([[[productAvailabilityDetailArr objectAtIndex:BtnNumber] objectForKey:@"price_display_sale"] isEqual:[NSNull null]])
    {
        self.priceLab.font=[self.priceLab.font fontWithSize:17];

        self.priceLab.text =[NSString stringWithFormat:@"$%@",PriceLab];
        //[string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,[PriceLab length]+2)];
    }
    
    else
    {
        self.priceLab.font=[self.priceLab.font fontWithSize:15];

        self.priceLab.text =[NSString stringWithFormat:@"$%@\n $%@",PriceLab,PriceSale];
        NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,[PriceSale length]+1)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([PriceSale length]+2,[PriceLab length]+2)];
        self.priceLab.attributedText = string;
        
    }
    
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
