//
//  MyOrder.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrder : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *tableView;
    __weak IBOutlet UIButton *back;
    __weak IBOutlet UIButton *home;
    NSArray *allItems;
    NSMutableArray *displayItems;
}
- (IBAction)Home:(id)sender;
- (IBAction)back:(id)sender;

@end
