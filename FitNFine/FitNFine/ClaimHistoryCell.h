//
//  ClaimHistoryCell.h
//  FitNFine
//
//  Created by Naveen on 23/08/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClaimHistoryCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *hospitalNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *policyIdLabel;
@property (nonatomic,weak) IBOutlet UILabel *customerNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *billAmountLabel;
@property (nonatomic,weak) IBOutlet UILabel *addmittedDateLabel;
@property (nonatomic,weak) IBOutlet UILabel *dischargeDateLabel;
@property (nonatomic,weak) IBOutlet UILabel *statusLabel;
@end
