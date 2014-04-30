//
//  WCRegisterViewController.m
//  WeightControl
//
//  Created by trsw on 2014/04/21.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCRegisterViewController.h"
#import "FontAwesomeKit/FontAwesomeKit.h"
#import "WCWeightPickerView.h"
#import "WCWeight.h"


@interface WCRegisterViewController () <UITextFieldDelegate, WCWeightPickerViewDelegate>
@property (weak, nonatomic) IBOutlet WCWeightPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;

@property (weak, nonatomic) IBOutlet UIButton *prevDayButton;
@property (weak, nonatomic) IBOutlet UIButton *nextDayButton;

@end

@implementation WCRegisterViewController

WCWeight *weight;
NSDateFormatter *dateFormat;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.picker.delegate = self;

    // initialize
    NSDate *today = [[NSDate date] dateAtStartOfDay];
    weight = [WCWeight findByRecordedDate:today];
    if (!weight) {
        weight = [WCWeight new];
    }

    // 日付設定
    weight.recordedDate = today;
    dateFormat = [[NSDateFormatter alloc] init];
    self.todayLabel.text = [self dateToString:weight.recordedDate];

    // 体重設定
    if (weight.value) {
        self.weightField.text = [NSString stringWithFormat:@"%.1f", [weight.value doubleValue]];
    }

    // アイコン設定
    FAKFontAwesome *caretLeftIcon = [FAKFontAwesome caretLeftIconWithSize:20];
    FAKFontAwesome *caretRightIcon = [FAKFontAwesome caretRightIconWithSize:20];
    [self.prevDayButton setAttributedTitle:[caretLeftIcon attributedString] forState:UIControlStateNormal];
    [self.nextDayButton setAttributedTitle:[caretRightIcon attributedString] forState:UIControlStateNormal];
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
    [self.picker showWithWeightValue:self.weightField.text];
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
