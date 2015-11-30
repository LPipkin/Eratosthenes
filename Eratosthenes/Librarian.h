//
//  Librarian.h
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Librarian : NSObject


-(int) delete:(NSString *) filePath withLName:(NSString *) isbn;
-(int) insert:(NSString *)filePath withDict:(NSDictionary *)book;
-(NSArray *) getRecords:(NSString*) filePath where:(NSString *)whereStmt;
/*
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

-(instancetype)initWithDatabaseFilename:(NSString *)userLibrary;
*/
@end