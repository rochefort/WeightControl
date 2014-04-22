//
//  WCRegisterViewController.m
//  WeightControl
//
//  Created by trsw on 2014/04/21.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCRegisterViewController.h"
#import "WCWeightPickerView.h"

@interface WCRegisterViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet WCWeightPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *weightField;

@end

@implementation WCRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: notificationの名前管理（naming ruleとか）
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pickerDidSelectNotification:)
                                                 name:@"PickerDidSelectNotification"
                                               object:nil];
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

#pragma mark - Notification

- (void) pickerDidSelectNotification:(NSNotification *)center
{
    self.weightField.text = (NSString *)[center object];
}

@end
