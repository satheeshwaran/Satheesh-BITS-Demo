//
//  FNFRootViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "FNFRootViewController.h"
#import "UIViewController+XHLoadingNavigationItemTitle.h"
#import <MessageUI/MessageUI.h>
#import "FNFSettingsViewController.h"

@interface FNFRootViewController ()<RESideMenuDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation FNFRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startAnimationTitle];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    self.panFromEdge = YES;
    self.panGestureEnabled = YES;
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FNFLandingViewController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FNFLeftSidePaneViewController"];
    self.rightMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FNFRightSidePaneViewController"];
   // self.backgroundImage = [UIImage imageNamed:@"BG"];
    self.delegate = self;

}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (IBAction)showLeftMenu:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}
- (IBAction)showRightMenu:(id)sender {
    
    [self.sideMenuViewController presentRightMenuViewController];
}

- (void)contactUsClicked
{
    [self sendMailToRecipients:@[@"help@fitnfineinsurance.com"] withSubject:@"Insurance Enquiry From FitNFine App" andMessage:@"Enquiry About"];
}

#pragma mark -  Mail Sending helper methods

- (void)sendMailToRecipients:(NSArray *)recipients withSubject:(NSString *)subject andMessage:(NSString *)message
{
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            MFMailComposeViewController *mailController= [[MFMailComposeViewController alloc] init];
            
            [[mailController navigationBar] setTintColor:[UIColor blackColor]];
            
            mailController.mailComposeDelegate=self;
            
            [mailController setSubject:subject];
            
            if(recipients)
                [mailController setToRecipients:recipients];
            
            NSMutableString *mailbody  = [NSMutableString string];
            [mailbody appendString:message];
            
            [mailController setMessageBody:mailbody isHTML:NO];
            
            [self presentViewController:mailController animated:YES completion:NULL];
            
            mailController = nil;
        }
        else
        {
            [self launchMailAppOnDeviceWithSubject:subject AndMessage:message];
        }
    }
    
}


- (void)launchMailAppOnDeviceWithSubject:(NSString *)subject AndMessage:(NSString *)message
{
    
    NSMutableString *mailbody  = [NSMutableString string];
    [mailbody appendString:message];
    
    
    NSString *recipients = [NSString stringWithFormat:@"mailto:?&subject=%@!",subject];
    
    NSString *body = [NSString stringWithFormat:@"&body=%@!",mailbody];;
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

#pragma mark MFMailComposerDelegate Method

- (void)mailComposeController:(MFMailComposeViewController*)mailController didFinishWithResult:(MFMailComposeResult)result  error:(NSError*)error {
    UIAlertView *alert;
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
			
            break;
        case MFMailComposeResultSaved:
            
            break;
        case MFMailComposeResultSent:
        {
			NSLog(@"Result: sent");
            alert=[[UIAlertView alloc] initWithTitle: @"Mail sent" message:@"Mail successfully sent!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
			alert = nil;
        }
            break;
        case MFMailComposeResultFailed:
		{
            
            NSLog(@"Result: Failed");
            alert=[[UIAlertView alloc] initWithTitle:@"Failure"  message:@"Mail sending failed" delegate:self cancelButtonTitle: @"Ok" otherButtonTitles:nil];
            [alert show];
            alert = nil;
        }
            break;
        default:
			NSLog(@"Result: not sent");
            break;
    }
    [mailController dismissViewControllerAnimated:YES completion:NULL];
}


- (void)profileClicked
{
    //self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FNFSettingsViewController"];
}

- (void)logoutClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)settingsClicked
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
