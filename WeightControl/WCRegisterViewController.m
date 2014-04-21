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

@end

@implementation WCRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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

@end
