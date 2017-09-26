//
//  IMSetACTempViewController.m
//  IMonitorApplication
//
//  Created by Deepak Chauhan on 11/09/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMSetACTempViewController.h"
#import "EFCircularSlider.h"
#import "Macro.h"

@interface IMSetACTempViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *sliderView;
@property (strong, nonatomic) IBOutlet UILabel *celciusLabel;

@end

@implementation IMSetACTempViewController


#pragma mark - UIView Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Call Initial Method
   // [self initialMethod];
}


- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EFCircularSlider* circularSlider;
        if (windowWidth <= 320) {
             circularSlider = [[EFCircularSlider alloc] initWithFrame:CGRectMake(22, (windowHeight - 380), 275, 275)];
        }else {
             circularSlider = [[EFCircularSlider alloc] initWithFrame:CGRectMake(22, (windowHeight - 410), (windowWidth - 44), (windowWidth - 44))];
        }
        [circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:circularSlider];
        [circularSlider setCurrentValue:0];
    });
}


-(void)valueChanged:(EFCircularSlider*)slider {
    
    if (slider.currentValue >= 0 && slider.currentValue <= 25) {
        self.celciusLabel.text = [NSString stringWithFormat:@"%ld°C",(long)slider.currentValue];
    }
}

- (IBAction)coolButtonAction:(id)sender {
}

- (IBAction)heatButtonAction:(id)sender {
}

- (IBAction)sleepButtonAction:(id)sender {
}

- (IBAction)offButtonAction:(id)sender {
}

#pragma mark - UIMemory Management Method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
