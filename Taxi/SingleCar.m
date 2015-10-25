//
//  SingleCar.m
//  Taxi
//
 //9/3/14.
//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import "SingleCar.h"
#import "Home.h"
#import "SMBInternetConnectionIndicator.h"
#import "AsyncImageView.h"
#import "CSNotificationView.h"
#import "OrderForm.h"
#import "CarList.h"
#import "MBProgressHUD.h"

@interface SingleCar ()
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@property (nonatomic, strong) CSNotificationView* permanentNotification;
@property(nonatomic) UIEdgeInsets contentEdgeInsets;
@end

@implementation SingleCar
@synthesize starRatingView;
@synthesize singleCarRating;
Reachability *networkReachability;
NetworkStatus *networkStatus;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    //_ba.contentEdgeInsets = UIEdgeInsetsMake(18, 33, 64, 33);
    networkReachability = [Reachability reachabilityForInternetConnection];
    networkStatus = [networkReachability currentReachabilityStatus];
    _maps.layer.cornerRadius = 35.0f;
	_maps.layer.masksToBounds = YES;
	_maps.layer.borderWidth = 2.0f;
    _maps.layer.borderColor = [UIColor colorWithRed:0.00784 green:0.53725 blue:0.96863 alpha:1].CGColor;
    
    _rentBg.layer.cornerRadius = 35.0f;
	_rentBg.layer.masksToBounds = YES;
	_rentBg.layer.borderWidth = 2.0f;
    _rentBg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // Do any additional setup after loading the view from its nib.
    starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 60, 12)numberOfStar:5];
    [self.starRatingView setScore:1 withAnimation:YES];
	[singleCarRating addSubview:starRatingView];
    
    //Current Date & Time
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *now1 = [[NSDate alloc] init];
	dateStr = [format stringFromDate:now1];
    
    networkReachability = [Reachability reachabilityForInternetConnection];
    networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        CGRect screenRect                   = CGRectMake(0, 10, 320, 30);
        self.internetConnectionIndicator    = [[SMBInternetConnectionIndicator alloc] initWithFrame:screenRect];
        [self.view addSubview:_internetConnectionIndicator];
        
    } else
        if (networkStatus == ReachableViaWiFi || networkStatus == ReachableViaWWAN) {
            NSLog(@"There IS internet connection");
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

            NSString *pid = [NSString stringWithFormat:@"%@", _temp];
            NSString *u = [Base_Url stringByAppendingString:singleCar];
            NSString *str = [u stringByAppendingString:pid];
            NSURL *url = [NSURL URLWithString:str];
            NSData *myNSData = [NSData dataWithContentsOfURL:url];
            NSError *error = nil;
            allItems = [[NSArray alloc] init];
            //str = Base_Urls;
            allItems = [NSJSONSerialization JSONObjectWithData:myNSData options:kNilOptions error:&error];
            NSString *img = [[allItems objectAtIndex:0] objectForKey:@"taxiImg"];
            NSString *conc = [NSString stringWithFormat:@"%@%@%@",Base_Url,images,img];
            _mainPicture.imageURL = [NSURL URLWithString:conc];
            
            
//            AsyncImageView *Load_Image=[[AsyncImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 173)];
//            Load_Image.imageURL=[NSURL URLWithString:conc];
//            Load_Image.showActivityIndicator=YES;
//            [_mainPicture addSubview:Load_Image];
            
            _address.text = [[allItems objectAtIndex:0] objectForKey:@"address"];
            _phoneNumber.text = [[allItems objectAtIndex:0] objectForKey:@"driverNum"];
            _details.text = [[allItems objectAtIndex:0] objectForKey:@"any_other_desc"];
            _email.text = [[allItems objectAtIndex:0] objectForKey:@"email"];
            _carNumber.text = [[allItems objectAtIndex:0] objectForKey:@"taxinum"];
            _rent.text = [[allItems objectAtIndex:0] objectForKey:@"rent"];
            NSString *stat = [[allItems objectAtIndex:0] objectForKey:@"availability"];
            if ([stat isEqualToString:@"Available"]) {
                _status.text = [[allItems objectAtIndex:0] objectForKey:@"availability"];
                _status.textColor = [UIColor greenColor];
            } else
                if ([stat isEqualToString:@"Pending"]) {
                    _status.text = [[allItems objectAtIndex:0] objectForKey:@"availability"];
                    _status.textColor = [UIColor yellowColor];
                    //_status.backgroundColor = [UIColor lightGrayColor];
                }
            else if ([stat isEqualToString:@"Not Available"]){
                _status.text = [[allItems objectAtIndex:0] objectForKey:@"availability"];
                _status.textColor = [UIColor redColor];
                [self.status setFont:[UIFont italicSystemFontOfSize:13.0f]];
                
            }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSError *error=nil;
                });
            });
        }
}
- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}


//s
#pragma Add to order Button
- (IBAction)bookacar:(id)sender {

    OrderForm *go1 = [[OrderForm alloc] initWithNibName:@"OrderForm" bundle:nil];
    go1.pid = [[allItems objectAtIndex:0] objectForKey:@"P_ID"];
    go1.carNum = [[allItems objectAtIndex:0] objectForKey:@"taxinum"];
    [self presentViewController:go1 animated:NO completion:nil];
//    OrderForm *go = [[OrderForm alloc] initWithNibName:@"OrderForm" bundle:nil];
//    [self presentViewController:go animated:NO completion:nil];
//    
//    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert"
//                                                   message:@"Are you sure ?"
//                                                  delegate:self
//                                         cancelButtonTitle:@"No"
//                                         otherButtonTitles:@"Yes",
//                         nil];
//    alert.delegate = self;
    //[alert show];
    
}

- (IBAction)callNow:(id)sender {
    
    //Not calling directly
        NSString *call = [[allItems objectAtIndex:0] objectForKey:@"driverNum"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2135554321"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:call delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    alert.delegate = self;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //s
    //cancel for 2 alertview optios start
//    if (buttonIndex == 1)
//    {
//        NSLog(@"ok");
//        NSURL *url;
//        NSString *call;
//        switch (alertView.tag) {
//            default:
//            case 1:
//                call = [[allItems objectAtIndex:0] objectForKey:@"driverNum"];
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:call]];
//                break;
//            case 2:
//                url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel://%@", secondnumber]];
//                break;
//        }
//        [[UIApplication sharedApplication] openURL:url];
//        [url release];
//    }
//    else
//    {
//        NSLog(@"cancel");
//    }
    //cancel for 2 alertview optios end
    //e
    if (buttonIndex == 0){
        NSLog(@"Cancel");
    }else
        if (buttonIndex == 1) {
        NSString *tel = @"tel:";
        NSString *call = [[allItems objectAtIndex:0] objectForKey:@"driverNum"];
            call = [tel stringByAppendingString:call];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:call]];
        //Not storing in sqlite
//        NSManagedObjectContext *context = [self managedObjectContext];
//        NSError *error=nil;
//        NSManagedObject *neworder = [NSEntityDescription insertNewObjectForEntityForName:@"MyBooking" inManagedObjectContext:context];
//        [neworder setValue:[[allItems objectAtIndex:0]objectForKey:@"P_ID"] forKey:@"pid"];
//        [neworder setValue:[[allItems objectAtIndex:0]objectForKey:@"taxinum"] forKey:@"carid"];
//        [neworder setValue:@"Confirm" forKey:@"status"];
//        [CSNotificationView showInViewController:self
//                                       tintColor:[UIColor greenColor]
//                                           image:[UIImage imageNamed:@"sucess"]
//                                         message:@"Order Confirmed !"
//                                        duration:2.0f];
//        
//        [self.permanentNotification setShowingActivity:YES];
//        if (![context save:&error]) {
//            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//        }
        //e
    }
}

//- (IBAction)buttonAddToFavourite:(id)sender {
//    int count = 0;
//    NSManagedObjectContext *context = [self managedObjectContext];
//    NSError *error=nil;
//    NSManagedObject *addToFav = [NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:context];
//    NSString *dish = [results objectForKey:@"id"];
//    fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"Favourite" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
//    //s
//    
//    for (NSManagedObject *info in fetchedObjects) {
//        NSString *id1 = [info valueForKey:@"dishid"];
//        
//        if ([id1 isEqualToString:dish]) {
//            count = count +1;
//        }
//    }
//    if (count == 0) {
//        [addToFav setValue:[results objectForKey:@"id"] forKey:@"dishid"];
//        [CSNotificationView showInViewController:self
//                                       tintColor:[UIColor greenColor]
//                                           image:[UIImage imageNamed:@"sucess"]
//                                         message:@"Saved As Favourite."
//                                        duration:2.0f];
//        
//        [self.permanentNotification setShowingActivity:YES];
//        
//    }
//    else if (count > 0){
//        [CSNotificationView showInViewController:self
//                                       tintColor:[UIColor redColor]
//                                           image:[UIImage imageNamed:@"warning"]
//                                         message:@"Dish Already Added."
//                                        duration:2.0f];
//        
//        [self.permanentNotification setShowingActivity:YES];
//        
//    }
//    for (NSManagedObject *info in fetchedObjects) {
//        NSString *removeDish = [info valueForKey:@"dishid"];
//        if (removeDish == nil) {
//            [context deleteObject:info];
//        }
//    }
//    //e
//    
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
//    
//}

//e

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backView:(id)sender {
//    CarList *go1 = [[CarList alloc] initWithNibName:@"CarList" bundle:nil];
//	[self presentViewController:go1 animated:NO completion:nil];

    if ([_stack  isEqualToString:@"CarList"]){
        CarList *go1 = [[CarList alloc] initWithNibName:@"CarList" bundle:nil];
        [self presentViewController:go1 animated:NO completion:nil];
        
    }
}

- (IBAction)goHome:(id)sender {
    Home *go1 = [[Home alloc] initWithNibName:@"Home" bundle:nil];
	[self presentViewController:go1 animated:NO completion:nil];
}
//- (IBAction)bookacar:(id)sender {
//}
- (IBAction)addtofav:(id)sender {
    int count = 0;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSError *error=nil;
    NSManagedObject *addToFav = [NSEntityDescription insertNewObjectForEntityForName:@"Favourite" inManagedObjectContext:context];
    NSString *car = [[allItems objectAtIndex:0] objectForKey:@"P_ID"];
    fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Favourite" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    //s
    
    for (NSManagedObject *info in fetchedObjects) {
        NSString *id1 = [info valueForKey:@"carid"];
        
        if ([id1 isEqualToString:car]) {
            count = count +1;
        }
    }
    if (count == 0) {
        NSString *saveId =[[allItems objectAtIndex:0] objectForKey:@"P_ID"];
        [addToFav setValue:saveId forKey:@"carid"];
        [CSNotificationView showInViewController:self
                                       tintColor:[UIColor greenColor]
                                           image:[UIImage imageNamed:@"sucess"]
                                         message:@"Saved As Favourite."
                                        duration:1.5f];
        
        [self.permanentNotification setShowingActivity:YES];
        
    }
    else if (count > 0){
        [CSNotificationView showInViewController:self
                                       tintColor:[UIColor redColor]
                                           image:[UIImage imageNamed:@"warning"]
                                         message:@"Car Already Added."
                                        duration:1.5f];
        
        [self.permanentNotification setShowingActivity:YES];
        
    }
    for (NSManagedObject *info in fetchedObjects) {
        NSString *removeDish = [info valueForKey:@"carid"];
        if (removeDish == nil) {
            [context deleteObject:info];
        }
    }
    //e
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
@end
