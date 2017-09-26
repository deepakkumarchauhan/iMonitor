//
//  IMRoomCollectionViewCell.h
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/8/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMRoomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *roomImageView;
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
@property (weak, nonatomic) IBOutlet UIView *cellContainerView;

@end
