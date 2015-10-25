//
//  OrderForm.h
//  Taxi
//

//  Copyright (c)Jaxon Stevens All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderForm : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *txtName;
    
    IBOutlet UITextField *email;
    
    IBOutlet UITextField *phone;
    
    IBOutlet UITextField *address;
    
    IBOutlet UITextField *txtEmail;
    IBOutlet UIScrollView *srcScrollView;
    NSString *dateStr;
    IBOutlet UILabel *carnumber;
}
- (IBAction)orderNow:(id)sender;

- (IBAction)home:(id)sender;
- (IBAction)back:(id)sender;
@property (assign) NSString *pid;
@property (assign) NSString *carNum;
@end
