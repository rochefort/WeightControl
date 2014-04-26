//
//  WCWeight.m
//  WeightControl
//
//  Created by trsw on 2014/04/25.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCWeight.h"
#import "WCDataManager.h"

@implementation WCWeight

+ (NSArray *)findAll
{
    WCDataManager *dataMgr = [WCDataManager sharedInstance];
    NSString *sql = @"SELECT * FROM weights";
    NSArray *resultsDic = [dataMgr executeQuery:sql];
    NSMutableArray *results = [NSMutableArray array];
    
    for (NSDictionary *result in resultsDic) {
        [results addObject:[self dictionaryToEntity:result]];
    }
    return results;
}

+ (instancetype)findByRecordedDate:(NSDate *)recordedDate
{
    WCDataManager *dataMgr = [WCDataManager sharedInstance];
    NSString *sql = @"SELECT * FROM weights WHERE recorded_date = ?";
    NSArray *resultsDic = [dataMgr executeQuery:sql withArgumentsInArray:@[recordedDate]];
    
    if ([resultsDic count] == 0) {
        return nil;
    }
    return [self dictionaryToEntity:resultsDic[0]];
}

+ (instancetype)dictionaryToEntity:(NSDictionary *)dic
{
    WCWeight *weight = [WCWeight new];
    NSTimeInterval interval = [dic[@"recorded_date"] doubleValue];
    weight.recordedDate     = [NSDate dateWithTimeIntervalSince1970:interval];
    weight.value            = dic[@"value"];
    return weight;
}

- (void)insertOrUpdate
{
    NSString *sql;
    WCDataManager *dataMgr = [WCDataManager sharedInstance];
    WCWeight *weight = [WCWeight findByRecordedDate:self.recordedDate];
    if (weight) {
        // update
        sql = @"UPDATE weights SET value = ? WHERE recorded_date = ?";
        [dataMgr executeUpdate:sql withArgumentsInArray:@[self.value, self.recordedDate]];
    } else {
        // insert
        sql = @"INSERT INTO weights(recorded_date, value) VALUES(?, ?)";
        [dataMgr executeUpdate:sql withArgumentsInArray:@[self.recordedDate, self.value]];
    }
}

@end
