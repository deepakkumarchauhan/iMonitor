//
//  IMLabelClass.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/7/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMLabelClass.h"
#import "Macro.h"

@implementation IMLabelClass

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textColor = AppTextColor;
}
@end
