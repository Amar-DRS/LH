//
//  ViewAllViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 7/26/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAllTableViewCell.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"
#import "ProductAllDetailViewController.h"


@interface ViewAllViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) NSString*titleStr;
@property (strong, nonatomic) NSString*area;
@property (strong, nonatomic) IBOutlet UITableView *viewAllTable;
@property(strong,nonatomic)NSString* menuClass;
@property(strong,nonatomic)NSString* codeCategory;
@property(strong,nonatomic)NSString*publisher;






@end
