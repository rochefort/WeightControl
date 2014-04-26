//
//  WCDataManager.m
//  WeightControl
//
//  Created by trsw on 2014/04/23.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCDataManager.h"

@implementation WCDataManager

NSString *const kDBFileName = @"wcdb.sqlite";

#pragma mark - Singleton

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)createDB
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *dbPath = [self dbPath];
    if (![fileMgr fileExistsAtPath:dbPath]) {
        NSString *sql = @"CREATE TABLE weights(id INTEGER PRIMARY KEY AUTOINCREMENT, recorded_date REAL, value REAL);";
        [self executeUpdate:sql];
    }
}

- (void)executeUpdate:(NSString *)sql
{
    NSString *dbPath = [self dbPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return;
    }
    if (![db executeUpdate:sql]) {
        // TODO: warning
        NSLog(@"sql execute error: %@", sql);
    }
    [db close];
}

- (void)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    NSString *dbPath = [self dbPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        return;
    }
    if (![db executeUpdate:sql withArgumentsInArray:arguments]) {
        // TODO: warning
        NSLog(@"sql execute error: %@", sql);
    }
    [db close];
}

- (NSArray *)executeQuery:(NSString *)sql
{
    NSString *dbPath = [self dbPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    FMResultSet *rs = nil;
    NSMutableArray *ret = [NSMutableArray array];
    
    if (![db open]) {
        return nil;
    }
    rs = [db executeQuery:sql];
    while ([rs next]) {
        [ret addObject:[rs resultDictionary]];
    }
    [db close];
    return [ret copy];
}

- (NSArray *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    NSString *dbPath = [self dbPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    FMResultSet *rs = nil;
    NSMutableArray *ret = [NSMutableArray array];
    
    if (![db open]) {
        return nil;
    }
    rs = [db executeQuery:sql withArgumentsInArray:arguments];
    while ([rs next]) {
        [ret addObject:[rs resultDictionary]];
    }
    [db close];
    return [ret copy];
}

#pragma mark - Private

- (NSString *)dbPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = paths[0];
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end
