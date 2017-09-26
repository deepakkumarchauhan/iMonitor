//
//  IMLogoutViewController.h
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogoutProtocolDelegate <NSObject>

- (void)logOutButtonDelegateWithPopUpType: (NSInteger)popUpType;

@end

@interface IMLogoutViewController : UIViewController
@property (nonatomic,weak) id <LogoutProtocolDelegate> delegate;

/*
 1: Logout
 2: Home
 3: Away
 4: Stay
*/
@property (assign, nonatomic) NSInteger typeOfPopUp;

@end
