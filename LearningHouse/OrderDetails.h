//
//  OrderDetails.h
//  LearningHouse
//
//  Created by Alok Singh on 8/22/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "historyModel.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "orderCellTableViewCell.h"
#import "PaymentDetails.h"

@interface OrderDetails : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIScrollView *landingScrollView;

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *contectPhone;
@property (strong, nonatomic) IBOutlet UILabel *contectEmail;
@property (strong, nonatomic) IBOutlet UILabel *contectMe;
@property (strong, nonatomic) IBOutlet UILabel *billingName;
@property (strong, nonatomic) IBOutlet UILabel *billinState;
@property (strong, nonatomic) IBOutlet UILabel *billinAddress1;
@property (strong, nonatomic) IBOutlet UILabel *billinAddress2;
@property (strong, nonatomic) IBOutlet UILabel *billincity;
@property (strong, nonatomic) IBOutlet UILabel *shippingName;
@property (strong, nonatomic) IBOutlet UILabel *shippingAddress1;
@property (strong, nonatomic) IBOutlet UILabel *shippingAddress2;
@property (strong, nonatomic) IBOutlet UILabel *shippingCity;
@property (strong, nonatomic) IBOutlet UILabel *shippingState;
@property (strong, nonatomic) IBOutlet UITableView *orderTable;
@property(strong,nonatomic)NSString*contectStr;
@property (strong, nonatomic) IBOutlet UITextField *couponCodeTxt;
@property (strong, nonatomic) IBOutlet UIButton *applyCouponBtn;

- (IBAction)applyCouponBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIButton *continueBtn;
- (IBAction)continueBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *editOrder;
- (IBAction)editOrder:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *detailView;

@property (strong, nonatomic) IBOutlet UIImageView *continueEditBackground;
@property (strong, nonatomic) IBOutlet UIView *headerView;


@end
