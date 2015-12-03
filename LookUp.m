//
//  LookUp.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//
// google boooks api key: AIzaSyCHt3Jl3bO3phTU8lqv4k5zf57e5x8OhgM

#import "LookUp.h"

@interface LookUp ()

@property (nonatomic, strong) Librarian *shelf;
@property (weak, nonatomic) IBOutlet UITextView *field;

@end

@implementation LookUp

@synthesize isbn = _isbn;
@synthesize bID = _bID;
@synthesize bookResult = _bookResult;
@synthesize bookPreview = _bookPreview;
@synthesize field = _field;
@synthesize shelf = _shelf;

-(Librarian *)shelf{
    if (_shelf == nil) {
        _shelf = [[Librarian alloc] init];
    }
    return _shelf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"isbn passed: %@", self.isbn);
    NSString *initialURL = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes?q=isbn+%@", self.isbn];
    
    NSURL * url1 = [[NSURL alloc] initWithString:initialURL];
    
    NSURLRequest *urlRequest1 = [NSURLRequest requestWithURL:url1
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:30];
    
    NSData *urlData1;
    NSURLResponse *response1;
    NSError *error1;
    
    urlData1 = [NSURLConnection sendSynchronousRequest:urlRequest1
                                     returningResponse:&response1
                                                 error:&error1];
    
    NSDictionary* object1 = [NSJSONSerialization
                             JSONObjectWithData:urlData1
                             options:0
                             error:&error1];

    self.bID = [object1 valueForKeyPath:@"items.id"][0];
    
    // NSString *finalURL = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes/%@?key=AIzaSyCHt3Jl3bO3phTU8lqv4k5zf57e5x8OhgM", self.bID];
    NSString *finalURL = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes/%@", self.bID];
    
    NSLog(@"%@", finalURL);
    NSURL * url2 = [[NSURL alloc] initWithString:finalURL];
    
    NSURLRequest *urlRequest2 = [NSURLRequest requestWithURL:url2
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:30];
    
    NSData *urlData2;
    NSURLResponse *response2;
    NSError *error2;
    
    urlData2 = [NSURLConnection sendSynchronousRequest:urlRequest2
                                     returningResponse:&response2
                                                 error:&error2];
    
    NSDictionary* object2 = [NSJSONSerialization
                             JSONObjectWithData:urlData2
                             options:0
                             error:&error2];
    //NSLog(@"%@", object2);
    NSString *fullTitle;
    if ([object2 valueForKeyPath:@"volumeInfo.subtitle"]) {
        fullTitle = [NSString stringWithFormat:@"%@ %@", [object2 valueForKeyPath:@"volumeInfo.title"], [object2 valueForKeyPath:@"volumeInfo.subtitle"]];
    }else{
        fullTitle = [object2 valueForKeyPath:@"volumeInfo.title"];
    }
    
    self.bookResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                       [object2 valueForKeyPath:@"id"], @"gID",
                       fullTitle, @"title",
                       [object2 valueForKeyPath:@"volumeInfo.authors"], @"author",
                       [object2 valueForKeyPath:@"volumeInfo.publisher"], @"publisher",
                       [object2 valueForKeyPath:@"volumeInfo.publishedDate"], @"publishDate",
                       [object2 valueForKeyPath:@"volumeInfo.description"], @"description",
                       [object2 valueForKeyPath:@"volumeInfo.printedPageCount"], @"pageCount",
                       [object2 valueForKeyPath:@"volumeInfo.categories"], @"catagories",
                       self.isbn, @"isbn",
                       @"none", @"notes",
                       [object2 valueForKeyPath:@"volumeInfo.imageLinks.thumbnail"], @"imageLink",
                       @"Huh?", @"reading", nil];
    
    //NSLog(@"1: %@", self.bookResult);
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:self.bookResult];
    NSString *tmp;
    for(id key in self.bookResult){
        if ([[self.bookResult objectForKey:key] isKindOfClass:[NSArray class]]) {
            tmp = [[self.bookResult objectForKey:key] componentsJoinedByString:@", "];
            [tmpDict setObject:tmp forKey:key];
        }
    }
    self.bookResult = [NSMutableDictionary dictionaryWithDictionary:tmpDict];
    self.field.text = [NSString stringWithFormat:@"%@\n\n%@", [self.bookResult objectForKey:@"title"], [self.bookResult objectForKey:@"description"]];
    //NSLog(@"\n\n\n\n\n\n\n\n");
    NSLog(@"2: %@", self.bookResult);
    NSLog(@"thumbnail: %@", [self.bookResult objectForKey:@"imageLink"]);
    NSURL *absUrl = [NSURL URLWithString:[self.bookResult objectForKey:@"imageLink"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:absUrl];
    self.bookPreview.scalesPageToFit = YES;
    [self.bookPreview loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBook:(UIButton *)sender {
    NSLog(@"in addBook");
    if ([sender.currentTitle isEqualToString:@"Put on Table"]) {
        self.bookResult[@"reading"] = @"Yes";
    }
    if ([sender.currentTitle isEqualToString:@"Put on Shelf"]) {
        self.bookResult[@"reading"] = @"No";
    }

    [self.shelf insert:[self.shelf getDbFilePath] withDict:self.bookResult];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Back
{
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
