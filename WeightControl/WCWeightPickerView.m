//
//  WCWeightPickerView.m
//  WeightControl
//
//  Created by trsw on 2014/04/22.
//  Copyright (c) 2014年 trsw. All rights reserved.
//

#import "WCWeightPickerView.h"
#import "WCWeight.h"

@interface WCWeightPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)closeButtonDidPush:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

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
}

#pragma mark - Instance Methods
- (void)showWithWeightValue:(NSString *)value
{
    // 既に開いていたら何もしない
    if (!self.hidden) {
        return;
    }

    // 値設定
    if ([value isEqualToString:@""]) {
        // default value: 50.0kg
        [self.pickerView selectRow:49 inComponent:0 animated:NO];
        selectedComponent1 = @"50";
        selectedComponent2 = @"0";
    } else {
        NSArray *tmp = [value componentsSeparatedByString:@"."];
        [self.pickerView selectRow:[tmp[0] integerValue]-1 inComponent:0 animated:NO];
        [self.pickerView selectRow:[tmp[1] integerValue] inComponent:1 animated:NO];
        selectedComponent1 = [NSString stringWithFormat:@"%d", [tmp[0] integerValue]];
        selectedComponent2 = [NSString stringWithFormat:@"%d", [tmp[1] integerValue]];
    }

    // 位置調整
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
    [self callDelegateForPickerDidSelect];
}

#pragma mark - IBAction

/**
 何も変更せずにcloseボタンを押すと
 pickerDidSelect が呼ばれない。（つまり値がsetされない）
 そのためcloseボタン押下時にも pickerDidSelect をcallするようにしている。
 */
- (IBAction)closeButtonDidPush:(id)sender {
    [self hide];
    
    [self callDelegateForPickerDidSelect];
    [self callDelegateForPickerClose];
}

#pragma mark - delegate

- (void)callDelegateForPickerDidSelect
{
    NSString *selectedStr = [NSString stringWithFormat:@"%@.%@", selectedComponent1, selectedComponent2];
    // call delegate method
    if ([self.delegate respondsToSelector:@selector(pickerDidSelect:)]) {
        [self.delegate pickerDidSelect:selectedStr];
    }
}

- (void)callDelegateForPickerClose
{
    if ([self.delegate respondsToSelector:@selector(pickerClose)]) {
        [self.delegate pickerClose];
    }
}

@end
