//
//  LoginViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 6/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "OTPViewController.h"
#import "HomeViewController.h"
#import "ForgotPassword.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userNameText;
- (IBAction)backBtn:(id)sender;
- (IBAction)loginBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *passwordtext;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property(strong,nonatomic)NSString*rightORleftMenu;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)forgotPassword:(id)sender;

- (IBAction)registerBtn:(id)sender;
@end
