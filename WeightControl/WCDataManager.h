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
- (void)createDB;

@end
