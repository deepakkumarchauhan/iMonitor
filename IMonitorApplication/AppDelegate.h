//
//  AppDelegate.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMAppUtility.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *appNavigationController;
@property (nonatomic, assign) deviceType roomType;
@property (assign, nonatomic) BOOL isAdvancedView;
@property (nonatomic, assign) BOOL isReachable;

- (void)setupHomeVC;

@end

