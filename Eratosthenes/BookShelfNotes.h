//
//  BookShelfNotes.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 12/3/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookShelfNotes : UIViewController

@property (weak, nonatomic) NSDictionary *book;
@property (weak, nonatomic) IBOutlet UITextView *textField;

- (IBAction)cancelPressed:(id)sender;
- (IBAction)donePressed:(id)sender;


@end
