//
//  ProfileViewController.h
//  MERogers_Final
//
//  Created by Max Rogers on 11/18/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserViewController.h"
#import "ViewController.h"

@interface ProfileViewController : UIViewController
@property IBOutlet UILabel *profileLabel;
@property IBOutlet UITextField *nameField;
@property IBOutlet UITextField *locationField;
@property IBOutlet UITextField *typeField;
@property IBOutlet UITextField *skill1Field;
@property IBOutlet UITextField *skill2Field;
@property IBOutlet UITextField *skill3Field;
@property IBOutlet UITextField *skill4Field;
@property IBOutlet UITextField *skill5Field;
@property IBOutlet UITextField *skill6Field;
@property IBOutlet UITextField *githubField;
@property IBOutlet UITextField *personalField;
@property IBOutlet UISwitch *employerSwitch;
@property IBOutlet UIImageView *profileImage;
@property IBOutlet UITextView *blurbView;
@property IBOutlet UITableView *skillsTable;
-(void)profilePicBrowser;
-(IBAction)goHunting:(id)sender;
-(IBAction)updateToServer:(id)sender;
@end
