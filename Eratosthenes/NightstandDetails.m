//
//  NightstandDetails.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import "NightstandDetails.h"
#import "NightstandNotes.h"
#import "Librarian.h"

@interface NightstandDetails ()
@property (weak, nonatomic) IBOutlet UITextView *field;
@property (weak, nonatomic) Librarian *shelf;
@end

@implementation NightstandDetails

@synthesize field = _field;
@synthesize titleLabel = _titleLabel;
@synthesize shelf = _shelf;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.field.text = [self stringOutputForDictionary:self.novel];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ - %@",
                            [self.novel objectForKey:@"title"],
                            [self.novel objectForKey:@"author"]];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                           initWithTitle:@"Back"
                                           style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(backButtonHit)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)stringOutputForDictionary:(NSDictionary *)inputDict {
    return [NSString stringWithFormat:
            @"Description:\n\t%@\nGenre:\n\t%@\nPublished:\n\t%@\nNotes:"
            "\n\t%@\nPages:\n\t%@\nISBN:\n\t%@\nPublisher\n\t%@",
            [self.novel objectForKey:@"description"],
            [self.novel objectForKey:@"catagories"],
            [self.novel objectForKey:@"publishDate"],
            [self.novel objectForKey:@"notes"],
            [self.novel objectForKey:@"pageCount"],
            [self.novel objectForKey:@"isbn"],
            [self.novel objectForKey:@"publisher"]];
}

-(void)finihedPressed:(id)sender{
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.novel];
    [self.shelf updateRead:[self.shelf getDbFilePath] withDict:tmpDict];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NightstandNotes *destViewController = segue.destinationViewController;
    destViewController.book = self.novel;
}

-(void)backButtonHit
{
    // removeItemAtPath: newFilepath stuff here
    [self.navigationController popViewControllerAnimated:YES];
}

@end
