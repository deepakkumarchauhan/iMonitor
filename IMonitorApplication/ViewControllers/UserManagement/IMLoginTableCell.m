//
//  IMLoginTableCell.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMLoginTableCell.h"
#import "Macro.h"

@implementation IMLoginTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewContentCell.layer.borderColor = RGBCOLOR(180, 180, 180, 1).CGColor;
    self.viewContentCell.layer.borderWidth = 1.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
