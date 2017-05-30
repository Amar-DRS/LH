//
//  MyOrder.h
//  LearningHouse
//
//  Created by Alok Singh on 8/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "MyorderCellTableViewCell.h"
#import "ViewDetailViewController.h"

@interface MyOrder : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;
@property(strong,nonatomic) NSString*backtoController;
@property (strong, nonatomic) IBOutlet UITableView *myorderTable;

@end
