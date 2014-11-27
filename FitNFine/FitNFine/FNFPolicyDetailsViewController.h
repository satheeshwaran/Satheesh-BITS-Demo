//
//  FNFPolicyDetailsViewController.h
//  FitNFine
//
//  Created by Satheeshwaran on 8/22/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BasicInformationView;
@class DependentInformationView;
@class PolicyDetailsView;
@interface FNFPolicyDetailsViewController : UIViewController <UIScrollViewDelegate>
//basicinfo View
@property (weak, nonatomic) IBOutlet BasicInformationView *basicInformationView;
@property (weak, nonatomic) IBOutlet DependentInformationView *dependentInformationView;
@property (weak, nonatomic) IBOutlet PolicyDetailsView *policyDetailsInformationView;
//RN
@property (nonatomic, retain) NSMutableArray *contentArray;
@property (nonatomic, retain) NSMutableArray *policyDataArray;
@property (nonatomic, retain) NSMutableArray *dependentDetailArray;
@property (nonatomic, retain) NSMutableArray *claimDataArray;
//@property (nonatomic,weak) IBOutlet UIScrollView *userPictureScrollView;
//@property (nonatomic,weak) IBOutlet UIPageControl *pageControl;

@end
