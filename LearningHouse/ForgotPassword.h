//
//  ForgotPassword.h
//  LearningHouse
//
//  Created by Alok Singh on 8/4/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "OTPViewController.h"

@interface ForgotPassword : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backBtn:(id)sender;
- (IBAction)forgotPassworsBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *emailText;
@end
