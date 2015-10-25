//
//  Common.m
//  Rest
//
//  Created by Jaxon Stevens on 10/23/15.
//  Copyright (c) 2014 Jaxon.Stevens. All rights reserved.
//

#import "Common.h"
#import "Reachability.h"
#import "CSNotificationView.h"
#import <SystemConfiguration/SystemConfiguration.h>
@interface Common (){
    Reachability *internetReachableFoo;
}
@property (nonatomic, strong) CSNotificationView *permanentNotification;
@end
@implementation Common
@synthesize demo_data;
@synthesize button_custom_url;

NSString *Base_Url = @"http://www.thesixmotifs.com";
NSString *parse = @"/carParse/allCars.php";
NSString *images = @"/uploads/";
NSString *singleCar = @"/carParse/singleCar.php?pid=";
NSString *postUrl = @"/PostUrls";
NSString *postOrder = @"/postOrder.php";
NSString *viewUserOrder = @"/carParse/viewUserOrder.php?uid=";

NSString *passUdid;

- (void)viewDidLoad {
    
    //    _text_demo_url.Placeholder = @"Required";
    [self setNeedsStatusBarAppearanceUpdate];
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)testInternetConnection
{
    
}

- (IBAction)setting:(id)sender {
    NSLog(@"Setting");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
    if (NotReachable == 0) {
        NSLog(@"Not Connected");
    }
}
@end
