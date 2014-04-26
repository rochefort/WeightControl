//
//  WCRegisterViewController.m
//  WeightControl
//
//  Created by trsw on 2014/04/21.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCRegisterViewController.h"
#import "WCWeightPickerView.h"
#import "WCWeight.h"

@interface WCRegisterViewController () <UITextFieldDelegate, WCWeightPickerViewDelegate>
@property (weak, nonatomic) IBOutlet WCWeightPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;

@end

@implementation WCRegisterViewController

WCWeight *weight;
NSDateFormatter *dateFormat;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.picker.delegate = self;
    weight = [WCWeight new];

    // 日付設定
    weight.recordedDate = [[NSDate date] dateAtStartOfDay];
    dateFormat = [[NSDateFormatter alloc] init];
    self.todayLabel.text = [self dateToString:weight.recordedDate];
}

- (NSString *)dateToString:(NSDate *)date
{
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [dateFormat setDateFormat:@"YYYY年M月d日(EEE)"];
    return [dateFormat stringFromDate:date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextView

- (BOOL) textFieldShouldBeginEditing:(UITextView *)textView
{
    [self.picker show];
    return NO;
}

#pragma mark - WCWeightPickerViewDelegate

- (void)pickerDidSelect:(NSString *)value
{
    weight.value = [NSNumber numberWithDouble:[value doubleValue]];
    self.weightField.text = value;
}

- (void)pickerClose
{
    [weight insertOrUpdate];
}

@end
