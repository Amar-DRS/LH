//
//  MenuSubCategoriesViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/1/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "RightMenuViewController.h"
#import "SubCategoriesTableViewCell.h"
#import "ViewAllViewController.h"


@interface MenuSubCategoriesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSString* parientId;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UITableView *subCategoryTable;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic)  NSString *codeCatalog;
@property (strong, nonatomic)  NSString *rightORleftMenu;
@property (strong, nonatomic)  NSString *viewAllRigthMenu;




@end
