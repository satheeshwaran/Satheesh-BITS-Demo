//
//  ScannerClass.m
//  Scanner
//
//  Created by Preethi on 28/05/13.
//  Copyright (c) 2013 CTS. All rights reserved.
//

#import "BarCodeScanner.h"
@interface BarCodeScanner()
{
    UIImageView *resultImage;
    UITextView *resultText;
}
@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextView *resultText;
@end
@implementation BarCodeScanner
@synthesize resultImage,resultText;

/*!
 On calling this method, the camera scans the barcode.

 */

-(void)scanBarCode:(UIViewController *)viewController
{
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [viewController presentViewController:reader animated:YES completion:NULL];
}


/*!
 After completion of scanning this method will return scanned data nd image to the scanCompleted delegate .
 
 */

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;

    // EXAMPLE: do something useful with the barcode data
    resultText.text = symbol.data;
    
    // EXAMPLE: do something useful with the barcode image
    resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissViewControllerAnimated:YES completion:^{ [_delegate scanCompleted:symbol.data andScannedImage:[info objectForKey: UIImagePickerControllerOriginalImage]];}];
    
 // [_delegate scanCompleted:symbol.data andScannedImage:[info objectForKey: UIImagePickerControllerOriginalImage]];
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [_delegate scanDidCancel];
}
@end
