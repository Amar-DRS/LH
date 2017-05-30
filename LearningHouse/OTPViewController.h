//
//  OTPViewController.h
//  LearningHouse
//
//  Created by Alok Singh on 6/29/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"
#import "HomeViewController.h"


@interface OTPViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
@property(strong,nonatomic)NSString*customerID;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *otpTextField;
@property (strong, nonatomic) NSString *messageStr;
@property (strong, nonatomic) NSString *forgetpassword;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;



@property (strong, nonatomic) IBOutlet UILabel *messageLab;
- (IBAction)verifyOTP:(id)sender;
- (IBAction)reSendOtp:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *reSendOtpBtn;

@end
