//
//  CrudOp.m
//  rubi
//
//  Created by David Krachler on 12.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//


#import "CrudOp.h"
#import "StartViewController.h"

@implementation CrudOp
@synthesize  coldbl;
@synthesize colint;
@synthesize coltext;
@synthesize dataId;
@synthesize fileMgr;
@synthesize homeDir;
@synthesize title;


-(NSString *)GetDocumentDirectory{
    fileMgr = [NSFileManager defaultManager];
    homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    return homeDir;
}

-(void)CopyDbToDocumentsFolder{
    NSError *err=nil;
    
    fileMgr = [NSFileManager defaultManager];
    
    NSString *dbpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rubi.sqlite"];
    
    NSString *copydbpath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"rubi.sqlite"];
    
    [fileMgr removeItemAtPath:copydbpath error:&err];
    if(![fileMgr copyItemAtPath:dbpath toPath:copydbpath error:&err])
    {
        UIAlertView *tellErr = [[UIAlertView alloc] initWithTitle:title message:@"Unable to copy database." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [tellErr show];
        
    }
    
}

-(void)InsertRecords:(NSMutableString *) txt :(int) integer :(double) dbl{
    fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *stmt=nil;
    sqlite3 *cruddb;
    
    
    //insert
    const char *sql = "Insert into data(coltext, colint, coldouble) ?,?,?";
    
    //Open db
    NSString *cruddatabase = [self.GetDocumentDirectory stringByAppendingPathComponent:@"rubi.sqlite"];
    sqlite3_open([cruddatabase UTF8String], &cruddb);
    sqlite3_prepare_v2(cruddb, sql, 1, &stmt, NULL);
    sqlite3_bind_text(stmt, 1, [txt UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, integer);
    sqlite3_bind_double(stmt, 3, dbl);
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(cruddb);
}

-(void)UpdateRecords:(NSString *)txt :(NSMutableString *)utxt{
    
    fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *stmt=nil;
    sqlite3 *cruddb;
    
    
    //insert
    const char *sql = "Update data set coltext=? where coltext=?";
    
    //Open db
    NSString *cruddatabase = [self.GetDocumentDirectory stringByAppendingPathComponent:@"cruddb.sqlite"];
    sqlite3_open([cruddatabase UTF8String], &cruddb);
    sqlite3_prepare_v2(cruddb, sql, 1, &stmt, NULL);
    sqlite3_bind_text(stmt, 1, [txt UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(stmt, 2, [utxt UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(cruddb);
    
}
-(void)DeleteRecords:(NSString *)txt{
    fileMgr = [NSFileManager defaultManager];
    sqlite3_stmt *stmt=nil;
    sqlite3 *cruddb;
    
    //insert
    const char *sql = "Delete from data where coltext=?";
    
    //Open db
    NSString *cruddatabase = [self.GetDocumentDirectory stringByAppendingPathComponent:@"cruddb.sqlite"];
    sqlite3_open([cruddatabase UTF8String], &cruddb);
    sqlite3_prepare_v2(cruddb, sql, 1, &stmt, NULL);
    sqlite3_bind_text(stmt, 1, [txt UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_step(stmt);
    sqlite3_finalize(stmt);
    sqlite3_close(cruddb);
    
}


@end