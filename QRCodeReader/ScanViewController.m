//
//  ScanViewController.m
//  QRCodeReader
//
//  Created by Sankar on 06/06/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ScanViewController.h"
#import "StartScanningViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

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
    
    self.validLabel.font        = [UIFont fontWithName:@"OpenSans-ExtraBold" size:36];
    self.invalidLabel.font      = [UIFont fontWithName:@"OpenSans-ExtraBold" size:36];
    self.continueLabel.font     = [UIFont fontWithName:@"OpenSans-CondensedBold" size:22];
    self.stopScanningLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:22];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continue:(id)sender {
}

- (IBAction)stopScanning:(id)sender {
    self.startScanningViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScanningViewController"];
    [self.navigationController pushViewController:self.startScanningViewController animated:YES];
}

@end
