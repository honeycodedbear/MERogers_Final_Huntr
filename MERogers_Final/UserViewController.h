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
@property IBOutlet UILabel *positionLabel;
@property IBOutlet UILabel *levelLabel;

//swipedLeft
//swipedRight
-(IBAction)backToProfile:(id)sender;
@end
