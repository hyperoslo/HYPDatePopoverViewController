//
//  HYPTimeViewController.m
//
//  Created by Elvis Nunez on 1/22/13.
//  Copyright (c) 2013 Hyper. All rights reserved.
//

#import "HYPDatePopoverViewController.h"

static CGFloat const HYPActionTitleLabelY = 10.0f;
static CGFloat const HYPActionTitleLabelHeight = 40.0f;

static CGFloat const HYPActionMessageTextViewX = 10.0f;
static CGFloat const HYPActionMessageTextViewY = 20.0f;

static CGFloat const HYPActionButtonX = 10.0f;
static CGFloat const HYPActionButtonHeight = 45.0f;

static CGFloat const HYPViewVerticalSpacing = 10.0f;

static const CGSize HYPTimePopoverSize = { 320.0f, 216.0f };

@interface HYPDatePopoverViewController ()

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, copy) HYPDatePopoverActionBlock actionBlock;

@property (nonatomic, copy) NSString *actionTitle;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *messageTextView;

@end

@implementation HYPDatePopoverViewController

#pragma mark - Initialization

- (id)initWithDate:(NSDate *)date
{
    self = [super init];
    if (!self) return nil;

    _date = date;

    return self;
}

- (id)initWithDate:(NSDate *)date title:(NSString *)title message:(NSString *)message
       actionTitle:(NSString *)actionTitle actionBlock:(HYPDatePopoverActionBlock)actionBlock
{
    self = [self initWithDate:date];
    if (!self) return nil;

    _actionTitle = actionTitle;

    self.title = title;

    _message = message;

    _actionBlock = actionBlock;

    return self;
}

#pragma mark - Getters

- (UILabel *)titleLabel
{
    if (_titleLabel) return _titleLabel;

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, HYPActionTitleLabelY,
                                                                  HYPTimePopoverSize.width,
                                                                  HYPActionTitleLabelHeight)];
    _titleLabel.text = self.title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    return _titleLabel;
}

- (UITextView *)messageTextView
{
    if (_messageTextView) return _messageTextView;

    UIFont *font = [UIFont systemFontOfSize:14.0f];
    CGFloat xOffset = HYPActionMessageTextViewX;
    CGFloat yOffset = HYPActionMessageTextViewY;

    NSDictionary *attributes = @{ NSFontAttributeName : font };
    CGFloat width = HYPTimePopoverSize.width - (xOffset * 2.0f);
    CGRect rect = [self.message boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];

    CGFloat height = CGRectGetHeight(rect) + yOffset;
    CGFloat y = (self.title) ? CGRectGetMaxY(self.titleLabel.frame) : 0.0f;

    _messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(xOffset, y, HYPTimePopoverSize.width - (xOffset * 2.0f), height)];
    _messageTextView.font = font;
    _messageTextView.textColor = [UIColor blackColor];
    _messageTextView.text = self.message;
    _messageTextView.scrollEnabled = NO;
    _messageTextView.backgroundColor = [UIColor clearColor];

    return _messageTextView;
}

- (UIDatePicker *)datePicker
{
    if (_datePicker) return _datePicker;

    CGFloat y = (self.message) ? CGRectGetMaxY(self.messageTextView.frame) : 0.0f;

    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, y, HYPTimePopoverSize.width,
                                                                 HYPTimePopoverSize.height)];

    return _datePicker;
}

- (UIButton *)actionButton
{
    if (_actionButton) return _actionButton;

    CGFloat height = HYPActionButtonHeight;
    CGFloat offset = HYPActionButtonX;
    CGFloat y = 0.0f;

    if (self.date) {
        y = CGRectGetMaxY(self.datePicker.frame);
    } else if (self.message) {
        y = CGRectGetMaxY(self.messageTextView.frame);
    } else if (self.title) {
        y = CGRectGetMaxY(self.titleLabel.frame);
    }

    _actionButton = [[UIButton alloc] initWithFrame:CGRectMake(offset, y,
                                                               HYPTimePopoverSize.width - (offset * 2.0f), height)];
    [_actionButton setTitle:self.actionTitle forState:UIControlStateNormal];
    _actionButton.backgroundColor = [UIColor redColor];
    [_actionButton addTarget:self action:@selector(actionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    _actionButton.layer.cornerRadius = 5.0f;
    _actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];

    return _actionButton;
}

#pragma mark - Setters

- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;

    self.datePicker.date = currentDate;
}

- (void)setActionButtonColor:(UIColor *)actionButtonColor
{
    _actionButtonColor = actionButtonColor;

    self.actionButton.backgroundColor = actionButtonColor;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.date) {
        [self.view addSubview:self.datePicker];

        [self.datePicker setBackgroundColor:[UIColor clearColor]];

        if (self.birthdayPicker) {
            [self.datePicker setDatePickerMode:UIDatePickerModeDate];
        } else {
            [self.datePicker setMinimumDate:[NSDate date]];
        }

        [self.datePicker setDate:self.date];

        [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }

    if (self.actionBlock) {
        [self.view addSubview:self.actionButton];
    }

    if (self.title) {
        [self.view addSubview:self.titleLabel];
    }

    if (self.message) {
        [self.view addSubview:self.messageTextView];
    }
}

#pragma mark - Actions

- (void)dateChanged:(UIDatePicker *)datePicker
{
    self.date = datePicker.date;

    if ([self.delegate respondsToSelector:@selector(timeController:didChangedDate:)]) {
        [self.delegate timeController:self didChangedDate:datePicker.date];
    }
}

- (void)actionButtonPressed
{
    if (self.actionBlock) {
        self.actionBlock(self.date);
    }
}

#pragma mark - Public Methods

- (CGFloat)calculatedHeight
{
    CGFloat height = 0.0f;

    if (self.titleLabel) {
        height += HYPActionTitleLabelHeight + HYPActionTitleLabelY;
        height += HYPViewVerticalSpacing;
    }

    if (self.message) {
        UIFont *font = [UIFont systemFontOfSize:14.0f];
        CGFloat xOffset = HYPActionMessageTextViewX;
        CGFloat yOffset = HYPActionMessageTextViewY;

        NSDictionary *attributes = @{ NSFontAttributeName : font };
        CGFloat width = HYPTimePopoverSize.width - (xOffset * 2.0f);
        CGRect rect = [self.message boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];

        height += CGRectGetHeight(rect) + yOffset;

        height += HYPViewVerticalSpacing;
    }

    if (self.date) {
        height += CGRectGetHeight(self.datePicker.frame);
    }

    if (self.actionBlock) {
        height += HYPActionButtonHeight;
    }

    return height;
}

@end
