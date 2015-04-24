//
//  FNFLoginViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "FNFLoginViewController.h"
#import "AMSmoothAlertView.h"
#import <Parse/Parse.h>

@interface FNFLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation FNFLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.username.text= @"rachel";
    self.password.text = @"pass";
    
    [[NSUserDefaults standardUserDefaults]setObject:@"rachel" forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults]setObject:@"da24tg23" forKey:@"user_id"];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.username)
    {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
    }
    
    else if(textField == self.password)
    {
        [textField resignFirstResponder];
        [self loginButtonClicked:nil];
    }
    return YES;
}
-(IBAction)loginButtonClicked:(id)sender
{
    NSString* user = [self.username.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    NSString* pass = [self.password.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    [self.view endEditing:YES];
    
    
    if(user.length > 0 &&  pass.length > 0)
    {
        [self.loadingIndicator startAnimating];

        [PFUser logInWithUsernameInBackground:user password:pass block:^(PFUser *user, NSError *error) {
            
            [[NSUserDefaults standardUserDefaults]setObject:user.username forKey:@"user_name"];
            [[NSUserDefaults standardUserDefaults]setObject:user.objectId forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.loadingIndicator stopAnimating];

            if(!error && user.isAuthenticated)
            {
                self.password.text = @"";
                [self performSegueWithIdentifier:@"RootViewControllerSeague" sender:self];
            }
            
            else
            {
                AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Login Failure!!" andText:error.localizedDescription andCancelButton:NO forAlertType:AlertFailure];
                alert.animationType = FadeInAnimation;
                [alert.defaultButton setTitle:@"Ok" forState:UIControlStateNormal];
                alert.completionBlock = ^void (AMSmoothAlertView *alertObj, UIButton *button) {
                    if(button == alertObj.defaultButton) {
                        NSLog(@"Default");
                    } else {
                        NSLog(@"Others");
                    }
                };
                [alert show];

            }

        }];
        

    }
    else
    {
        AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Login Failure!!" andText:@"Enter valid credentials!" andCancelButton:NO forAlertType:AlertFailure];
        alert.animationType = FadeInAnimation;
        [alert.defaultButton setTitle:@"Ok" forState:UIControlStateNormal];
        alert.completionBlock = ^void (AMSmoothAlertView *alertObj, UIButton *button) {
            if(button == alertObj.defaultButton) {
                NSLog(@"Default");
            } else {
                NSLog(@"Others");
            }
        };
        [alert show];

    }
}


@end
