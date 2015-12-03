//
//  NightstandNotes.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 12/3/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NightstandNotes : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textField;

@property (weak, nonatomic) NSDictionary *book;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
