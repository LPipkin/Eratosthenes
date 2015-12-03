//
//  Bookshelf.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import "Bookshelf.h"

@interface Bookshelf ()

@property (nonatomic, strong) Librarian *shelf;
@property (nonatomic, strong) NSArray *row;

- (id)objectAtIndexedSubscript: (NSUInteger)index;

@end

@implementation Bookshelf

@synthesize row = _row;
@synthesize shelf = _shelf;

-(Librarian *)shelf{
    if (_shelf == nil) {
        _shelf = [[Librarian alloc] init];
    }
    return _shelf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"In viewdidload");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.row = [self.shelf getRecords:[self.shelf getDbFilePath] where:@"reading = \"No\""];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"In viewdidappear");
    //[self.tableView reloadData];
    NSLog(@"%@", self.row);
//    self.navigationItem.backBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.row = [self.shelf getRecords:[self.shelf getDbFilePath] where:@"reading = \"No\""];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"In numberOfSectionsInTableView: %lu", (unsigned long)self.row.count);
    return 1;//self.row.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"In tableview: %lu", (unsigned long)self.row.count);
    return self.row.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell1" forIndexPath:indexPath];
    NSLog(@"In cell initialization");
    NSDictionary *novel = [self.row objectAtIndex:indexPath.row];
    NSString *tmp = [NSString stringWithFormat:@"%@ - %@", [novel objectForKey:@"author"], [novel objectForKey:@"title"]];
    cell.textLabel.text = tmp;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (id) objectAtIndexedSubscript:(NSUInteger)index{
    return [self.row objectAtIndex:index];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.shelf deleteWithDictionary:[self.row objectAtIndex:indexPath.row]];
        [tableView beginUpdates];
        [tableView reloadData];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        //[tableView reloadData];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showBookDetail"]) {
        NSIndexPath *indexPath = self.shelfTable.indexPathForSelectedRow;
        BookshelfDetails *destViewController = segue.destinationViewController;
        destViewController.novel = [self.row objectAtIndex:indexPath.row];
    }
}


@end
