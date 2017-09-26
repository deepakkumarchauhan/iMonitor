//
//  IMRoomCollectionViewCell.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/8/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMRoomCollectionViewCell.h"

@implementation IMRoomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellContainerView.layer.cornerRadius = 2.0;
    self.cellContainerView.layer.borderWidth = 2.0;

}

@end
