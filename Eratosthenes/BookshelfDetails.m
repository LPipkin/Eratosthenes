//
//  BookshelfDetails.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import "BookshelfDetails.h"
#import "BookShelfNotes.h"

@interface BookshelfDetails ()
@property (weak, nonatomic) IBOutlet UITextView *field;

@end

@implementation BookshelfDetails

@synthesize field = _field;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.field.text = [self stringOutputForDictionary:self.novel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)stringOutputForDictionary:(NSDictionary *)inputDict {
    NSMutableString * outputString = [NSMutableString stringWithCapacity:256];
    
    NSArray * allKeys = [inputDict allKeys];
    
    for (NSString * key in allKeys) {
        if ([[inputDict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            [outputString appendString: [self stringOutputForDictionary: (NSDictionary *)inputDict]];
        }
        else {
            [outputString appendString: key];
            [outputString appendString: @": "];
            [outputString appendString: [[inputDict objectForKey: key] description]];
        }
        [outputString appendString: @"\n"];
    }
    
    return [NSString stringWithString: outputString];
}

- (IBAction)readPressed:(id)sender {
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    BookShelfNotes *destViewController = segue.destinationViewController;
    destViewController.book = self.novel;
}

@end
