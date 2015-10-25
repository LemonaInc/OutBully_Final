//
//  CarList.m
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import "CarList.h"
#import "MHNibTableViewCell.h"
#import "Home.h"
#import "CarListCell.h"
#import "SingleCar.h"
#import "MBProgressHUD.h"
#import "SMBInternetConnectionIndicator.h"
#import "AFURLConnectionOperation.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLRequestSerialization.h"
#import "UIKit+AFNetworking/UIImageView+AFNetworking.h"
//#import "SDWebImage/UIImageView+WebCache.h"

#import "AsyncImageView.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIImageView+WebCache.h"
@interface CarList ()
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@end

@implementation CarList
@synthesize starRatingView;
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
    [back addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[home addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
    
    networkReachability = [Reachability reachabilityForInternetConnection];
    networkStatus = [networkReachability currentReachabilityStatus];
    allItems = [[NSMutableArray alloc] init];
    displayItems = [[NSMutableArray alloc] init];
    
    
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
                    // Do something...
                    NSString *str=[NSString stringWithFormat:@"%@%@",Base_Url,parse];
                    NSURL *url=[NSURL URLWithString:str];
                    NSData *myNSData=[NSData dataWithContentsOfURL:url];
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
        
        [self.view addSubview:_internetConnectionIndicator];
        //in
           
    
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
	return 91.0f;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *simpleTableIdentifier = @"Cell";
    #define IMAGE_VIEW_TAG 99
	CarListCell *cell = (CarListCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
	if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CarListCell" owner:self options:nil];
		cell = [nib objectAtIndex:0];
	}
    //if no internet
    if (networkStatus == NotReachable) {
        NSLog(@"No internet");
    } else
        if (networkStatus == ReachableViaWiFi || networkStatus == ReachableViaWWAN){
            //NSLog(@"Here Comes");
        cell.desc.text = [[allItems objectAtIndex:indexPath.row] objectForKey:@"any_other_desc"];
        
        cell.rent.text = [[allItems objectAtIndex:indexPath.row] objectForKey:@"rent"];
        NSString *img = [[allItems objectAtIndex:indexPath.row] objectForKey:@"taxiImg"];
        NSString *conc = [NSString stringWithFormat:@"%@%@%@",Base_Url,images,img];
        //cell.imageCarList.imageURL = [NSURL URLWithString:conc];
            cell.imageCarList.layer.cornerRadius = 37.5f;
            cell.imageCarList.layer.masksToBounds = YES;
            cell.imageCarList.layer.borderWidth = 1.0f;
            cell.imageCarList.layer.borderColor = [UIColor colorWithRed:0.00784 green:0.53725 blue:0.96863 alpha:1].CGColor;;
            AsyncImageView *Load_Image=[[AsyncImageView alloc]initWithFrame:CGRectMake(-12, -12, 100, 100)];
            Load_Image.imageURL=[NSURL URLWithString:conc];
            Load_Image.showActivityIndicator=YES;
            [cell.imageCarList addSubview:Load_Image];

        NSString *status = [[allItems objectAtIndex:indexPath.row] objectForKey:@"availability"];
        NSString *chk = @"Available";
            UIImage *customImage = [UIImage imageWithContentsOfFile:@"not-available.png"];
            if ([status isEqualToString:chk]) {
                cell.availability.image = [UIImage imageNamed:@"now-available.png"];
            }
            else if ([status isEqualToString:@"Pending"]){
                cell.availability.image = [UIImage imageNamed:@"Pending.png"];
            }
            else if ([status isEqualToString:@"Not Available"]){
                cell.availability.image = [UIImage imageNamed:@"not-available.png"];
            }
            //cell.textLabel.text = @"Working some how";
       
        
        starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 60, 12)numberOfStar:5];
        [self.starRatingView setScore:1 withAnimation:YES];
        [cell.ratingView addSubview:starRatingView];
            [starRatingView setUserInteractionEnabled:NO];
        }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        CGRect screenRect                   = CGRectMake(0, 10, 320, 30);
        self.internetConnectionIndicator    = [[SMBInternetConnectionIndicator alloc] initWithFrame:screenRect];
        [self.view addSubview:_internetConnectionIndicator];

    } else {
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"There IS internet connection");
        SingleCar *go1 = [[SingleCar alloc] initWithNibName:@"SingleCar" bundle:nil];
        go1.temp = [[allItems objectAtIndex:indexPath.row] objectForKey:@"P_ID"];
        go1.stack = @"CarList";
        [self presentViewController:go1 animated:YES completion:nil];
          //  dispatch_async(dispatch_get_main_queue(), ^{
            //    [MBProgressHUD hideHUDForView:self.view animated:YES];
              //  NSError *error=nil;
            //});
        //});
    }
}

- (IBAction)buttonPressed:(UIButton *)sender {
	Home *go1 = [[Home alloc] initWithNibName:@"Home" bundle:nil];
	[self presentViewController:go1 animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
