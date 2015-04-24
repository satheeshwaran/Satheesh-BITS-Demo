//
//  CustomTableCellView.h
//  Fit&Fine
//
//  Created by Naveen on 24/08/14.
//  Copyright (c) 2014 Satheeshwaran Technology Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomTableCellView : NSTableCellView
@property (weak) IBOutlet NSTextFieldCell *userNameTextFieldLabel;
@property (weak) IBOutlet NSTextFieldCell *policyTextFieldLabel;
@property (weak) IBOutlet NSTextFieldCell *userNameLabel;
@property (weak) IBOutlet NSTextFieldCell *checkInDate;
@end
