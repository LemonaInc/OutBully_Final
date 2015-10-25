//
//  Common.h
//  Rest
//
//  Copyright (c)Jaxon Stevens All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Common : UIViewController{
    
    
    __weak IBOutlet UIButton *button_custom_url;
    __weak IBOutlet UIButton *demo_data;

}

extern NSString *Base_Url;
extern NSString *images;
extern NSString *singleCar;
extern NSString *postUrl;
extern NSString *parse;
extern NSString *postOrder;
extern NSString *passUdid;
extern NSString *viewUserOrder;

@property (nonatomic, weak) IBOutlet UIButton *demo_data;
@property (weak, nonatomic) IBOutlet UIButton *button_custom_url;

- (IBAction)setting:(id)sender;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@end
