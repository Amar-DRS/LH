//
//  LeftMenuViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 7/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuTableViewCell.h"
#import "MenuSubCategoriesViewController.h"
#import "historyModel.h"
#import "leftMenuSubCategoryViewController.h"
#import "AboutLearningHouse.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "MyAccountViewController.h"
#import "EventsViewController.h"
#import "PublishersViewController.h"

@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *leftMenuTable;
@end
