//
//  HomeSearchViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/23/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "DBManager.h"
#import "define.h"





@interface HomeSearchViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UITableView *searchTable;
@property (strong, nonatomic) IBOutlet UIImageView *headerColour;
@property (strong, nonatomic)  DBManager *dbManager;


@end
