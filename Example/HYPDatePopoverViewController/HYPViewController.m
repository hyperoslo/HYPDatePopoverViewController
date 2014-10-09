//
//  HYPViewController.m
//  HYPDatePopoverViewController
//
//  Created by Elvis Nuñez on 10/09/2014.
//  Copyright (c) 2014 Elvis Nuñez. All rights reserved.
//

#import "HYPViewController.h"

#import "HYPDatePopoverViewController.h"

@interface HYPViewController ()

@property (nonatomic, strong) UIPopoverController *datePopoverController;

@end

@implementation HYPViewController

- (UIPopoverController *)datePopoverController
{
    if (_datePopoverController) return _datePopoverController;

    HYPDatePopoverViewController *datePopover = [[HYPDatePopoverViewController alloc] initWithDate:[NSDate date]
                                                                                             title:@"some title"
                                                                                           message:@"message"
                                                                                       actionTitle:@"pushed me?" actionBlock:^(NSDate *date) {
                                                                                           NSLog(@"what have you done at %@", date);
                                                                                       }];
    _datePopoverController = [[UIPopoverController alloc] initWithContentViewController:datePopover];

    return _datePopoverController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 50.0f)];
    [button setTitle:@"Push me" forState:UIControlStateNormal];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonPressedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonPressedAction:(UIButton *)sender
{
    [self.datePopoverController presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
