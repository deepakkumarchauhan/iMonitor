//
//  AppDelegate.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "IMLoginViewController.h"
#import "IMForgotViewController.h"
#import "IMEnquiryViewController.h"
#import "IMStaticViewController.h"
#import "IMCustomerSupportViewController.h"
#import "IMEnquiryAlertViewController.h"
#import "IMLogoutViewController.h"
#import "IMResetPasswordViewController.h"
#import "IMDeviceOffViewController.h"
#import "IMNotificationViewController.h"
#import "IMMenuViewController.h"
#import "IMHomeViewController.h"
#import "IMSetACTempViewController.h"
#import "Reachability.h"
#import "Macro.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpNavigationAndController];
    
    //check for the internet reachability
    [self checkReachability];

    //Setting up default data for web api
    [self defaultDataSetUpForWebServiceIntegration];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)setupHomeVC {
    
    self.appNavigationController = [[UINavigationController alloc] initWithRootViewController:[[IMHomeViewController alloc] initWithNibName:@"IMHomeViewController" bundle:nil]];
    [self.appNavigationController setNavigationBarHidden:YES];
   // self.type = type;
    [self.window setRootViewController:self.appNavigationController];
    [self.window makeKeyAndVisible];
    
}

#pragma mark -********************  App Initial Launch *******************-
- (void)setUpNavigationAndController {
    
    //Settiing view type for home scree
    self.roomType = isRoom;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    IMLoginViewController *loginViewControllerObj = [[IMLoginViewController alloc]initWithNibName:@"IMLoginViewController" bundle:nil];
    self.appNavigationController = [[UINavigationController alloc]initWithRootViewController:loginViewControllerObj];
    [self.appNavigationController.navigationBar setHidden:YES];
    self.appNavigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.window setRootViewController:self.appNavigationController];
    [self.window makeKeyAndVisible];
}

- (void)defaultDataSetUpForWebServiceIntegration {
    
    //Data Center
    NSString *dataCenterServiceURL = [[@"" stringByReplacingOccurrencesOfString:@"pointofsaleservice.asmx" withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    dataCenterServiceURL = [dataCenterServiceURL stringByReplacingOccurrencesOfString:@"www." withString:@""];
    [NSUSERDEFAULT setValue:dataCenterServiceURL forKey:kSerivceURL];
    [NSUSERDEFAULT setValue:@"http://www.imsserver.com:8080/imonitor/" forKey:kSerivceBaseURL];
    [NSUSERDEFAULT synchronize];
}


/*
 * initialize the internet reachability and start the notifier for any subsequent change
 */
-(void)checkReachability {
    
    Reachability * reach = [Reachability reachabilityForInternetConnection];
    self.isReachable = [reach isReachable];
    
    reach.reachableBlock = ^(Reachability * reachability) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.isReachable = YES;  });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability) {
        dispatch_async(dispatch_get_main_queue(), ^{ self.isReachable = NO; });
    };
    
    [reach startNotifier];
}
@end
