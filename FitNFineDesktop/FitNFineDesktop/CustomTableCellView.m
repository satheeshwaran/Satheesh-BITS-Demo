//
//  CustomTableCellView.m
//  Fit&Fine
//
//  Created by Naveen on 24/08/14.
//  Copyright (c) 2014 Cognizant Technology Solutions. All rights reserved.
//

#import "CustomTableCellView.h"

@implementation CustomTableCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    self.identifier = @"TheCell";
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
