//
//  FNFHospitalCheckInViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/23/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "FNFHospitalCheckInViewController.h"
#import "FNFInsuranceBackendHelper.h"
#import "FNFAppDelegate.h"
#import "PulsingHaloLayer.h"
#import "UIViewController+ENPopUp.h"
#import "AMSmoothAlertView.h"
#import <Parse/Parse.h>

@interface FNFHospitalCheckInViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIViewController *beaconPopUp;
    AMSmoothAlertView * alert;

}
@property (weak, nonatomic) IBOutlet UITextField *dependentNameField;
@property (strong, nonatomic) UIPickerView *dependentsPicker;
@property (weak, nonatomic) IBOutlet UILabel *policyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLabel;
@end

@implementation FNFHospitalCheckInViewController

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

    //self.title = @"Confirm Details";
    
    UIBarButtonItem *cancel =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = cancel;
    
    self.policyNameLabel.text = [NSString stringWithFormat:@"%@-%@",[self.policyDictionary objectForKey:@"policyName"],[self.policyDictionary objectForKey:@"policyNumber"]];
    
    self.dependentsPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    [self.dependentsPicker setDataSource: self];
    [self.dependentsPicker setDelegate: self];
    self.dependentsPicker.showsSelectionIndicator = YES;
    self.dependentNameField.inputView = self.dependentsPicker;
    
    UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame:
                            CGRectMake(0,0, 320, 44)]; //should code with variables to support view resizing
    UIBarButtonItem *doneButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(inputAccessoryViewDidFinish)];
    //using default text field delegate method here, here you could call
    //myTextField.resignFirstResponder to dismiss the views
    [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
    myToolbar.tintColor = [UIColor colorWithRed:0.096 green:0.714 blue:0.286 alpha:1.000];
    self.dependentNameField.inputAccessoryView = myToolbar;
    
    
    // Do any additional setup after loading the view.
}

- (void)inputAccessoryViewDidFinish
{
    [self.dependentNameField setText: [NSString stringWithFormat:@"%@ %@",[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:[self.dependentsPicker selectedRowInComponent:0]] objectForKey:@"firstName"],[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:[self.dependentsPicker selectedRowInComponent:0]] objectForKey:@"lastName"]]];
    
    [self.dependentNameField resignFirstResponder];
}

- (IBAction)checkInClicked:(id)sender {
    
    FNFAppDelegate *appDelegate = (FNFAppDelegate *)[[UIApplication sharedApplication]delegate];
    //change to dependents minor
    
    NSString *UUID = [[PFUser currentUser] objectForKey:@"userUUID"];
    
    int major = [[self.policyDictionary objectForKey:@"policyMajor"] integerValue];
    int minor = [[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:[self.dependentsPicker selectedRowInComponent:0]] objectForKey:@"dependentMinor"] integerValue];
    
    appDelegate.beaconCheckInHelper = [[FNFBeaconCheckinAdvertiser alloc]initWithProximityID:@"com.cognizantenterprisemobility.fitnfine" andIdentifier:UUID majorValue:major andMinorValue:minor];
    
    [appDelegate.beaconCheckInHelper startCheckInProcess];
    
    beaconPopUp = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"beaconCheckIN"];
    beaconPopUp.view.frame = CGRectMake(0, 0, 270.0f, 230.0f);
    [self presentPopUpViewController:beaconPopUp];


    PulsingHaloLayer *layer = [PulsingHaloLayer layer];
    layer.radius = 130.;
    
    UIView *contentView = [beaconPopUp.view viewWithTag:410];
    [contentView.layer insertSublayer:layer atIndex:0];
    layer.position = contentView.center;

    [self performSelector:@selector(stopCheckInProcess) withObject:nil afterDelay:10];
}

- (void)stopCheckInProcess
{
    __weak typeof(self) weakSelf = self;

    [self dismissPopUpViewControllerWithcompletion:^{
       
        alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Success" andText:[NSString stringWithFormat:@"You've just Checked into Apollo Hospitals Chennai With Policy ID %d for %@ %@!",[[self.policyDictionary objectForKey:@"policyNumber"] integerValue],[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:[self.dependentsPicker selectedRowInComponent:0]] objectForKey:@"firstName"],[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:[self.dependentsPicker selectedRowInComponent:0]] objectForKey:@"lastName"]] andCancelButton:NO forAlertType:AlertSuccess];
        
        alert.animationType = FadeInAnimation;
        [alert.defaultButton setTitle:@"Ok" forState:UIControlStateNormal];
        alert.completionBlock = ^void (AMSmoothAlertView *alertObj, UIButton *button) {
            if(button == alertObj.defaultButton) {
                NSLog(@"Default");
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    
                }];
            } else {
                NSLog(@"Others");
            }
        };
        [alert show];


    }];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
       
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[FNFInsuranceBackendHelper sharedHelper]getDependents].count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@ %@",[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:row] objectForKey:@"firstName"],[[[[FNFInsuranceBackendHelper sharedHelper]getDependents] objectAtIndex:row] objectForKey:@"lastName"]];
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
