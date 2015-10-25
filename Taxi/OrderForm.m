//
//  OrderForm.m
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import "OrderForm.h"
#import "Home.h"
#import "CarList.h"
#import "CSNotificationView.h"
@interface OrderForm ()
@property (nonatomic, strong) CSNotificationView* permanentNotification;
@end

@implementation OrderForm

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
    
    //Current Date & Time
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *now1 = [[NSDate alloc] init];
	dateStr = [format stringFromDate:now1];
    NSString *p_id = [NSString stringWithFormat:@"%@", _pid];
    NSString *car_num = [NSString stringWithFormat:@"%@", _carNum];
    carnumber.text = car_num;
    txtEmail.delegate = self;
    address.delegate = self;
    txtName.delegate = self;
    email.delegate = self;
    phone.delegate = self;
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated
{
    srcScrollView.contentSize = CGSizeMake(320, 568);
    
    [super viewWillAppear:YES];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [srcScrollView setContentOffset:CGPointMake(0,textField.center.y-71) animated:YES];//you can set your  y cordinate as your req also
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [srcScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    
    
    return YES;
}

//s
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    if (textField==address)
//    {
//        [self keyBoardAppeared];
//    }
//    return true;
//}
//
//-(void)textFieldDidEndEditing:(UITextField *)textField {
//    if (textField==address)
//    {
//        [self keyBoardDisappeared];
//    }
//}
//
//-(void) keyBoardAppeared
//{
//    CGRect frame = self.view.frame;
//    
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options: UIViewAnimationCurveEaseOut
//                     animations:^{
//                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y-415, frame.size.width, frame.size.height);
//                     }
//                     completion:^(BOOL finished){
//                         
//                     }];
//}
//
//-(void) keyBoardDisappeared
//{
//    CGRect frame = self.view.frame;
//    
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options: UIViewAnimationCurveEaseOut
//                     animations:^{
//                         self.view.frame = CGRectMake(frame.origin.x, frame.origin.y+215, frame.size.width, frame.size.height);
//                     }
//                     completion:^(BOOL finished){
//                         
//                     }];
//}
//e
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)orderNow:(id)sender {
    
    NSString *m = txtEmail.text;
    NSString *n = txtName.text;
    NSString *a = address.text;
    NSString *e = email.text;
    NSString *p = phone.text;
    NSString *uid = passUdid;
    
    if ([m isEqualToString:@""] || [n isEqualToString:@""] || [a isEqualToString:@""] || [e isEqualToString:@""] || [p isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"All fields are must to fill." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
    }
    else
        if ((![m isEqualToString:@""] && ![n isEqualToString:@""]) && ![a isEqualToString:@""] && ![e isEqualToString:@""] && ![p isEqualToString:@""]){
            
                NSString *ordrMain=[NSString stringWithFormat:@"%@%@%@?name=%@&address=%@&email=%@&phone=%@&cmnt=%@&date=%@&uid=%@&carNum=%@",Base_Url,postUrl,postOrder,n,a,e,p,m,dateStr,passUdid,_carNum];
                NSString* urlTextEscaped = [ordrMain stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSURL *urls=[NSURL URLWithString:urlTextEscaped];
                NSData *myNSData=[NSData dataWithContentsOfURL:urls];
            
            txtEmail.text = nil;
            txtName.text = nil;
            address.text = nil;
            email.text = nil;
            phone.text = nil;
            [CSNotificationView showInViewController:self
                                           tintColor:[UIColor blueColor]
                                               image:[UIImage imageNamed:@"sucess"]
                                             message:@"Report Sent !"
                                            duration:2.0f];
            
            [self.permanentNotification setShowingActivity:YES];
    }
    

    
    [txtEmail resignFirstResponder];
    [txtName resignFirstResponder];
    [address resignFirstResponder];
    [email resignFirstResponder];
    [phone resignFirstResponder];
    [srcScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    
}

- (IBAction)home:(id)sender {
    Home *go = [[Home alloc] initWithNibName:@"Home" bundle:nil];
    [self presentViewController:go animated:NO completion:nil];
}

- (IBAction)back:(id)sender {
    CarList *go = [[CarList alloc] initWithNibName:@"CarList" bundle:nil];
    [self presentViewController:go animated:NO completion:nil];
}
@end
