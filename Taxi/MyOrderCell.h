//
//  MyOrderCell.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *carNumber;
@property (strong, nonatomic) IBOutlet UILabel *orderStatus;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *orderId;
@property (strong, nonatomic) IBOutlet UIImageView *statusImg;

@end
