//
//  ViewController.m
//  MERogers_Final
//
//  Created by Max Rogers on 11/18/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

-(IBAction)login:(id)sender{    
    NSLog(@"%@ : %@", _email.text, _password.text );
    
    NSDictionary *parameters = @{@"email": _email.text, @"password": _password.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://104.236.200.152/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = (NSDictionary *) responseObject;
        NSLog(@"Message: %@", json[@"message"]);
        if([json[@"message"] isEqualToString:@"Success"]){
            NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
            NSString* loggedInUserIdKey = @"loggedInUserId";
            const NSInteger loggedInUserId =  [json[@"user_id"] integerValue];
            [preferences setInteger:loggedInUserId forKey:loggedInUserIdKey];
            //  Save to disk
            const BOOL didSave = [preferences synchronize];
            
            if(!didSave)
            {
                //  Couldn't save (I've never seen this happen in real world testing)
                NSLog(@"Couldn't save user_id");
            }
            
            ProfileViewController *profileController = (ProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
            [self presentViewController:profileController animated:YES completion:nil];
        }else{
            NSLog(@"Failure to login");
            _errorLabel.text = @"Failure. Please check your email/password";
        }        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(IBAction)signup:(id)sender{
    
    // Check to see if it's NOT blank
    if(![_email.text isEqualToString:@""] && ![_password.text isEqualToString:@""] ) {
        NSLog(@"%@ : %@", _email.text, _password.text );
        
        NSDictionary *parameters = @{@"email": _email.text, @"password": _password.text};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://104.236.200.152/signup" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *json = (NSDictionary *) responseObject;
            NSLog(@"Message: %@", json[@"message"]);
            if([json[@"message"] isEqualToString:@"Success"]){
                NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
                NSString* loggedInUserIdKey = @"loggedInUserId";
                const NSInteger loggedInUserId =  [json[@"user_id"] integerValue];
                [preferences setInteger:loggedInUserId forKey:loggedInUserIdKey];
                //  Save to disk
                const BOOL didSave = [preferences synchronize];
                
                if(!didSave)
                {
                    //  Couldn't save (I've never seen this happen in real world testing)
                    NSLog(@"Couldn't save user_id");
                }
                ProfileViewController *profileController = (ProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                [self presentViewController:profileController animated:YES completion:nil];
            }else{
                NSLog(@"Failure to login");
                _errorLabel.text = @"Failure. Email is already registered";
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
        _errorLabel.text = @"Please fill out the form";
    }
}

/*

- (void)load
{
    //Build URL
    NSURL *myURL = [NSURL URLWithString:@"http://localhost:4567/"];
    //Build Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    //Set HTTPMethod
    [request setHTTPMethod:@"POST"];
    //Build the Parameters
    NSString * parameters = [NSString stringWithFormat:@"email=%@&password=%@",_email.text,_password.text];
    NSData *requestData = [NSData dataWithBytes:[parameters UTF8String] length:[parameters length]];
    //Add Parameters to Request
    [request setHTTPBody:requestData];
    //Send Request
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _responseData = nil;
    connection = nil;
    //[textView setString:@"Unable to fetch data"];
    NSLog(@"Unable to fetch data");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"Success! Received %lu bytes of data",(unsigned long)[_responseData length]);
    NSString *txt = [[NSString alloc] initWithData:_responseData encoding: NSASCIIStringEncoding];
    NSLog(@"%@",txt);
}


*/

//Old Stuff

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    /*
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        ProfileViewController *profileController = (ProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        [self presentViewController:profileController animated:YES completion:nil];
    }
     */
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
