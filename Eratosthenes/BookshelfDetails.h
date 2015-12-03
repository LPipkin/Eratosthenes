//
//  BookshelfDetails.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookshelfDetails : UIViewController

@property (nonatomic, strong) NSDictionary *novel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textFeild;

- (IBAction)readPressed:(id)sender;
//- (IBAction)editNOtePressed:(id)sender;

@end
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