//
//  CustomCell.h
//  PebbleEmergencyApp
//
//  Created by Jasper Davey on 4/2/16.
//  Copyright © 2016 Jasper Davey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *doctorImage;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;

@end
