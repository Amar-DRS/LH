//
//  MyAccountViewController.h
//  LearningHouse
//
//  Created by Amar DRS on 8/8/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "ChangePasswordViewController.h"
#import "EditBillingAddress.h"
#import "MyAccountMenuController.h"
#import "RightMenuViewController.h"

@interface MyAccountViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myAccountTitle;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UILabel *myProfilLab;
@property (weak, nonatomic) IBOutlet UILabel *billingLab;
@property (weak, nonatomic) IBOutlet UILabel *shippingLAB;
@property (weak, nonatomic) IBOutlet UIScrollView *landingScrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *emailLab;
- (IBAction)rightMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userNamLab;
- (IBAction)changePassword:(id)sender;
- (IBAction)editAddress:(id)sender;
- (IBAction)editshipingAddress:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UITextView *billingAddressLab;
@property (strong, nonatomic) IBOutlet UITextView *shippingAddressLab;


//@property (strong, nonatomic) IBOutlet UILabel *billingAddressLab;
//@property (strong, nonatomic) IBOutlet UILabel *shippingAddressLab;
@property(strong,nonatomic)NSString*myAccount;
@property(strong,nonatomic)NSString*backtoHome;


@end
