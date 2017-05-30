//
//  AatoCartTableViewCell.m
//  LearningHouse
//
//  Created by Alok Singh on 8/17/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "AatoCartTableViewCell.h"

@implementation AatoCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lab1.numberOfLines = 0;
    
    // [self.lab1 sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)plus:(id)sender {
    
    int i = [self.itemQtyLab.text intValue];
    
    i++;
    
    self.itemQtyLab.text = [NSString stringWithFormat:@"%d", i];
    [historyModel sharedhistoryModel].counterValue=[NSString stringWithFormat:@"%d", i];
    
}

- (IBAction)minus:(id)sender {
    
    int i = [self.itemQtyLab.text intValue];
    
    i--;
    if (i >=1)
    {
        self.itemQtyLab.text = [NSString stringWithFormat:@"%d", i];
        [historyModel sharedhistoryModel].counterValue=[NSString stringWithFormat:@"%d", i];
    }
    else
    {
        [historyModel sharedhistoryModel].counterValue=[NSString stringWithFormat:@"%d",1];
        
    }
    
    
}
@end
