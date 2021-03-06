//
//  ScanViewController.m
//  adMission
//
//  Created by Satyen Vats on 06/06/2014.
//  Copyright (c) 2014 Motifworks. All rights reserved.
//

#import "AppDelegate.h"
#import "ScanViewController.h"
#import "StartViewController.h"

@interface ScanViewController ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSoundFor:(BOOL)isSuccess;

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
    self.stopScanningLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:16];
    self.pauseScanningLabel.font = [UIFont fontWithName:@"OpenSans-CondensedBold" size:16];
    
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSoundFor:TRUE];
    
    NSNumber *validCount = [NSNumber numberWithInteger:[[[AppDelegate settings] validScanList] count]];
    self.validCountLabel.text = [validCount stringValue];
    NSNumber *invalidCount = [NSNumber numberWithInteger:[[[AppDelegate settings] invalidScanList] count]];
    self.invalidCountLabel.text = [invalidCount stringValue];

    
    if ([[AppDelegate settings] scanMode]) {
        self.continueScanningView.hidden = TRUE;
        [self continueScan:nil];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction method implementation

- (IBAction)continueScan:(id)sender {
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
//            [_bbitemStart setTitle:@"Stop"];
//            [_lblStatus setText:@"Scanning for QR Code..."];
            self.validView.hidden = TRUE;
            self.invalidView.hidden = TRUE;
            self.viewPreview.hidden = FALSE;
            if ([[AppDelegate settings] scanMode]) {
                self.continueScanningView.hidden = TRUE;
            }
        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        [self stopReading];
        // The bar button item's title should change again.
//        [_bbitemStart setTitle:@"Start!"];
    }
    
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}

- (IBAction)stopScanning:(id)sender {
    [[[AppDelegate settings] validScanList] removeAllObjects];
    [[[AppDelegate settings] invalidScanList] removeAllObjects];
    self.startScanningViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScanningViewController"];
    [self.navigationController pushViewController:self.startScanningViewController animated:YES];
}

- (IBAction)pauseScanning:(id)sender {
    self.startScanningViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScanningViewController"];
    [self.navigationController pushViewController:self.startScanningViewController animated:YES];
}

//- (IBAction)back:(id)sender {
//    self.startScanningViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StartScanningViewController"];
//    [self.navigationController pushViewController:self.startScanningViewController animated:YES];
//}

#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
//    dispatch_queue_t dispatchQueue;
//    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
}


-(void)stopReadingInContinuousMode{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
    if ([[AppDelegate settings] scanMode]) {
        [self performSelector:@selector(continueScan:) withObject:Nil afterDelay:1.0f];
    }
}

-(void)loadBeepSoundFor:(BOOL)isSuccess;
{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *soundFile;
    if (isSuccess) {
        soundFile = @"beep";
    } else {
        soundFile = @"invalid_beep";
    }
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:soundFile ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            NSLog(@"Value - %@", [metadataObj stringValue]);
            if ([[metadataObj stringValue] length] == 8) {
                if ([[AppDelegate settings] addToValidScan:[metadataObj stringValue]]) {
                    self.viewPreview.hidden = TRUE;
                    self.validView.hidden = FALSE;
                    [self performSelectorOnMainThread:@selector(stopReadingInContinuousMode) withObject:nil waitUntilDone:NO];
                    _isReading = NO;
                    self.validValueLabel.text = [metadataObj stringValue];
                    NSNumber *validCount = [NSNumber numberWithInteger:[[[AppDelegate settings] validScanList] count]];
                    self.validCountLabel.text = [validCount stringValue];
                    [_captureSession stopRunning];
                    // If the audio player is not nil, then play the sound effect.
                    [self loadBeepSoundFor:TRUE];
                    if (_audioPlayer && ([[AppDelegate settings] soundMode])) {
                        [_audioPlayer play];
                    }
                } else {
                    self.viewPreview.hidden = TRUE;
                    self.invalidView.hidden = FALSE;
                    [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
                    _isReading = NO;
                    self.invalidLabel.text = @"DUPLICATE";
                    self.invalidValueLabel.text = [metadataObj stringValue];
                    self.continueScanningView.hidden = FALSE;
                    NSNumber *invalidCount = [NSNumber numberWithInteger:[[[AppDelegate settings] invalidScanList] count]];
                    self.invalidCountLabel.text = [invalidCount stringValue];
                    [_captureSession stopRunning];
                    // If the audio player is not nil, then play the sound effect.
                    [self loadBeepSoundFor:FALSE];
                    if (_audioPlayer && ([[AppDelegate settings] soundMode])) {
                        [_audioPlayer play];
                    }
                }
            } else {
                [[AppDelegate settings] addToInvalidScan:[metadataObj stringValue]];
                self.viewPreview.hidden = TRUE;
                self.invalidView.hidden = FALSE;
                [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
                _isReading = NO;
                self.invalidLabel.text = @"INVALID";
                self.invalidValueLabel.text = [metadataObj stringValue];
                self.continueScanningView.hidden = FALSE;
                NSNumber *invalidCount = [NSNumber numberWithInteger:[[[AppDelegate settings] invalidScanList] count]];
                self.invalidCountLabel.text = [invalidCount stringValue];
                [_captureSession stopRunning];
                // If the audio player is not nil, then play the sound effect.
                [self loadBeepSoundFor:FALSE];
                if (_audioPlayer && ([[AppDelegate settings] soundMode])) {
                    [_audioPlayer play];
                }
            }
        } else {
            self.viewPreview.hidden = TRUE;
            self.invalidView.hidden = FALSE;
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
        }
    }
    
    
}

@end
