//
//  StartScanningViewController.m
//  QRCodeReader
//
//  Created by Sankar on 06/06/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "StartScanningViewController.h"

@interface StartScanningViewController ()

@end

@implementation StartScanningViewController

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
    
    self.soundLabel.font              = [UIFont fontWithName:@"OpenSans-CondensedLight" size:18];
    self.startScanningLabel.font      = [UIFont fontWithName:@"OpenSans-CondensedBold" size:21];
    self.continuousScanningLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:18];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startScanning:(id)sender {
   
}

- (IBAction)continuousScanning:(id)sender {
     NSLog(@"continuousScanning");
}

- (IBAction)sound:(id)sender {
     NSLog(@"soundScanning");
}
@end
