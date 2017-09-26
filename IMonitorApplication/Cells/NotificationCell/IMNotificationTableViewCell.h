//
//  IMNotificationTableViewCell.h
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 08/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KILabel.h"

@interface IMNotificationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *notificationTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *notificationAlertTitleLabel;
@property (strong, nonatomic) IBOutlet KILabel *notificationDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *notificationButton;

@end
