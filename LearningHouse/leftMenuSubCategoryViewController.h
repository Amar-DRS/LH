//
//  leftMenuSubCategoryViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/1/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"


@interface leftMenuSubCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *leftSubCategoryTable;
@property (strong, nonatomic)  NSString *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *SubCategorytitle;
@property (strong, nonatomic)  NSString *categoryId;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic)  NSString *rightORleftMenu;



@end
