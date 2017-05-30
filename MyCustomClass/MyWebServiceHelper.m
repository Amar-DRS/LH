//
//  MyWebServiceHelper.m
//  imagetest
//
//  Created by t on 11/17/14.
//  Copyright (c) 2014 Thajmeel Ahmed. All rights reserved.
//

#import "MyWebServiceHelper.h"

@implementation MyWebServiceHelper
@synthesize webApiDelegate;
#define WEB_URL @"https://www.learninghouse.ca" // production server database
//#define WEB_URL @"http://learninghouse.devanorth.com"// development database server

-(void )synchronousApiRequestByPostWithDataTypeInResponse:(NSString *)urlString postData:(NSDictionary *)dataDic
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"123" forHTTPHeaderField:@"admin"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             //[webApiDelegate webApiResponseError:error];
             [MyCustomClass SVProgressMessageDismissWithError:[NSString stringWithFormat:@"Error: %@" , error]  timeDalay:1.50];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}
-(void )synchronousApiRequestByPostWithStringTypeInResponse:(NSString *)urlString postData:(NSString *)dataString
{

    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSString *jsonString = [[NSString alloc] initWithString:dataString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)dataString.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
            // [webApiDelegate webApiResponseError:error];
             NSLog(@"Erorr: %@",[NSString stringWithFormat:@"Error: %@" , error]);
             [MyCustomClass SVProgressMessageDismissWithError:[NSString stringWithFormat:@"Error: %@" , error]  timeDalay:1.50];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}

-(void )synchronousApiRequestByGetWithDataTypeInResponse:(NSString *)urlString
{

    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             [webApiDelegate webApiResponseError:error];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}

-(NSString *)synchronousApiRequest:(NSString *)urlString
{
    NSURL *mainURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:mainURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return responseString;
}

#pragma mark - Response Result Handling Method list
-(void)webapiResponseResultHandling:(NSData *)data
{
    [webApiDelegate webApiResponseData:data apiName:apiName];
}

#pragma mark - API Request Method list



-(void)getHomeData:(NSDictionary *)coustomerId
{
        apiName=@"Fatch_HomeScreen_info";
        NSString *urlString=[NSString stringWithFormat:@"%@/lhwebs/homepage.php",WEB_URL];
    
        [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:coustomerId];
        NSLog(@"getDocterInfo");

}
-(void)homePageViewAll:(NSDictionary *)coustomerId
{
    apiName=@"Fatch_ViewAll_info";
    NSString *urlString=[NSString stringWithFormat:@"%@/lhwebs/homepageviewall.php",WEB_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:coustomerId];
    NSLog(@"getDocterInfo");
    
}
-(void)productAllDetail:(NSDictionary *)productinfo
{
    apiName=@"Fatch_ProductAllDetail_info";
    NSString *urlString=[NSString stringWithFormat:@"%@/lhwebs/productListing.php",WEB_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:productinfo];
    
}

-(void)getSubMenuCategories:(NSDictionary *)coustomerId
{
    apiName=@"Fatch_SubCategories_info";
    NSString *urlString=[NSString stringWithFormat:@"%@/lhwebs/category.php",WEB_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:coustomerId];
    
}

-(void)AboutLearningHouse:(NSDictionary *)coustomerId
{
    apiName=@"Fatch_AboutLH_info";
    NSString *urlString=[NSString stringWithFormat:@"%@/lhwebs/content.php",WEB_URL];
    
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:coustomerId];
    
}

-(void)registerApi:(NSDictionary *)registerdata
{
    apiName=@"register";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/login.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:registerdata];
}
//http://learninghouse.devanorth.com/lhwebs/login.php

-(void)loginApi:(NSDictionary *)loginData
{
    apiName=@"loginApi";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/login.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:loginData];
}
-(void)myAccount:(NSDictionary *)myAccountData
{
    apiName=@"myAccount";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/account.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:myAccountData];
}

-(void)eventApi:(NSDictionary *)eventData
{
    apiName=@"Event";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/event.php",WEB_URL];
[self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:eventData];
}
-(void)AddTOCart:(NSDictionary *)CartData
{
    apiName=@"AddTOCart";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/shopping_cart.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:CartData];
}
-(void)ShowCartData:(NSDictionary *)CartData
{
    apiName=@"ShowCartData";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/cart.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:CartData];
}
-(void)PublisherListing:(NSDictionary *)publishersData
{
    apiName=@"PublisherListing";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/publisher.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:publishersData];
}
-(void)PaymentApi:(NSDictionary *)paymentData
{
    apiName=@"PaymentApi";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/paymethod.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:paymentData];
}
-(void)orderApi:(NSDictionary *)orderData
{
    apiName=@"orderApi";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/order.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:orderData];
}
-(void)payPalConfirmation:(NSDictionary *)orderData
{
    apiName=@"payPalConfirmation";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/order.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:orderData];
}

//-(void)checkOutData:(NSDictionary *)checkOutDic
//{
//    apiName=@"checkOutData";
//    NSString* urlString=[NSString stringWithFormat:@"http://learninghouse.devanorth.com/lhwebs/account.php"];
//    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:checkOutDic];
//}

-(void)orderDetail:(NSDictionary *)orderData
{
    apiName=@"orderDetail";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/shopcheckout.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:orderData];
}

-(void)homeSearch:(NSDictionary *)searchData
{
    apiName=@"homeSearch";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/autosearch.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:searchData];
}
-(void)schoolData:(NSDictionary *)schoolDicData
{
    apiName=@"schoolData";
    NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/schoolboard.php",WEB_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:schoolDicData];
}


-(void)Dump_Data:(NSDictionary *)InputValue
{

 
        apiName=@"DumpData";
        NSString* urlString=[NSString stringWithFormat:@"%@/lhwebs/data-dump.php",WEB_URL];
        [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];

}

-(void)checkOutData:(NSDictionary *)checkOutDic

{



}



@end
