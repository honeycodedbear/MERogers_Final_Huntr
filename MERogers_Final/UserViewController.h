//
//  UserViewController.h
//  MERogers_Final
//
//  Created by Max Rogers on 11/18/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"

@interface UserViewController : UIViewController
@property IBOutlet UITextView *blurbView;
@property IBOutlet UILabel *nameLabel;
@property IBOutlet UILabel *locationLabel;
@property IBOutlet UILabel *typeLabel;
@property IBOutlet UILabel *skill1Label;
@property IBOutlet UILabel *skill2Label;
@property IBOutlet UILabel *skill3Label;
@property IBOutlet UILabel *skill4Label;
@property IBOutlet UILabel *skill5Label;
@property IBOutlet UILabel *skill6Label;
@property IBOutlet UILabel *githubLabel;
@property IBOutlet UILabel *personalLabel;
@property IBOutlet UILabel *employerLabel;
@property IBOutlet UIImageView *profileImage;
@property IBOutlet NSString *targetUserId;
//swipedLeft
//swipedRight
-(IBAction)backToProfile:(id)sender;
-(IBAction)goInbox:(id)sender;
@end
