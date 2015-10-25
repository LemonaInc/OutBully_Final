//
//  Home.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home : UIViewController
- (IBAction)BookNow:(id)sender;
- (IBAction)MyOrder:(id)sender;
- (IBAction)callUs:(id)sender;
- (IBAction)feedback:(id)sender;
- (IBAction)contactUs:(id)sender;
- (IBAction)aboutUs:(id)sender;
- (IBAction)Favourite:(id)sender;
extern NSString *Base_Url;
extern NSString *parse;
extern NSString *images;
extern NSString *singleCar;
extern NSString *postUrl;
extern NSString *postOrder;
@end
