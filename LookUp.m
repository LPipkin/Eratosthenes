/*
 Copyright (c) 2014 Mike Buss <michaeltbuss@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

//
//  LookUp.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//
// google boooks api key: AIzaSyCHt3Jl3bO3phTU8lqv4k5zf57e5x8OhgM

#import "LookUp.h"
#import "ScanView.h"
#import "Librarian.h"

@interface LookUp ()

@property (nonatomic, strong) Librarian *shelf;

@end

@implementation LookUp

@synthesize isbn = _isbn;
@synthesize bID = _bID;
@synthesize bookResult = _bookResult;
@synthesize bookPreview = _bookPreview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    //NSLog(@"%@", gidstr);
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
    self.bookResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                       [object2 valueForKeyPath:@"id"], @"gID",
                       [object2 valueForKeyPath:@"volumeInfo.title"], @"title",
                       [object2 valueForKeyPath:@"volumeInfo.authors"], @"author",
                       [object2 valueForKeyPath:@"volumeInfo.publisher"], @"publisher",
                       [object2 valueForKeyPath:@"volumeInfo.publishedDate"], @"publishDate",
                       [object2 valueForKeyPath:@"volumeInfo.description"], @"description",
                       [object2 valueForKeyPath:@"volumeInfo.printedPageCount"], @"pageCount",
                       [object2 valueForKeyPath:@"volumeInfo.categories"], @"catagories",
                       self.isbn, @"isbn",
                       [object2 valueForKeyPath:@"volumeInfo.imageLinks.thumbnail"], @"imageLink",
                       @"No", @"reading", nil];
    
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
    
    //NSLog(@"\n\n\n\n\n\n\n\n");
    //NSLog(@"2: %@", tmpDict);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBook:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"Add to Table"]) {
        self.bookResult[@"reading"] = @"Yes";
    }
    NSDictionary *tmp = [NSDictionary dictionaryWithDictionary:self.bookResult];
    [self.shelf insert:@"" withDict:tmp];
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
