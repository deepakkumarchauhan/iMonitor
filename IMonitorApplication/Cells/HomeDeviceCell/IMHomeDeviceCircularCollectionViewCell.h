//
//  IMHomeDeviceCircularCollectionViewCell.h
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 14/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMCircularSlider.h"

@interface IMHomeDeviceCircularCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeCirculatImageView;
@property (strong, nonatomic) IBOutlet UILabel *homeCircularTitleLabel;

@property (strong, nonatomic) IBOutlet IMCircularSlider *sliderView;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;


@end
