//
//  ViewAllTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 7/26/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAllTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *viewAllImage;
@property (strong, nonatomic) IBOutlet UILabel *titlelab;
@property (strong, nonatomic) IBOutlet UILabel *productCode;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;
@property (strong, nonatomic) IBOutlet UILabel *availabilityLab;
@property (strong, nonatomic) IBOutlet UILabel *priceSale;
@property (strong, nonatomic) IBOutlet UIImageView *hardBook;
@property (strong, nonatomic) IBOutlet UIImageView *eBook;
@property (strong, nonatomic) IBOutlet UIImageView *mp3;
@property (strong, nonatomic) IBOutlet UIImageView *disk;

@end
