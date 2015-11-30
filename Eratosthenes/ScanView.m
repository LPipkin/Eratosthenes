//
//  ScanView.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/30/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import "ScanView.h"

@implementation ScanView

@synthesize scanner = _scanner;

- (MTBBarcodeScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:_previewView];
    }
    return _scanner;
}

@end
