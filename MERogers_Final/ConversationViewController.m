//
//  ConversationViewController.m
//  MERogers_Final
//
//  Created by Max Rogers on 11/24/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import "ConversationViewController.h"
#import "YouChatCell.h"
#import "ThemChatCell.h"
#import "AFNetworking/AFNetworking.h"
#import "InboxViewController.h"
#import "UserViewController.h"

@interface ConversationViewController ()

@end

@implementation ConversationViewController

//UINavistuff
-(IBAction)goToUserProfile:(id)sender{
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    [preferences setInteger:_user_id forKey:@"target_user_id"];
    
    UserViewController *viewController = (UserViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(IBAction)goInbox:(id)sender{
    InboxViewController *viewController = (InboxViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

//Web stuff
-(IBAction)sendMessage:(id)sender{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue], @"other_id": [NSNumber numberWithInt:(int)_user_id], @"data":_messageField.text};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://localhost:9292/send_message" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            _messages = [NSMutableArray array];
            [self getConversation];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }
}

-(void)getConversation{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue], @"other_id": [NSNumber numberWithInt:(int)_user_id]};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://localhost:9292/conversation" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Raw: %@", responseObject);
            [_messages addObjectsFromArray: (NSArray *) responseObject];
            //NSDictionary *json = (NSDictionary *) responseObject;
            //NSLog(@"Json: %@", _messages);
            [_messageTable reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }

}

//TableViewSTuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *MyIdentifier = @"MyReuseIdentifier";
    
    
    ChatCell *cell;
    
    NSDictionary *message = (NSDictionary *)[_messages objectAtIndex:indexPath.row];
    
    if([(NSNumber *)[message objectForKey:@"sending_user_id"] compare: [NSNumber numberWithInt:_user_id]]){
        //if they are from them do a YouChatCell
        //NSLog(@"Its from them");
        cell = (YouChatCell *) [tableView dequeueReusableCellWithIdentifier:@"YouChatCell"];
    }else{
        //if it is from you do a ThemChatCell
        //NSLog(@"Its from you");
        cell = (ThemChatCell *) [tableView dequeueReusableCellWithIdentifier:@"ThemChatCell"];
        
    }
    cell.message.text = [message objectForKey:@"data"];
    return cell;
}

//Default stuff

- (void)viewDidLoad {
    [super viewDidLoad];
    _messages = [NSMutableArray array];
    //change title to other user's name
    _navBar.topItem.title = _otherName;
    
    // Do any additional setup after loading the view.
    //NSLog(@"%d",_user_id);
    [self getConversation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
