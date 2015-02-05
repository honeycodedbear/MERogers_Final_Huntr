//
//  InboxViewController.m
//  MERogers_Final
//
//  Created by Max Rogers on 11/24/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import "InboxViewController.h"
#import "ConversationViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController{
    NSArray *recipes;
    NSArray *results;
    NSMutableArray *user_names;
    NSMutableArray *user_ids;
}

-(IBAction)backToProfile:(id)sender{
    ProfileViewController *viewController = (ProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

// UITable Stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"UserNames.Count: %lu", (unsigned long)[user_names count]);
    return [user_names count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [user_names objectAtIndex:indexPath.row];
    NSString *urlString = [NSString stringWithFormat:@"http://104.236.200.152/get_image?user_id=%@", [user_ids objectAtIndex:indexPath.row] ] ;
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:urlString]];
    //cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    //[messageAlert show];
    
    //identify which row this is
    //get that user id
    //[user_ids objectAtIndex:indexPath.row];
    
    //open the conversation controller and pass that number over to it
    
    ConversationViewController *viewController = (ConversationViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ConversationViewController"];
    viewController.user_id = [[user_ids objectAtIndex:indexPath.row] integerValue];
    viewController.otherName = [user_names objectAtIndex:indexPath.row];
    [self presentViewController:viewController animated:YES completion:nil];
}

//ServerQueryStuff
-(NSArray *)getConversations{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue]};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://104.236.200.152/inbox_users" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"Raw: %@", responseObject);
           // NSDictionary *json = (NSDictionary *) responseObject;
           // NSLog(@"Json: %@", json);
            results = (NSArray *) responseObject;
            //NSLog(@"LOAD ALL THE THINGS");
            for (NSArray *entry in results){
                [user_names addObject: [entry objectAtIndex: 1]];
                [user_ids addObject: [entry objectAtIndex: 0]];
                //NSLog(@"%@",[user_names lastObject]);
            }
            [_inboxTable reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }
    return results;
}

//Default Stuff

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    user_names = [NSMutableArray array];
    user_ids = [NSMutableArray array];
    [self getConversations];
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
