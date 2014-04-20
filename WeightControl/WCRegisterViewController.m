//
//  WCRegisterViewController.m
//  WeightControl
//
//  Created by trsw on 2014/04/21.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCRegisterViewController.h"

@interface WCRegisterViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@end

@implementation WCRegisterViewController

NSMutableArray *intStrings;
NSMutableArray *decimalStrings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    intStrings = [[NSMutableArray alloc] init];
    for (int i=0; i<=150; i++) {
        intStrings[i] = [NSString stringWithFormat:@"%d", i + 1];
    }

    decimalStrings = [[NSMutableArray alloc] init];
    for (int i=0; i<=9; i++) {
        decimalStrings[i] = [NSString stringWithFormat:@"%d", i + 1];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return (component == 0 ? [intStrings count] : [decimalStrings count]);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return (component == 0 ? intStrings[row] : decimalStrings[row]);
}

@end
