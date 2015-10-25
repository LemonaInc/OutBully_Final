//
//  MyOrder.m
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import "MyOrder.h"
#import "MHNibTableViewCell.h"
#import "MyOrderCell.h"
#import "Home.h"
#import "SMBInternetConnectionIndicator.h"
#import "MBProgressHUD.h"
@interface MyOrder ()
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@end

@implementation MyOrder
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    // Do any additional setup after loading the view from its nib.
    
    networkReachability = [Reachability reachabilityForInternetConnection];
    networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        CGRect screenRect                   = CGRectMake(0, 10, 320, 30);
        self.internetConnectionIndicator    = [[SMBInternetConnectionIndicator alloc] initWithFrame:screenRect];
        [self.view addSubview:_internetConnectionIndicator];
        allItems = 0;
        
    } else
        if (networkStatus == ReachableViaWiFi || networkStatus == ReachableViaWWAN) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSLog(@"There IS internet connection");
            NSString *u = [Base_Url stringByAppendingString:viewUserOrder];
            NSString *str = [u stringByAppendingString:passUdid];
            NSURL *url = [NSURL URLWithString:str];
            NSData *myNSData = [NSData dataWithContentsOfURL:url];
            NSError *error = nil;
            allItems = [[NSArray alloc] init];
            //str = Base_Urls;
            allItems = [NSJSONSerialization JSONObjectWithData:myNSData options:kNilOptions error:&error];
                NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:myNSData options: NSJSONReadingMutableContainers error:NULL];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    NSError *error=nil;
                    allItems = responseDictionary;
                    displayItems = [NSJSONSerialization JSONObjectWithData:myNSData options:kNilOptions error:&error];
                    [tableView reloadData];
                });
            });
        }

}
- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [allItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 111.0f;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *simpleTableIdentifier = @"Cell";
    
	MyOrderCell *cell = (MyOrderCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyOrderCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
    //if no internet
    
    if (networkStatus == NotReachable) {
        NSLog(@"No internet");
    } else
        if (networkStatus == ReachableViaWiFi || networkStatus == ReachableViaWWAN){
            cell.carNumber.text = [[allItems objectAtIndex:indexPath.row] objectForKey:@"carNumber"];
            cell.orderStatus.text = [[allItems objectAtIndex:indexPath.row] objectForKey:@"status"];
            if ([cell.orderStatus.text isEqualToString:@"Confirmed"]) {
                cell.statusImg.image = [UIImage imageNamed:@"sucess.png"];
            } else
                if ([cell.orderStatus.text isEqualToString:@"Pending"]) {
                       cell.statusImg.image = [UIImage imageNamed:@"warning.png"];
                }
                else if ([cell.orderStatus.text isEqualToString:@"Under Review"]){
                    cell.statusImg.image = [UIImage imageNamed:@"underReview.png"];
                }
            cell.date.text = [[allItems objectAtIndex:indexPath.row] objectForKey:@"date"];
            cell.orderId.text = [[allItems objectAtIndex:indexPath.row] objectForKey:@"Pid"];
        }
    return cell;
}

- (IBAction)back:(id)sender {
    Home *go = [[Home alloc] initWithNibName:@"Home" bundle:nil];
    [self presentViewController:go animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Home:(id)sender {
    Home *go = [[Home alloc] initWithNibName:@"Home" bundle:nil];
    [self presentViewController:go animated:NO completion:nil];
}


@end
