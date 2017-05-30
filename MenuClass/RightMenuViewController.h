//
//  RightMenuViewController.h
//  Patient'sAppointment
//
//  Created by Raj Kumar on 07/11/15.
//  Copyright (c) 2015 Raj Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "historyModel.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "MenuSubCategoriesViewController.h"


@interface RightMenuViewController : UIViewController
{
    IBOutlet UITableView *rightSideTable;
}

@property (nonatomic, strong) NSMutableArray *dataArray,*imageArray;

-(IBAction)clickOnViewProfileBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *categoriesLab;


@end
