//
//  Home.m
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import "Home.h"
#import "CarList.h"
#import "MyOrder.h"
#import "SMBInternetConnectionIndicator.h"

@interface Home ()
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@end

@implementation Home
Reachability *networkReachability;
NetworkStatus *networkStatus;
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
#pragma Generate UDID
	NSManagedObjectContext *context = [self managedObjectContext];
	NSError *error = nil;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription
	                               entityForName:@"UDID" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
	for (NSManagedObject *info in fetchedObjects) {
		NSLog(@"GOT ID: %@", [info valueForKey:@"id"]);
		passUdid = [info valueForKey:@"id"];
	}
    
	if ([fetchedObjects count] == nil) {
		NSString *uuid = [[NSUUID UUID] UUIDString];
		NSLog(@"Got It = %@", uuid);
        
		// Create a new device
		NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"UDID" inManagedObjectContext:context];
		[newDevice setValue:uuid forKey:@"id"];
		passUdid = uuid;
	}
    
    
	// Save the object to persistent store
	if (![context save:&error]) {
		NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
	}
    
    
    // Do any additional setup after loading the view from its nib.
    networkReachability = [Reachability reachabilityForInternetConnection];
    networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        CGRect screenRect                   = CGRectMake(0, 10, 320, 30);
        self.internetConnectionIndicator    = [[SMBInternetConnectionIndicator alloc] initWithFrame:screenRect];
        [self.view addSubview:_internetConnectionIndicator];
    }
    else if (networkStatus == ReachableViaWiFi || networkStatus == ReachableViaWWAN){
        NSLog(@"Internet Connected");
        NSLog(@"Base Url = %@", Base_Url);
        //Base_Urls = @"http://krazyidea.com/food/read_feedback.php";
    }

}

- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BookNow:(id)sender {
    CarList *go1 = [[CarList alloc] initWithNibName:@"CarList" bundle:nil];
	[self presentViewController:go1 animated:YES completion:nil];
}

- (IBAction)MyOrder:(id)sender {
    MyOrder *go = [[MyOrder alloc] initWithNibName:@"MyOrder" bundle:nil];
    [self presentViewController:go animated:NO completion:nil];
}

- (IBAction)callUs:(id)sender {
    //NSString *call = [[allItems objectAtIndex:0] objectForKey:@"driverNum"];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:2135554321"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call" message:@"720-263-8201" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    alert.delegate = self;
    [alert show];
}






- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0){
        NSLog(@"Cancel");
    }else
        if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:720-263-8201"]];
           
        }
}

@end
