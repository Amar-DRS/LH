//
//  MyWebServiceHelper.h
//  imagetest
//
//  Created by t on 11/17/14.
//  Copyright (c) 2014 Thajmeel Ahmed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyProtocals.h"
#import "MyCustomClass.h"


@interface MyWebServiceHelper : NSObject
{
    NSString *apiName;
}
@property (nonatomic,strong) id <WebServiceResponseProtocal> webApiDelegate;
-(void)getHomeData:(NSDictionary *)coustomerId;
-(void)homePageViewAll:(NSDictionary *)coustomerId;
-(void)productAllDetail:(NSDictionary *)productinfo;
-(void)getSubMenuCategories:(NSDictionary *)coustomerId;
-(void)AboutLearningHouse:(NSDictionary *)coustomerId;
-(void)registerApi:(NSDictionary *)registerdata;
-(void)loginApi:(NSDictionary *)registerdata;
-(void)myAccount:(NSDictionary *)myAccountData;
-(void)eventApi:(NSDictionary *)eventData;
-(void)AddTOCart:(NSDictionary *)CartData;
-(void)ShowCartData:(NSDictionary *)CartData;
-(void)PublisherListing:(NSDictionary *)publishersData;
-(void)checkOutData:(NSDictionary *)checkOutDic;
-(void)orderDetail:(NSDictionary *)orderData;
-(void)homeSearch:(NSDictionary *)searchData;
-(void)schoolData:(NSDictionary *)schoolDicData;
-(void)PaymentApi:(NSDictionary *)paymentData;
-(void)orderApi:(NSDictionary *)orderData;
-(void)payPalConfirmation:(NSDictionary *)orderData;
-(void)Dump_Data:(NSDictionary *)InputValue;












@end
