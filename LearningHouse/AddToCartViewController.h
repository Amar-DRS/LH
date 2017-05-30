//
//  AddToCartViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/16/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "AatoCartTableViewCell.h"
#import "CheckOutViewController.h"

@interface AddToCartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *addtoCartTable;
- (IBAction)checkOut:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *totalBtn;

@property(strong,nonatomic)NSString*backController;
@property (strong, nonatomic) IBOutlet UIImageView *buttonBackgroundView;

@end
