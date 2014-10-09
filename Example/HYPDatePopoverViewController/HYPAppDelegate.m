//
//  HYPAppDelegate.m
//  HYPDatePopoverViewController
//
//  Created by CocoaPods on 10/09/2014.
//  Copyright (c) 2014 Elvis Nuñez. All rights reserved.
//

#import "HYPAppDelegate.h"

#import "HYPViewController.h"

@implementation HYPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [HYPViewController new];

    [self.window makeKeyAndVisible];

    return YES;
}

@end
