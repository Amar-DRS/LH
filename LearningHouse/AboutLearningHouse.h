//
//  AboutLearningHouse.h
//  LearningHouse
//
//  Created by Alok Singh on 8/2/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"



@interface AboutLearningHouse : UIViewController<UIWebViewDelegate>
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIWebView *aboutLHWebView;
@property(strong,nonatomic)NSString*aboutROcontect;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
