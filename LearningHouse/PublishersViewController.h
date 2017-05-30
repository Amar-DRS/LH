//
//  PublishersViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/17/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "ViewAllViewController.h"
#import "InnerTableCell.h"
#import "DBManager.h"



@interface PublishersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *pubilisherTable;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic)  DBManager *dbManager;


@end
