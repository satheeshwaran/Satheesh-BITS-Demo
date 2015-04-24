//
//  FNFSignUpViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "FNFSignUpViewController.h"
#import "BarCodeScanner.h"
#import "AMSmoothAlertView.h"

@interface FNFSignUpViewController ()<BarCodeScannerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *policyNumber;
@property(nonatomic,strong)BarCodeScanner *barCodeScanner ;
@end

@implementation FNFSignUpViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)barCodeButtonClicked:(id)sender {
    
    self.barCodeScanner = [[BarCodeScanner alloc]init];
    self.barCodeScanner.delegate = self;
    [self.barCodeScanner scanBarCode:self];
}
- (IBAction)cancelButtonClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneButtonClicked:(id)sender {
    AMSmoothAlertView *alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"SignUp" andText:@"Please check your email for login credentials!" andCancelButton:NO forAlertType:AlertSuccess];
    alert.animationType = FadeInAnimation;
    [alert.defaultButton setTitle:@"Ok" forState:UIControlStateNormal];
    alert.completionBlock = ^void (AMSmoothAlertView *alertObj, UIButton *button) {
        if(button == alertObj.defaultButton) {
            [self.navigationController popViewControllerAnimated:YES];

            NSLog(@"Default");
        } else {
            NSLog(@"Others");
        }
    };
    [alert show];
}


- (void)scanCompleted:(NSString *)data andScannedImage:(UIImage *)image
{
    self.policyNumber.text = data;
  //  [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
