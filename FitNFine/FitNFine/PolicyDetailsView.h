//
//  PolicyDetailsView.h
//  FitNFine
//
//  Created by Karthik Prabhu Alagu on 22/08/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PolicyDetailsView : UIView
{
    
}
@property (nonatomic,weak) IBOutlet UILabel *policyNumberLabel;
@property (nonatomic,weak) IBOutlet UILabel *policyNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *policyAmountLabel;
@property (nonatomic,weak) IBOutlet UILabel *premiumAmountLabel;
@property (nonatomic,weak) IBOutlet UILabel *policyStartDataLabel;
@property (nonatomic,weak) IBOutlet UILabel *planLabel;
@property (nonatomic,weak) IBOutlet UILabel *planTypeLabel;
@property (nonatomic,weak) IBOutlet UILabel *agencyIdLabel;
@property (nonatomic,weak) IBOutlet UILabel *nomineeLabel;
@property (nonatomic,weak) IBOutlet UILabel *namineeRelationshipLabel;
@end
