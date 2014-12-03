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

-(IBAction)goInbox:(id)sender{
    InboxViewController *viewController = (InboxViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)profilePicBrowser{
    NSLog(@"Change Pic");
    /*
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"ProfileImagePicker"
                                                       message:@"Please pick the source of the image"
                                                      delegate:self
                                             cancelButtonTitle:@"MyIphone"
                                             otherButtonTitles:nil];
    //[theAlert addButtonWithTitle:@"URL"];
    [theAlert show];
     */
    [self pickImageFromPhone];
}

- (void)alertView:(UIAlertView *)theAlert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"The %@ button was tapped.", [theAlert buttonTitleAtIndex:buttonIndex]);
    if([[theAlert buttonTitleAtIndex:buttonIndex] isEqualToString:@"MyIphone"]){
        [self pickImageFromPhone];
    }
    /*
    else{
        NSLog(@"Handle Image Download nonsense");
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"ImageURL" message:@"" delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
    }
     */
}

-(void)pickImageFromPhone{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    _profileImage.image = (UIImage*) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue]};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSData *dataImage = UIImagePNGRepresentation(_profileImage.image);
    [manager POST:@"http://104.131.171.242/save_image" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:dataImage name:@"image"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(IBAction)goHunting:(id)sender{
    UserViewController *viewController = (UserViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"UserViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(IBAction)updateToServer:(id)sender{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        NSString *isEmployer;
        if([_employerSwitch isOn]){
            isEmployer = @"true";
        }else{
            isEmployer = @"false";
        }
        NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue], @"dev_type": _typeField.text, @"name": _nameField.text, @"location": _locationField.text, @"blurb": _blurbView.text , @"skill1": _skill1Field.text, @"skill2": _skill2Field.text, @"skill3": _skill3Field.text, @"skill4": _skill4Field.text, @"skill5": _skill5Field.text, @"skill6": _skill6Field.text, @"github": _githubField.text, @"personal": _personalField.text, @"employer":  isEmployer};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://104.131.171.242/update_user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *json = (NSDictionary *) responseObject;
            NSLog(@"Message: %@", json);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }
}


//DEFAULT STUFF

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    NSString* loggedInUserIdKey = @"loggedInUserId";
    if([preferences objectForKey:loggedInUserIdKey] != nil)
    {
        //move onto profile page
        NSDictionary *parameters = @{@"user_id": [[preferences objectForKey:loggedInUserIdKey] stringValue]};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://104.131.171.242/user" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *json = (NSDictionary *) responseObject;
            NSLog(@"Message: %@", json);
            if(![[json objectForKey:@"location"] isKindOfClass:[NSNull class]]){
                _locationField.text = [json objectForKey:@"location"];
            }
            if(![[json objectForKey:@"name"] isKindOfClass:[NSNull class]]){
                _nameField.text = [json objectForKey:@"name"];
            }
            if(![[json objectForKey:@"dev_type"] isKindOfClass:[NSNull class]]){
                _typeField.text = [json objectForKey:@"dev_type"];
            }
            if(![[json objectForKey:@"blurb"] isKindOfClass:[NSNull class]]){
                _blurbView.text = [json objectForKey:@"blurb"];
            }
            if(![[json objectForKey:@"personal"] isKindOfClass:[NSNull class]]){
                _personalField.text = [json objectForKey:@"personal"];
            }
            if(![[json objectForKey:@"github"] isKindOfClass:[NSNull class]]){
                _githubField.text = [json objectForKey:@"github"];
            }
            if(![[json objectForKey:@"skill1"] isKindOfClass:[NSNull class]]){
                _skill1Field.text = [json objectForKey:@"skill1"];
            }
            if(![[json objectForKey:@"skill2"] isKindOfClass:[NSNull class]]){
                _skill2Field.text = [json objectForKey:@"skill2"];
            }
            if(![[json objectForKey:@"skill3"] isKindOfClass:[NSNull class]]){
                _skill3Field.text = [json objectForKey:@"skill3"];
            }
            if(![[json objectForKey:@"skill4"] isKindOfClass:[NSNull class]]){
                _skill4Field.text = [json objectForKey:@"skill4"];
            }
            if(![[json objectForKey:@"skill5"] isKindOfClass:[NSNull class]]){
                _skill5Field.text = [json objectForKey:@"skill5"];
            }
            if(![[json objectForKey:@"skill6"] isKindOfClass:[NSNull class]]){
                _skill6Field.text = [json objectForKey:@"skill6"];
            }
            if(![[json objectForKey:@"skill6"] isKindOfClass:[NSNull class]]){
                _skill6Field.text = [json objectForKey:@"skill6"];
            }
            if(![[json objectForKey:@"profile_img"] isKindOfClass:[NSNull class]]){
                NSLog(@"RETRIEVE IMAGE");
                NSString *urlString = [NSString stringWithFormat:@"http://104.131.171.242/get_image?user_id=%@", [json objectForKey:@"id"] ] ;
                [_profileImage setImageWithURL:[NSURL URLWithString:urlString]];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profilePicBrowser)];
    singleTap.numberOfTapsRequired = 1;
    
    [_profileImage setUserInteractionEnabled:YES];
    [_profileImage addGestureRecognizer:singleTap];
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
