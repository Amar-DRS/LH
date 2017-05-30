//
//  AatoCartTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 8/17/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "historyModel.h"

@interface AatoCartTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lab1;
@property (strong, nonatomic) IBOutlet UIImageView *cartImage;
@property (strong, nonatomic) IBOutlet UILabel *authorLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *totalLab;
@property (strong, nonatomic) IBOutlet UILabel *itemQtyLab;
@property (strong, nonatomic) IBOutlet UIButton *removeBtn;
@property (strong, nonatomic) IBOutlet UIButton *updateBtn;
@property (strong, nonatomic) IBOutlet UIButton *plus;
- (IBAction)plus:(id)sender;
- (IBAction)minus:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *eBook;
@property (strong, nonatomic) IBOutlet UIImageView *mp3;
@property (strong, nonatomic) IBOutlet UIImageView *disk;

@property (strong, nonatomic) IBOutlet UIImageView *hardBook;

@property (strong, nonatomic) IBOutlet UILabel *salePrice;

@property (strong, nonatomic) IBOutlet UIButton *minus;
@end
