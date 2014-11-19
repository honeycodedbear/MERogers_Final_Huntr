//
//  ProfileViewController.m
//  MERogers_Final
//
//  Created by Max Rogers on 11/18/14.
//  Copyright (c) 2014 Max Rogers. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


-(IBAction)goHunting:(id)sender{
    UserViewController *viewController = (UserViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

//DEFAULT STUFF

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
