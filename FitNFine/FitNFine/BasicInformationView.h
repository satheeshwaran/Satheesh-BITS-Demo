//
//  BasicInformationView.h
//  FitNFine
//
//  Created by Karthik Prabhu Alagu on 22/08/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A3ParallaxScrollView.h"

@interface BasicInformationView : UIView
@property (weak, nonatomic) IBOutlet A3ParallaxScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *firstNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *lastNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *ageDOBTextField;
@property (weak, nonatomic) IBOutlet UILabel *PANIDTextField;
@property (weak, nonatomic) IBOutlet UILabel *communicationAddressTextField;
@property (weak, nonatomic) IBOutlet UILabel *permanentAddressTextField;
@property (weak, nonatomic) IBOutlet UILabel *mobileTextField;
@property (weak, nonatomic) IBOutlet UILabel *landlineTextField;
@property (weak, nonatomic) IBOutlet UILabel *emailTextField;
@property (weak, nonatomic) IBOutlet UILabel *maritalTextField;
@property (weak, nonatomic) IBOutlet UILabel *kidsTextField;
@property (weak, nonatomic) IBOutlet UILabel *fpassportNumberTextField;
@end
