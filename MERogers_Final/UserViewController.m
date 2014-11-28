//
//  UserViewController.m
//  MERogers_Final
//
//  Created by Max Rogers on 11/18/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    NSNumber *current_user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedInUserId"];
    NSDictionary *parameters = @{@"user_id": current_user_id};
    [self getRandomUserData:parameters];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backToProfile:(id)sender{
    ProfileViewController *profileController = (ProfileViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self presentViewController:profileController animated:YES completion:nil];

}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self denySwipe];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self approveSwipe];
    }
}

-(void)getRandomUserData:(NSDictionary *)parameters{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:9292/random_user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = (NSDictionary *) responseObject;
        
        NSLog(@"Message: %@", json);
        if(![[json objectForKey:@"location"] isKindOfClass:[NSNull class]]){
            _locationLabel.text = [json objectForKey:@"location"];
        }
        
        if(![[json objectForKey:@"name"] isKindOfClass:[NSNull class]]){
            _nameLabel.text = [json objectForKey:@"name"];
        }
        if(![[json objectForKey:@"dev_type"] isKindOfClass:[NSNull class]]){
            _typeLabel.text = [json objectForKey:@"dev_type"];
        }
        if(![[json objectForKey:@"blurb"] isKindOfClass:[NSNull class]]){
            _blurbView.text = [json objectForKey:@"blurb"];
        }
        if(![[json objectForKey:@"personal"] isKindOfClass:[NSNull class]]){
            _personalLabel.text = [json objectForKey:@"personal"];
        }
        if(![[json objectForKey:@"github"] isKindOfClass:[NSNull class]]){
            _githubLabel.text = [json objectForKey:@"github"];
        }
        if(![[json objectForKey:@"skill1"] isKindOfClass:[NSNull class]]){
            _skill1Label.text = [json objectForKey:@"skill1"];
        }
        if(![[json objectForKey:@"skill2"] isKindOfClass:[NSNull class]]){
            _skill2Label.text = [json objectForKey:@"skill2"];
        }
        if(![[json objectForKey:@"skill3"] isKindOfClass:[NSNull class]]){
            _skill3Label.text = [json objectForKey:@"skill3"];
        }
        if(![[json objectForKey:@"skill4"] isKindOfClass:[NSNull class]]){
            _skill4Label.text = [json objectForKey:@"skill4"];
        }
        if(![[json objectForKey:@"skill5"] isKindOfClass:[NSNull class]]){
            _skill5Label.text = [json objectForKey:@"skill5"];
        }
        if(![[json objectForKey:@"skill6"] isKindOfClass:[NSNull class]]){
            _skill6Label.text = [json objectForKey:@"skill6"];
        }
        if(![[json objectForKey:@"employer"] isKindOfClass:[NSNull class]]){
            if([[json objectForKey:@"employer"] isEqualToString:@"true"]){
                _employerLabel.text = @"Employer";
            }else{
                _employerLabel.text = @"Job Seeker";
            }
        }
        if(![[json objectForKey:@"profile_img"] isKindOfClass:[NSNull class]]){
            NSLog(@"RETRIEVE IMAGE");
            NSString *urlString = [NSString stringWithFormat:@"http://localhost:9292/get_image?user_id=%@", [json objectForKey:@"id"] ] ;
            [_profileImage setImageWithURL:[NSURL URLWithString:urlString]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

-(void)approveSwipe{
    NSLog(@"Swipe Right");
    NSNumber *current_user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedInUserId"];
    NSDictionary *parameters = @{@"user_id": current_user_id, @"approve": @"true"};
    [self getRandomUserData:parameters];
}

-(void)denySwipe{
    NSLog(@"Swipe Left");
    NSNumber *current_user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"loggedInUserId"];
    NSDictionary *parameters = @{@"user_id": current_user_id, @"approve": @"false"};
    [self getRandomUserData:parameters];
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
