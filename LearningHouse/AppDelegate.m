//
//  AppDelegate.m
//  LearningHouse
//
//  Created by Alok Singh on 7/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "AppDelegate.h"
#import "MyAccountViewController.h"
#import "PayPalMobile.h"
#import "MyWebServiceHelper.h"
#import "MyCustomClass.h"





@interface AppDelegate ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSDictionary* dic;
    NSArray*info;
    NSMutableArray *ProductResArr;
    NSMutableArray *CategoryResArr;
    NSMutableArray *PublisherResArr;
}
@end

@implementation AppDelegate

+(AppDelegate *)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
/*    NSString *HTML=@"<html><head></head><body><center>Thanks for shopping with us. Payment made through Credit Card has been successful.<span style=""color:#FFF;"">order_statusSuccessThanks for shopping with us. Payment made through Credit Card has been successful.</span></center></body></html>";
 */
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"LH.sqlite"];
    [NSThread sleepForTimeInterval:2.0]; // Used For Showing Splash Screen for More Time
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AcRoGcjfPo0UncmuMS8LdG0aP-6U8xPf7sQVGvGsN2lZkBdP-4G_MiblVTAFhLOvZN___sLMy6Sc2sp0",
                                                           PayPalEnvironmentSandbox : @"AV6XloTbuDybzgPQHNI5l_0LlDtrhiSvRnxLIOaB72Reoyq7iE7Duh9rqGTu7EK8K9QsY_cBxgUkhTJ0"}];
    
    
    if([GETVALUE(FirstTime)  isEqualToString:@"Completed"])
    {
        NSInteger HourDifferenc= [MyCustomClass getHoursDifference:[NSDate date] FromDate: GETVALUE(SyncDate)];
        if(HourDifferenc >=6)
        {
            ProductResArr = [[NSMutableArray alloc] init];
            CategoryResArr = [[NSMutableArray alloc] init];
            PublisherResArr = [[NSMutableArray alloc] init];
            
            NSString *LastSyncDate =[MyCustomClass setDateFormateWithDate:GETVALUE(SyncDate) dateFormate:@"YYYY-MM-dd HH:mm:ss"];
            dic=@{@"date_edited":LastSyncDate,@"mode":@"data_dump"};
           [self ShowCartData1:dic];
        }
        else
        {
            [self moveTOhomeVC];
        }
    }
 else
 {
     [self moveTOhomeVC];
 }

    
       // Override point for customization after application launch.
          return YES;
}
-(void)moveTOhomeVC
{
    HomeViewController*frontViewController = [[HomeViewController alloc] init];
    LeftMenuViewController*rearViewController=[[LeftMenuViewController alloc ]init];
    
    //
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    //   frontViewController.title = @"DASHBOARD";
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    revealController.delegate = self;
    revealController.panGestureRecognizer.enabled=NO;
    
    RightMenuViewController *rightViewController = rightViewController = [[RightMenuViewController alloc] init];
    //rightViewController.view.backgroundColor = [UIColor greenColor];
    revealController.rightViewController = rightViewController;
    [AppDelegate appDelegate].window.rootViewController =revealController;
    [[AppDelegate appDelegate].window makeKeyAndVisible];
    

}


-(void)ShowCartData1:(NSDictionary*)dataString
{
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    [helper Dump_Data:dataString];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
   NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"DumpData"])
    {

            
                NSArray *CategoryArr,*PublisherArr,*ProductArr;
                ProductArr = [dataDic objectForKey:@"CatalogProduct"];
                PublisherArr = [dataDic objectForKey:@"publisher"];
                CategoryArr = [dataDic objectForKey:@"category"];
                
                [self ProductCatalog:ProductArr];
                [self CategoryCatalog:CategoryArr];
                [self PublisherCatalog:PublisherArr];
//                if (ProductArr.count>0||PublisherArr.count>0||CategoryArr.count>0)
//                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SETVALUE([NSDate date], SyncDate); // Save date
                        [self moveTOhomeVC];
                        [MyCustomClass SVProgressMessageDismissWithSuccess:@"Success" timeDalay:1.0];
                    });
//                }
//                else
//                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        SETVALUE(@"Completed", FirstTime);
//                        SETVALUE([NSDate date], SyncDate); // Save date
//                        [self moveTOhomeVC];
//                        [MyCustomClass SVProgressMessageDismissWithSuccess:@"Success" timeDalay:1.0];
//                    });
//
//                  
//                }
        
    }
    
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *msg = [dataDic objectForKey:@"msg"];
                [MyCustomClass SVProgressMessageDismissWithError:msg timeDalay:3.0];
            });

           
        }
    }


-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknow Error" timeDalay:2.0];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)showHomeScreen {
    MyAccountViewController*frontViewController = [[MyAccountViewController alloc] init];

    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
   // frontViewController.title = @"DASHBOARD";
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:nil frontViewController:frontNavigationController];
    revealController.delegate = self;
    
    
    
    MyAccountMenuController *rightViewController = rightViewController = [[MyAccountMenuController alloc] init];
    //rightViewController.view.backgroundColor = [UIColor greenColor];
    
    revealController.rightViewController = rightViewController;
    [AppDelegate appDelegate].window.rootViewController =revealController;
    [[AppDelegate appDelegate].window makeKeyAndVisible];
}


-(void)ProductCatalog:(NSArray *)ProductArr
{
    if([ProductArr count]>0)
    {
        
        if([ProductArr count]>0)
        {
            for (NSInteger i=0; i<[ProductArr count]; i++) {
                
                NSString *query = [NSString stringWithFormat:@"insert or Replace into Products(ProdID,ProdName,ProdType) values( '%@','%@','%@')", [[ProductArr objectAtIndex:i] valueForKey:@"id"],[[ProductArr objectAtIndex:i] valueForKey:@"title"],[[ProductArr objectAtIndex:i] valueForKey:@"ptype"]];
              //  NSLog(@"Created Products query:%@",query);
                [self.dbManager executeQuery:query];
                
                
//                NSLog(@"loop Counter%ld",i);
//                // If the query was successfully executed then pop the view controller.
//                if (self.dbManager.affectedRows != 0) {
//                    NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//                    
//                }
//                else{
//                    NSLog(@"Could not execute the query.");
//                }
                
            }
            
        }
        
    }
    
}

-(void)CategoryCatalog:(NSArray *)CategoryArr
{
    if([CategoryArr count]>0)
    {
        for (NSInteger i=0; i<[CategoryArr count]; i++) {
            
            NSString *query = [NSString stringWithFormat:@"insert or Replace into Category(CatID,CatName,CatCode) values( '%@','%@','%@')", [[CategoryArr objectAtIndex:i] valueForKey:@"id"],
                               [[CategoryArr objectAtIndex:i] valueForKey:@"name_category"],
                               [[CategoryArr objectAtIndex:i] valueForKey:@"code_catalog"]];
           // NSLog(@"Created Category query:%@",query);
            [self.dbManager executeQuery:query];
            
            
//          //  NSLog(@"loop Counter%ld",i);
//            
//            // If the query was successfully executed then pop the view controller.
//            if (self.dbManager.affectedRows != 0) {
//                //NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//                
//            }
//            else{
//                NSLog(@"Could not execute the query.");
//            }
            
        }
        
    }
}


-(void)PublisherCatalog:(NSArray *)PublisherArr
{
    if([PublisherArr count]>0)
    {
        for (NSInteger i=0; i<[PublisherArr count]; i++) {
            
            NSString *query = [NSString stringWithFormat:@"insert or Replace into Publisher(PubID,PubName,PubCode) values( '%@','%@','%@')", [[PublisherArr objectAtIndex:i] valueForKey:@"id"],[[PublisherArr objectAtIndex:i] valueForKey:@"publisher"],[[PublisherArr objectAtIndex:i] valueForKey:@"code_publisher"]];
         //   NSLog(@"Created Publisher query:%@",query);
            [self.dbManager executeQuery:query];
            
            
//            NSLog(@"loop Counter%ld",i);
//            
//            // If the query was successfully executed then pop the view controller.
//            if (self.dbManager.affectedRows != 0) {
//                NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
//                
//            }
//            else{
//                NSLog(@"Could not execute the query.");
//            }
//            
        }
        
    }
    
}



@end
