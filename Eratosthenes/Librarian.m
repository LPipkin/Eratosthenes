//
//  Librarian.m
//  Eratosthenes
//
//  Created by Louis Pipkin on 11/24/15.
//  Copyright © 2015 Louis Pipkin. All rights reserved.
//

/*
 *  How to Use SQLite to Manage Data in iOS Apps
 *  july 1, 2014 by gabriel theodoropoulos
 *  http://www.appcoda.com/sqlite-database-ios-app-tutorial/
 */

#import "Librarian.h"

@interface Librarian()

@end

@implementation Librarian

-(instancetype)init
{
    self = [super init];
    if (self) {
        if(![[NSFileManager defaultManager] fileExistsAtPath:[self getDbFilePath]]) //if the file does not exist
        {
            NSLog(@"in create table call");
            [self createTable:[self getDbFilePath]];
        }
    }
    return self;
}

-(NSString *) getDbFilePath
{
    NSString *docsPath= NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [docsPath stringByAppendingPathComponent:@"alexandria.db"];
}

-(int) createTable:(NSString *)filePath
{
    sqlite3 *db = NULL;
    int rc=0;
    
    rc = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        char * query ="CREATE TABLE IF NOT EXISTS books ( "
                        "bookID INTEGER PRIMARY KEY AUTOINCREMENT, "
                        "gID  TEXT, "
                        "title TEXT, "
                        "author TEXT, "
                        "publisher TEXT, "
                        "publishDate TEXT, "
                        "description TEXT, "
                        "pageCount TEXT, "
                        "catagories TEXT, "
                        "isbn TEXT, "
                        "imageLink TEXT, "
                        "notes TEXT, "
                        "reading TEXT)";
        NSLog(@"creatign book table");
        char * errMsg;
        rc = sqlite3_exec(db, query, NULL, NULL, &errMsg);
        
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to create table rc:%d, msg=%s", rc, errMsg);
        }
        
        sqlite3_close(db);
    }
    
    return rc;
}

-(int) deleteWithDictionary:(NSDictionary *)dict{
    int rc = [self delete:[self getDbFilePath] withLisbn:[dict objectForKey:@"isbn"]];
    return rc;
}

-(int) delete:(NSString *) filePath withLisbn:(NSString *) isbn
{
    sqlite3 *db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString
                             stringWithFormat:@"DELETE FROM books where isbn=\"%@\"", isbn];
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String], NULL, NULL, &errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to delete record  rc:%d, msg=%s", rc, errMsg);
        }
        sqlite3_close(db);
    }
    
    return  rc;
}

-(int) updateRead:(NSString *)filePath withDict:(NSMutableDictionary *)book
{
    NSLog(@"in update reading1");
    sqlite3* db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString *query;
        if ([book[@"reading"] isEqualToString:@"Yes"]) {
            query  = [NSString
                      stringWithFormat:@"UPDATE books "
                             "SET reading = \"No\" "
                             "WHERE gID = \"%@\"",
                             book[@"gID"]];
        } else {
            query  = [NSString
                      stringWithFormat:@"UPDATE books "
                      "SET reading = \"Yes\" "
                      "WHERE gID = \"%@\"",
                      book[@"gID"]];
        }
        NSLog(@"in update reading2");
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] , NULL, NULL, &errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to update record  rc:%d, msg=%s", rc, errMsg);
        }
        sqlite3_close(db);
    }
    return rc;
}

-(int) updateNotes:(NSString *)filePath withDict:(NSMutableDictionary *)book
{
    NSLog(@"in update notes1");
    sqlite3* db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString
                             stringWithFormat:@"UPDATE books "
                             "SET notes = \"%@\" "
                             "WHERE gID = \"%@\"",
                             book[@"notes"], book[@"gID"]];
        
        NSLog(@"in update notes2");
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] , NULL, NULL, &errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to update record  rc:%d, msg=%s", rc, errMsg);
        }
        sqlite3_close(db);
    }
    return rc;
}

-(int) insert:(NSString *)filePath withDict:(NSMutableDictionary *)book
{
    sqlite3* db = NULL;
    int rc=0;
    rc = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString
                             stringWithFormat:@"INSERT INTO books "
                             "(gID, title, author, publisher, publishDate, description, pageCount, catagories, isbn, imageLink, notes, reading) "
                             "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                             book[@"gID"],
                             book[@"title"],
                             book[@"author"],
                             book[@"publisher"],
                             book[@"publishDate"],
                             book[@"description"],
                             book[@"pageCount"],
                             book[@"catagories"],
                             book[@"isbn"],
                             book[@"imageLink"],
                             book[@"notes"],
                             book[@"reading"]];
        NSLog(@"in insert");
        char * errMsg;
        rc = sqlite3_exec(db, [query UTF8String] , NULL, NULL, &errMsg);
        if(SQLITE_OK != rc)
        {
            NSLog(@"Failed to insert record  rc:%d, msg=%s", rc, errMsg);
        }
        sqlite3_close(db);
    }
    return rc;
}

-(int) insertWithoutExec:(NSString *)filePath withDict:(NSMutableDictionary *)book{
    sqlite3* db = NULL;
    sqlite3_stmt* stmt =NULL;
    
    int rc=0;
    rc = sqlite3_open_v2([filePath cStringUsingEncoding:NSUTF8StringEncoding], &db, SQLITE_OPEN_READWRITE , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString * query  = [NSString
                             stringWithFormat:@"INSERT INTO books "
                             "(gID, title, author, publisher, publishDate, description, pageCount, catagories, isbn, imageLink, notes, reading) "
                             "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")",
                             book[@"gID"],
                             book[@"title"],
                             book[@"author"],
                             book[@"publisher"],
                             book[@"publishDate"],
                             book[@"description"],
                             book[@"pageCount"],
                             book[@"catagories"],
                             book[@"isbn"],
                             book[@"imageLink"],
                             book[@"notes"],
                             book[@"reading"]];
        
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            rc =sqlite3_step(stmt);
            if(rc == SQLITE_DONE) //success
            {
                rc = SQLITE_OK;
            }
            
            sqlite3_finalize(stmt);
        }
        
        sqlite3_close(db);
    }
    return rc;
}


-(NSArray *) getRecords:(NSString*) filePath where:(NSString *)whereStmt
{
    NSMutableArray * shelf =[[NSMutableArray alloc] init];
    sqlite3 * db = NULL;
    sqlite3_stmt * stmt =NULL;
    int rc=0;
    rc = sqlite3_open_v2([filePath UTF8String], &db, SQLITE_OPEN_READONLY , NULL);
    if (SQLITE_OK != rc)
    {
        sqlite3_close(db);
        NSLog(@"Failed to open db connection");
    }
    else
    {
        NSString  * query = @"SELECT * from books";
        if(whereStmt)
        {
            query = [query stringByAppendingFormat:@" WHERE %@",whereStmt];
        }
        
        rc =sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, NULL);
        if(rc == SQLITE_OK)
        {
            while (sqlite3_step(stmt) == SQLITE_ROW) //get each row in loop
            {
                NSString * BookID       = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
                NSString * GID          = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                NSString * Title        = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                NSString * Author       = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
                NSString * Publisher    = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
                NSString * PublishDate  = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
                NSString * Description  = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
                NSString * PageCount    = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
                NSString * Catagories   = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
                NSString * Isbn         = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
                NSString * ImageLink    = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 10)];
                NSString * Notes        = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 11)];
                NSString * Reading      = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 12)];
                
                NSDictionary *book =[NSDictionary dictionaryWithObjectsAndKeys:
                                     BookID,        @"bookID",
                                     GID,           @"gID",
                                     Title,         @"title",
                                     Author,        @"author",
                                     Publisher,     @"publisher",
                                     PublishDate,   @"publishDate",
                                     Description,   @"description",
                                     PageCount,     @"pageCount",
                                     Catagories,    @"catagories",
                                     Isbn,          @"isbn",
                                     ImageLink,     @"imageLink",
                                     Notes,         @"notes",
                                     Reading,       @"reading", nil];
                
                [shelf addObject:book];
                
            }
            //NSLog(@"Done");
            sqlite3_finalize(stmt);
        }
        else
        {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(db));
            NSLog(@"Failed to prepare statement with rc:%d",rc);
        }
        sqlite3_close(db);
    }
    return shelf;
}

@end
