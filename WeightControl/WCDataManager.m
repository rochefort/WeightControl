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
        NSString *sql = @"CREATE TABLE weights(id INTEGER PRIMARY KEY AUTOINCREMENT, recorded_date VARCHAR, value REAL);";
        [self execute:sql];
    }
}

#pragma mark - Private

- (NSString *)dbPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = paths[0];
    return [dir stringByAppendingPathComponent:kDBFileName];
}

- (void)execute:(NSString *)sql
{
    NSString *dbPath = [self dbPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    [db open];
    if ([db executeUpdate:sql]) {
        // TODO: warning
        NSLog(@"sql execute error: %@", sql);
    }
    [db close];
}

@end
