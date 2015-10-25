//
//  CarListCell.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageCarList;
@property (strong, nonatomic) IBOutlet UIView *ratingView;
@property (strong, nonatomic) IBOutlet UILabel *desc;
@property (strong, nonatomic) IBOutlet UILabel *rent;
@property (strong, nonatomic) IBOutlet UIImageView *availability;


@end
