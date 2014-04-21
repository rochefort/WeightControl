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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0]];
        defaultPositionY = self.frame.origin.y;
        [self setup];
        self.hidden = YES;
    }
    return self;
}

- (void)setup
{
    intStrings = [[NSMutableArray alloc] init];
    for (int i=0; i<150; i++) {
        intStrings[i] = [NSString stringWithFormat:@"%d", i + 1];
    }

    decimalStrings = [[NSMutableArray alloc] init];
    for (int i=0; i<9; i++) {
        decimalStrings[i] = [NSString stringWithFormat:@"%d", i + 1];
    }
}

#pragma mark - Instance Methods
- (void)show
{
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return (component == 0 ? intStrings[row] : decimalStrings[row]);
}

#pragma mark - IBAction

- (IBAction)doneButtonDidPush:(id)sender {
    [self hide];
}

@end
