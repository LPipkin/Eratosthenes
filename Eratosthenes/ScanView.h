//
//  ScanView.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/30/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTBBarcodeScanner.h"

@interface ScanView : UIViewController

@property (strong, nonatomic) MTBBarcodeScanner *scanner;

@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIButton *toggleScanningButton;
@property (weak, nonatomic) IBOutlet UILabel *barcodeLable;

@property (nonatomic, strong) NSMutableArray *uniqueCodes;
@property (nonatomic, assign) BOOL captureIsFrozen;
@property (nonatomic, assign) BOOL didShowCaptureWarning;

@end
