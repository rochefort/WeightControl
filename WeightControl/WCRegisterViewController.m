//
//  WCRegisterViewController.m
//  WeightControl
//
//  Created by trsw on 2014/04/21.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCRegisterViewController.h"
#import "WCWeightPickerView.h"

@interface WCRegisterViewController () <UITextFieldDelegate, WCWeightPickerViewDelegate>
@property (weak, nonatomic) IBOutlet WCWeightPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;

@end

@implementation WCRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.picker.delegate = self;

    // 日付設定
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [format setDateFormat:@"YYYY年M月d日(EEE)"];
    self.todayLabel.text = [format stringFromDate:[NSDate date]];
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
    self.weightField.text = value;
}

@end
