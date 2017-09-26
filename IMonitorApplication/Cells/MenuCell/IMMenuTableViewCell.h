//
//  IMMenuTableViewCell.h
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 11/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMMenuTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *menuImageView;
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *menuSeperatorLabel;

@end
