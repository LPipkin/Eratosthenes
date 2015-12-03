//
//  BookShelfNotes.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 12/3/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import "BookShelfNotes.h"
#import "Librarian.h"

@interface BookShelfNotes ()

@property (nonatomic, strong) Librarian *shelf;

@end

@implementation BookShelfNotes

@synthesize shelf = _shelf;
@synthesize textField = _textField;
@synthesize book = _book;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textField.text = [self.book objectForKey:@"notes"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)donePressed:(id)sender {
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.book];
    tmpDict[@"notes"] = self.textField.text;
    [self.shelf updateNotes:[self.shelf getDbFilePath] withDict:tmpDict];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end