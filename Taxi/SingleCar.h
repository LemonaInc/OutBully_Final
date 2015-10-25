//
//  SingleCar.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
@interface SingleCar : UIViewController{
    NSArray *allItems;
    NSMutableArray *displayItems;
    NSString *dateStr;
    NSDictionary *results;
    NSFetchRequest *fetchRequest;
}
@property (strong, nonatomic) IBOutlet UIImageView *maps;
- (IBAction)backView:(id)sender;
- (IBAction)goHome:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *singleCarRating;
@property (nonatomic,strong)TQStarRatingView *starRatingView;
- (IBAction)addtofav:(id)sender;
@property (assign) NSString *temp;
@property (assign) NSString *stack;

@property (strong, nonatomic) IBOutlet UILabel *rent;

@property (strong, nonatomic) IBOutlet UIImageView *mainPicture;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumber;

@property (strong, nonatomic) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UILabel *details;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *carNumber;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property(nonatomic, retain) UIFont *font;

- (IBAction)bookacar:(id)sender;
- (IBAction)callNow:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *rentBg;


@end
