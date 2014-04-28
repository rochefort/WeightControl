//
//  WCWeightPickerView.m
//  WeightControl
//
//  Created by trsw on 2014/04/22.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCWeightPickerView.h"

@interface WCWeightPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)doneButtonDidPush:(id)sender;

@end

@implementation WCWeightPickerView

NSMutableArray *intStrings;
NSMutableArray *decimalStrings;

CGFloat defaultPositionY;

NSString *selectedComponent1;
NSString *selectedComponent2;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0]];

        [self setupIncetanceVariables];
        self.hidden = YES;
    }
    return self;
}

- (void)setupIncetanceVariables
{
    // view initial position
    defaultPositionY = self.frame.origin.y;
    
    // picker values
    intStrings = [[NSMutableArray alloc] init];
    for (int i=0; i<150; i++) {
        intStrings[i] = [NSString stringWithFormat:@"%d", i + 1];
    }

    decimalStrings = [[NSMutableArray alloc] init];
    for (int i=0; i<=9; i++) {
        decimalStrings[i] = [NSString stringWithFormat:@"%d", i];
    }
    // for delegate
    selectedComponent1 = @"1";
    selectedComponent2 = @"0";
}

#pragma mark - Instance Methods
- (void)show
{
    // 既に開いていたら何もしない
    if (!self.hidden) {
        return;
    }

    // TODO: frame関係のマクロを用意する
    CGRect frame = self.frame;
    frame.origin.y = defaultPositionY;
    self.frame = frame;

    self.hidden = NO;
    self.alpha = 0.f;
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 1.0f;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        // TODO: frame関係のマクロを用意する
        CGRect frame = self.frame;
        frame.origin.y = -1000.f;
        self.frame = frame;
        self.hidden = YES;
    }];
}

#pragma mark - UIPicker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return (component == 0 ? [intStrings count] : [decimalStrings count]);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    CGFloat centerX = self.frame.size.width / 2;
    if (component == 0) {
        label.frame = CGRectMake(centerX - 100, 0, 100, 40);
        label.text = intStrings[row];
        label.textAlignment = NSTextAlignmentRight;
    } else {
        label.frame = CGRectMake(centerX, 0, 100, 40);
        label.text = decimalStrings[row];
    }
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedCmponentText = ((UILabel *)[pickerView viewForRow:row forComponent:component]).text;
    if (component == 0) {
        selectedComponent1 = selectedCmponentText;
    } else {
        selectedComponent2 = selectedCmponentText;
    }
    NSString *selectedStr = [NSString stringWithFormat:@"%@.%@", selectedComponent1, selectedComponent2];

    // call delegate method
    if ([self.delegate respondsToSelector:@selector(pickerDidSelect:)]) {
        [self.delegate pickerDidSelect:selectedStr];
    }
}

#pragma mark - IBAction

- (IBAction)doneButtonDidPush:(id)sender {
    [self hide];

    // call delegate method
    if ([self.delegate respondsToSelector:@selector(pickerClose)]) {
        [self.delegate pickerClose];
    }
}

@end
