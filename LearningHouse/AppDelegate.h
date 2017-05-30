//
//  AppDelegate.h
//  LearningHouse
//
//  Created by Alok Singh on 7/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "RightMenuViewController.h"
#import "LeftMenuViewController.h"
#import "MyAccountViewController.h"
#import "MyAccountMenuController.h"
#import "DBManager.h"

#define Window_Height [AppDelegate appDelegate].window.frame.size.height
#define Window_Width [AppDelegate appDelegate].window.frame.size.width
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DBManager *dbManager;



+(AppDelegate *)appDelegate;
-(void)showHomeScreen;

@end

