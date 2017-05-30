//
//  RegisterViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 8/3/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "OTPViewController.h"
#import "LoginViewController.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *fullname;
@property (strong, nonatomic) IBOutlet UITextField *emil;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confermpassword;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)loginBtn:(id)sender;
- (IBAction)registerBtn:(id)sender;

@end

