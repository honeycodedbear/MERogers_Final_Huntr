//
//  InboxViewController.m
//  MERogers_Final
//
//  Created by Max Rogers on 11/24/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import "InboxViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController{
    NSArray *recipes;
}

-(IBAction)backToProfile:(id)sender{
    ProfileViewController *viewController = (ProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

// UITable Stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}

//ServerQueryStuff
-(NSArray *)getConversations{
    NSArray *results;
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue]};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://localhost:9292/inbox_users" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *json = (NSDictionary *) responseObject;
            NSLog(@"Message: %@", json);
            NSLog(@"Raw: %@",responseObject);
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

    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
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
