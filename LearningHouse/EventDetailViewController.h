//
//  EventDetailViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/16/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"

@interface EventDetailViewController : UIViewController<UIWebViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *eventDetailWebView;
@property(strong,nonatomic)NSString*eventTitle;
@property(strong,nonatomic)NSString*idAarticle;

@property (strong, nonatomic) IBOutlet UILabel *eventTitleLab;


@end
