//
//  IMButtonClass.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 07/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMButtonClass.h"

@implementation IMButtonClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self.layer setCornerRadius:20.0];
    [self setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}


@end
