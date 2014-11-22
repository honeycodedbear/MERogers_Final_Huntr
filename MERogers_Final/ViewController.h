//
//  ViewController.h
//  MERogers_Final
//
//  Created by Max Rogers on 11/18/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "UIKit+AFNetworking/UIKit+AFNetworking.h"
#import "Classes/JSONAPI.h"
#import "ProfileViewController.h"

@interface ViewController : UIViewController
@property NSMutableData *responseData;
@property IBOutlet UITextField *email;
@property IBOutlet UITextField *password;
@property IBOutlet UIButton *loginBtn;
@property IBOutlet UILabel *errorLabel;

-(IBAction)login:(id)sender;
-(IBAction)signup:(id)sender;
@end

