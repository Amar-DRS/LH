//
//  EventsViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/11/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "EventCellTableViewCell.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "EventCellTableViewCell.h"
#import "EventDetailViewController.h"


@interface EventsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *eventTable;
@end
