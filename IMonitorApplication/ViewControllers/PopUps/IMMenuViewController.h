//
//  IMMenuViewController.h
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 11/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuProtocolDelegate <NSObject>

- (void)menuItemClick:(NSInteger)index;

@end

@interface IMMenuViewController : UIViewController

@property (nonatomic,weak) id <MenuProtocolDelegate> delegate;

@end
