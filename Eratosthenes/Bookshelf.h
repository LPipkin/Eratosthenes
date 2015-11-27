//
//  Bookshelf.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookshelfDetails.h"
#import "Librarian.h"

@interface Bookshelf : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *shelfTable;

@end
