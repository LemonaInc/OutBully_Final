//
//  CarList.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
@interface CarList : UIViewController<UITableViewDelegate,  UITableViewDataSource>{
    IBOutlet UITableView *tableView;
    __weak IBOutlet UIButton *back;
    __weak IBOutlet UIButton *home;
    NSArray *allItems;
    NSMutableArray *displayItems;
    //NSData *myNSData;
    NSError *error;
}

@property (nonatomic,strong)TQStarRatingView *starRatingView;
@end
