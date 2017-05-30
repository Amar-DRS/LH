//
//  ViewDetailViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "orderCellTableViewCell.h"

@interface ViewDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property(strong,nonatomic)NSString*isViewDetai;
@property(strong,nonatomic)NSString*orderid;
@property (strong, nonatomic) IBOutlet UIScrollView *landingScrollView;

@property (strong, nonatomic) IBOutlet UILabel *billingAddressLab;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UILabel *shippingaddressLab;
@property (strong, nonatomic) IBOutlet UIView *totalAmountDetailView;

@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UITableView *orderTable;


@end
