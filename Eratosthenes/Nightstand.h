//
//  Nightstand.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NightstandDetails.h"
#import "Librarian.h"

@interface Nightstand : UITableViewController  <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *standTable;

@end
