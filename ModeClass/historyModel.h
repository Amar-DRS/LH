//
//  historyModel.h
//  Patient
//
//  Created by Alok Singh on 5/20/16.
//  Copyright © 2016 mithun ravi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface historyModel : NSObject
//add all other model data
+(historyModel*)sharedhistoryModel;

@property(strong,nonatomic)NSArray*rigthMenuArray;
@property(strong,nonatomic)NSString*parentId;
@property(strong,nonatomic)NSString*subcategoryName;
@property(strong,nonatomic)NSString*codeCatalog;
@property(strong,nonatomic)NSString*rightORleftMenu;
@property(strong,nonatomic)NSDictionary*myAccountData;
@property(strong,nonatomic)NSArray*BillingDetail;
@property(strong,nonatomic)NSArray*eventData;
@property(strong,nonatomic)NSArray*CookieCartStr;
@property(strong,nonatomic)NSString*counterValue;
@property(strong,nonatomic)NSDictionary*orderDetailDictionary;
@property(strong,nonatomic)NSString*myAccount;
@property(strong,nonatomic)NSString*productType;



// payment string //
@property(strong,nonatomic)NSString*name_customer;
@property(strong,nonatomic)NSString*address;
@property(strong,nonatomic)NSString*address1;
@property(strong,nonatomic)NSString*postcode;

@property(strong,nonatomic)NSString*Province;
@property(strong,nonatomic)NSString*city;
@property(strong,nonatomic)NSString*Country;
@property(strong,nonatomic)NSString*shipping_name_customer;
@property(strong,nonatomic)NSString*shipping_address;
@property(strong,nonatomic)NSString*shipping_address1;
@property(strong,nonatomic)NSString*shipping_postcode;
@property(strong,nonatomic)NSString*shipping_Province;
@property(strong,nonatomic)NSString*shipping_city;
@property(strong,nonatomic)NSString*shipping_Country;
@property(strong,nonatomic)NSString*customer_email;
@property(strong,nonatomic)NSString*mobile_no;
@property(strong,nonatomic)NSString*contact_me;
@property(strong,nonatomic)NSString*comments;
@property(strong,nonatomic)NSString*CookieCart;
@property(strong,nonatomic)NSString*id_customer;
@property(strong,nonatomic)NSString*HSTTotal;
@property(strong,nonatomic)NSString*PSTTotal;
@property(strong,nonatomic)NSString*ShipTotal;
@property(strong,nonatomic)NSString*SubTotal;
@property(strong,nonatomic)NSString*cartTotal;
@property(strong,nonatomic)NSString*coupan_code;
@property(strong,nonatomic)NSString*discApmount;
@property(strong,nonatomic)NSString*GSTTotal;




























@end
