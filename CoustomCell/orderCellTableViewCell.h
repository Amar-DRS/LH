//
//  orderCellTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 8/22/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ordertypeImage;
@property (strong, nonatomic) IBOutlet UILabel *orderLab;
@property (strong, nonatomic) IBOutlet UILabel *itemLab;
@property (strong, nonatomic) IBOutlet UILabel *eachLab;
@property (strong, nonatomic) IBOutlet UILabel *qtyLab;
@property (strong, nonatomic) IBOutlet UILabel *pticeLab;
@property (strong, nonatomic) IBOutlet UIImageView *hardBook;
@property (strong, nonatomic) IBOutlet UIImageView *eBook;
@property (strong, nonatomic) IBOutlet UIImageView *mp3;
@property (strong, nonatomic) IBOutlet UIImageView *disk;

@end
