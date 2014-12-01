//
//  ConversationViewController.h
//  MERogers_Final
//
//  Created by Max Rogers on 11/24/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property long user_id;
@property NSString *otherName;
@property NSMutableArray *messages;
@property IBOutlet UITableView *messageTable;
@property IBOutlet UIButton *sendBtn;
@property IBOutlet UITextField *messageField;
-(IBAction)sendMessage:(id)sender;
@end
