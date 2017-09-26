//
//  IMLoginTableCell.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMTextField.h"

@interface IMLoginTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet IMTextField *loginCellTextField;
@property (weak, nonatomic) IBOutlet UIView *viewContentCell;

@end
