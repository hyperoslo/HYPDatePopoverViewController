//
//  HYPTimeViewController.h
//
//  Created by Elvis Nunez on 1/22/13.
//  Copyright (c) 2013 Hyper. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void (^HYPDatePopoverActionBlock)(NSDate *date);

@protocol HYPDatePopoverViewControllerDelegate;

@interface HYPDatePopoverViewController : UIViewController

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, weak) id <HYPDatePopoverViewControllerDelegate> delegate;
@property (nonatomic) BOOL birthdayPicker;
@property (nonatomic, copy) UIColor *actionButtonColor;

- (id)initWithDate:(NSDate *)date;
- (id)initWithDate:(NSDate *)date title:(NSString *)title message:(NSString *)message
       actionTitle:(NSString *)actionTitle actionBlock:(HYPDatePopoverActionBlock)actionBlock;

- (CGFloat)calculatedHeight;

@end

@protocol HYPDatePopoverViewControllerDelegate <NSObject>

- (void)timeController:(HYPDatePopoverViewController *)timeController didChangedDate:(NSDate *)date;

@end
