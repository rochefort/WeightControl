//
//  WCWeightPickerView.h
//  WeightControl
//
//  Created by trsw on 2014/04/22.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WCWeightPickerViewDelegate <NSObject>
@required
- (void)pickerDidSelect:(NSString *)value;
@end

@interface WCWeightPickerView : UIView
@property (nonatomic, weak) id<WCWeightPickerViewDelegate> delegate;
- (void)show;
@end


