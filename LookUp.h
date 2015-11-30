//
//  LookUp.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

// google boooks api key: AIzaSyCHt3Jl3bO3phTU8lqv4k5zf57e5x8OhgM

#import <UIKit/UIKit.h>

@interface LookUp : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *bookPreview;

@property (strong, nonatomic) NSMutableDictionary *bookResult;
@property (weak, nonatomic) NSString *isbn;
@property (weak, nonatomic) NSString *bID;

- (IBAction)addBook:(id)sender;

@end
// NSString *finalURL = [NSString stringWithFormat:@"https://www.googleapis.com/books/v1/volumes/%@?key=AIzaSyCHt3Jl3bO3phTU8lqv4k5zf57e5x8OhgM", self.bID];
/*
 *  SQL name        SQL type        API key
 *
 *  bookID          INTEGER,        auto
 *  gID             TEXT,           "id"
 *  title           TEXT,           "volumeInfo": "title"
 *  author          TEXT,           "volumeInfo": "authors"
 *  publisher       TEXT,           "volumeInfo": "publisher"
 *  publishDate     TEXT,           "volumeInfo": "publishedDate"
 *  description     TEXT,           "volumeInfo": "description"
 *  pageCount       TEXT,           "volumeInfo": "printedPageCount"
 *  catagories      TEXT,           "volumeInfo": "categories"
 *  isbn            TEXT,           LOCAL
 *  imageLink       TEXT,           "volumeInfo": "imageLinks": "thumbnail"
 *  notes           TEXT,           LOCAL
 *  reading         TEXT,           LOCAL
 */
