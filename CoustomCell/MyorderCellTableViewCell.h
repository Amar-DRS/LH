//
//  MyorderCellTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 8/25/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyorderCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIButton *viewAllBtn;

@end
