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

-(instancetype)init;
-(NSString *) getDbFilePath;
-(int) delete:(NSString *)filePath withLisbn:(NSString *)isbn;
-(int) insert:(NSString *)filePath withDict:(NSMutableDictionary *)book;
-(int) insertWithoutExec:(NSString *)filePath withDict:(NSMutableDictionary *)book;
-(NSArray *) getRecords:(NSString*) filePath where:(NSString *)whereStmt;

@end
