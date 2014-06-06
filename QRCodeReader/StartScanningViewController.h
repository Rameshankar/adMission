//
//  StartScanningViewController.h
//  QRCodeReader
//
//  Created by Sankar on 06/06/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartScanningViewController : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UILabel *soundLabel;
@property (weak, nonatomic) IBOutlet UILabel *startScanningLabel;
@property (weak, nonatomic) IBOutlet UILabel *continuousScanningLabel;

- (IBAction)sound:(id)sender;
- (IBAction)startScanning:(id)sender;
- (IBAction)continuousScanning:(id)sender;

@end
