//
//  WCDataManager.h
//  WeightControl
//
//  Created by trsw on 2014/04/23.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface WCDataManager : NSObject

+ (instancetype)sharedInstance;
- (instancetype)init __attribute__((unavailable("use sharedInstance")));

- (void)createDB;

- (void)executeUpdate:(NSString *)sql;
- (void)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

- (NSArray *)executeQuery:(NSString *)sql;
- (NSArray *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;

@end
