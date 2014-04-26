//
//  WCWeight.h
//  WeightControl
//
//  Created by trsw on 2014/04/25.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCWeight : NSObject

@property (nonatomic) int id;
@property (nonatomic) NSDate *recordedDate;
@property (nonatomic) NSNumber *value;

+ (NSArray *)findAll;
+ (WCWeight *)findByRecordedDate:(NSDate *)recordedDate;
- (void)insertOrUpdate;

@end
