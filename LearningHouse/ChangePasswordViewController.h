//
//  ChangePasswordViewController.h
//  LearningHouse
//
//  Created by Apple on 09/08/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "historyModel.h"
#import "MyCustomClass.h"
#import "MyWebServiceHelper.h"


@interface ChangePasswordViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameCoustomer;
@property (weak, nonatomic) IBOutlet UITextField *changePasword;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasword;
@property(strong,nonatomic) NSString*titleStr;
@property(strong,nonatomic)NSString*backtoController;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)saveBtn:(id)sender;
@end
