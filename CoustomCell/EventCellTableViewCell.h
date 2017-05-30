//
//  EventCellTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 8/11/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InnerTableCell.h"
#import "historyModel.h"

@interface EventCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UIButton *eventDetalBtn;

@end
