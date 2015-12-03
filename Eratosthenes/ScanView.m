//
//  ScanView.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/30/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import "ScanView.h"

@interface ScanView()

@property BOOL lightOn;
@property (nonatomic, strong) NSMutableArray *uniqueCodes;

@end

@implementation ScanView

@synthesize scanner = _scanner;
@synthesize lightOn = _lightOn;

- (MTBBarcodeScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_previewView];
    }
    return _scanner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewTapped)];
    [self.previewView addGestureRecognizer:tapGesture];
    self.lightOn = YES;
}

- (void)startScanning {
    self.uniqueCodes = [[NSMutableArray alloc] init];
    
    [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
        for (AVMetadataMachineReadableCodeObject *code in codes) {
            if (code.stringValue && [self.uniqueCodes indexOfObject:code.stringValue] == NSNotFound) {
                [self.uniqueCodes addObject:code.stringValue];
                self.barcodeLable.text = code.stringValue;
                [self stopScanning];
                NSLog(@"Found unique code: %@", code.stringValue);
            }
        }
    }];
    
    [self.toggleScanningButton setTitle:@"Stop Scanning" forState:UIControlStateNormal];
    self.toggleScanningButton.backgroundColor = [UIColor redColor];
}

- (void)stopScanning {
    [self.scanner stopScanning];
    
    [self.toggleScanningButton setTitle:@"Start Scanning" forState:UIControlStateNormal];
    self.toggleScanningButton.backgroundColor = self.view.tintColor;
    
    self.captureIsFrozen = NO;
}

- (IBAction)toggleScanningTapped:(id)sender {
    if ([self.scanner isScanning] || self.captureIsFrozen) {
        [self stopScanning];
        //self.toggleTorchButton.title = @"Enable Torch";
        self.toggleTorchButton.titleLabel.text = @"Enable Torch";
        //self.lightOn = NO;
    } else {
        [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
            if (success) {
                [self startScanning];
            } else {
                [self displayPermissionMissingAlert];
            }
        }];
    }
}

//- (IBAction)switchCameraTapped:(id)sender {
//    [self.scanner flipCamera];
//}

- (IBAction)toggleTorchTapped:(id)sender {
    if (self.scanner.torchMode == MTBTorchModeOff || self.scanner.torchMode == MTBTorchModeAuto) {
        self.scanner.torchMode = MTBTorchModeOn;
        //self.toggleTorchButton.title = @"Disable Torch";
        self.toggleTorchButton.titleLabel.text = @"Disable Torch";
        //self.lightOn = YES;
    } else {
        self.scanner.torchMode = MTBTorchModeOff;
        //self.toggleTorchButton.title = @"Enable Torch";
        self.toggleTorchButton.titleLabel.text = @"Enable Torch";
        //self.lightOn = NO;
    }
}

- (void)displayPermissionMissingAlert {
    NSString *message = nil;
    if ([MTBBarcodeScanner scanningIsProhibited]) {
        message = @"This app does not have permission to use the camera.";
    } else if (![MTBBarcodeScanner cameraIsPresent]) {
        message = @"This device does not have a camera.";
    } else {
        message = @"An unknown error occurred.";
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Scanning Unavailable"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}



- (void)previewTapped {
    if (![self.scanner isScanning] && !self.captureIsFrozen) {
        return;
    }
    
    if (!self.didShowCaptureWarning) {

        [[[UIAlertView alloc] initWithTitle:@"Capture Frozen"
                                    message:@"The capture is now frozen. Tap the preview again to unfreeze."
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil] show];

        self.didShowCaptureWarning = YES;
    }
    
    if (self.captureIsFrozen) {
        [self.scanner unfreezeCapture];
    } else {
        [self.scanner freezeCapture];
    }
    
    self.captureIsFrozen = !self.captureIsFrozen;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"in prepare for seque");
    if([segue.identifier isEqualToString:@"foundISBN"]){
        LookUp *controller = (LookUp *)segue.destinationViewController;
        controller.isbn = self.barcodeLable.text;
        self.barcodeLable.text = @"isbn";
        [self.uniqueCodes removeAllObjects];
        NSLog(@"isbn being passed%@", controller.isbn);
    }
}

- (void)setUniqueCodes:(NSMutableArray *)uniqueCodes {
    _uniqueCodes = uniqueCodes;
}



@end
