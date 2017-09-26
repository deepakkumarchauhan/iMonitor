//
//  IMHomeViewController.m
//  IMonitorApplication
//
//  Created by Ratneshwar Singh on 9/8/17.
//  Copyright © 2017 Mobiloitte Inc. All rights reserved.
//

#import "IMHomeViewController.h"
#import "IMRoomCollectionViewCell.h"
#import "Macro.h"
#import "FTPopOverMenu.h"
#import "WYPopoverController.h"
#import "IMMenuViewController.h"
#import "IMStaticViewController.h"
#import "IMCustomerSupportViewController.h"
#import "IMNotificationViewController.h"
#import "IMAppUtility.h"
#import "IMEnquiryViewController.h"
#import "IMLogoutViewController.h"
#import "IMHomeDeviceViewController.h"
#import "AppDelegate.h"
#import "IMLogoutViewController.h"
#import "IMSynchDeviceModelViewController.h"
#import "IMEnergyViewController.h"
#import "IMFavouriteViewController.h"

@interface IMHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, WYPopoverControllerDelegate, MenuProtocolDelegate, LogoutProtocolDelegate> {
    NSInteger selectedItemIndex;
    WYPopoverController* popoverController;
    
    //Temp variables to hold the frames of views
    CGRect frameLeftOptionView,frameRightOptionView,frameBottomOptionView,frameLeftButton,frameRightButton,frameBottomButton;
    BOOL isByRoomView;
}

@property (weak, nonatomic) IBOutlet UIButton *upFloorNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *downFloorNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *floorCountLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UICollectionView *bottomFloorCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *leftOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *rightOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomOptionButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonViewBy;
@property (weak, nonatomic) IBOutlet UIView *viewBottomFloor;

//Dropdown options
@property (weak, nonatomic) IBOutlet UIView *leftOptionsView;
@property (weak, nonatomic) IBOutlet UIView *rightOptionsView;
@property (weak, nonatomic) IBOutlet UIView *bottomOptionsView;

//Manage Constraint to animate the button
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOptionButtonLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOptionButtonTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightOptionButtonTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOptionsViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOptionsViewConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightOptionsViewConstraint;

//Manages Navigation and load view on container
@property (strong, nonatomic) UINavigationController *homeNavigationController;
@property (strong, nonatomic) UIViewController *currentViewController;

//Holds count of floor
@property (assign, nonatomic) NSInteger currentFloorCount;

@end

@implementation IMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpInitialLoadingHomeViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.currentViewController.view.frame = self.containerView.bounds;
}

#pragma mark -******************* Helper Methods **********************-
- (void)setUpInitialLoadingHomeViewController {
    
    self.currentFloorCount = 0;
    selectedItemIndex = 0;
    if(self.currentFloorCount <= 0)
        self.floorCountLabel.text = [NSString stringWithFormat:@"Floor 0%ld",(long)self.currentFloorCount];
    else
        self.floorCountLabel.text = [NSString stringWithFormat:@"Floor 0%ld",(long)self.currentFloorCount];
    
    //Setting Up bottom CollectionView
    [self.bottomFloorCollectionView registerNib:[UINib nibWithNibName:@"IMRoomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"IMRoomCollectionViewCell"];
    
    
    [self.upFloorNumberButton setTitleColor:AppTextColor forState:UIControlStateNormal];
    [self.downFloorNumberButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.currentViewController = [UIViewController new];
    [self settingUpNavigationToLoadManageNavigation];
    
    //Setting corner Radius for view of options
    setCornerForView(self.leftOptionsView, RGBCOLOR(97, 174, 224, 1.0), 1.0, 100);
    setCornerForView(self.rightOptionsView, RGBCOLOR(97, 174, 224, 1.0), 1.0, 100);
    setCornerForView(self.bottomOptionsView, RGBCOLOR(97, 174, 224, 1.0), 1.0, 100);
    
    [self.leftOptionsView setBackgroundColor:RGBCOLOR(60, 167, 227, 0.7)];
    [self.rightOptionsView setBackgroundColor:RGBCOLOR(60, 167, 227, 0.7)];
    [self.bottomOptionsView setBackgroundColor:RGBCOLOR(60, 167, 227, 0.7)];
    
    frameLeftButton = self.leftOptionButton.frame;
    frameRightButton = self.rightOptionButton.frame;
    frameBottomButton = self.bottomOptionButton.frame;
    
    frameLeftOptionView = self.leftOptionsView.frame;
    frameRightOptionView = self.rightOptionsView.frame;
    frameBottomOptionView = self.bottomOptionsView.frame;
    
    isByRoomView = YES;
}


/**
 UINavigation Allocation and flow management
 */
- (void)settingUpNavigationToLoadManageNavigation {
    
    IMHomeDeviceViewController *customerSupprtVC = [[IMHomeDeviceViewController alloc]initWithNibName:@"IMHomeDeviceViewController" bundle:nil];
    self.homeNavigationController = [[UINavigationController alloc]initWithRootViewController:customerSupprtVC];
    [self.homeNavigationController.navigationBar setHidden:YES];
    [self.currentViewController willMoveToParentViewController:nil];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];
    self.currentViewController = self.homeNavigationController;
    [self addChildViewController:self.homeNavigationController];
    [self.containerView addSubview:self.currentViewController.view];
    self.currentViewController.view.frame = self.containerView.bounds;
    [self.currentViewController didMoveToParentViewController:self];
    
}

#pragma mark -***************** UICollectionViewDataSource Methods ****************-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    IMRoomCollectionViewCell *roomCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IMRoomCollectionViewCell" forIndexPath:indexPath];
    if (selectedItemIndex == indexPath.item)
        roomCollectionCell.cellContainerView.layer.borderColor = AppTextColor.CGColor;
    else
        roomCollectionCell.cellContainerView.layer.borderColor =  [UIColor darkGrayColor].CGColor;
    
    return roomCollectionCell;
}

#pragma mark -****************** UICollectionViewDelegate Methods ******************-
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
     selectedItemIndex = indexPath.item;
    [self.bottomFloorCollectionView reloadData];

}

#pragma mark -******************* UICollectionViewDelegateFlowLayout Methods *****************
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(70, 70);
    return cellSize;
}


#pragma mark-******************* Button Action & Selector Methods ****************-
- (IBAction)commonButtonAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 91:{
            //Back Button
          //  [self.navigationController popViewControllerAnimated:YES];
            [self.homeNavigationController popViewControllerAnimated:YES];
        }
            break;
        case 92:{
            //Menu Button
            [FTPopOverMenu showForSender:sender withMenuArray:@[@"Home", @"About Us", @"Enquiry", @"Refer a Friend", @"Sync DeviceModel Status", @"DeviceModel Refresh", @"Customer Support", @"Logout"] imageArray:@[@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"T"] headerTitle:@"Hello Ratan!!" doneBlock:^(NSInteger selectedIndex) {
                [self.buttonViewBy setHidden:YES];
                switch (selectedIndex) {
                    case 0: {
                        [self.buttonViewBy setHidden:NO];
                        BOOL isControllerFound = NO;
                        NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                        for (UIViewController *viewControllerObj in viewControllerArray) {
                            if([viewControllerObj isKindOfClass:[IMHomeDeviceViewController class]]) {
                                [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                                isControllerFound = YES;
                                break;
                            }
                        }
                        if(!isControllerFound) {
                            IMHomeDeviceViewController *objVC = [[IMHomeDeviceViewController alloc] initWithNibName:@"IMHomeDeviceViewController" bundle:nil];
                            [self.homeNavigationController pushViewController:objVC animated:YES];
                        }
                    }
                        break;
                        
                    case 1:{
                        BOOL isControllerFound = NO;
                        NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                        for (UIViewController *viewControllerObj in viewControllerArray) {
                            if([viewControllerObj isKindOfClass:[IMStaticViewController class]]) {
                                [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                                isControllerFound = YES;
                                break;
                            }
                        }
                        if(!isControllerFound) {
                            IMStaticViewController *objVC = [[IMStaticViewController alloc] initWithNibName:@"IMStaticViewController" bundle:nil];
                            [self.homeNavigationController pushViewController:objVC animated:YES];
                        }
                    }
                        break;
                        
                    case 2:{
                        BOOL isControllerFound = NO;
                        NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                        for (UIViewController *viewControllerObj in viewControllerArray) {
                            if([viewControllerObj isKindOfClass:[IMEnquiryViewController class]]) {
                                [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                                isControllerFound = YES;
                                break;
                            }
                        }
                        if(!isControllerFound) {
                        IMEnquiryViewController *objVC = [[IMEnquiryViewController alloc] initWithNibName:@"IMEnquiryViewController" bundle:nil];
                        [self.homeNavigationController pushViewController:objVC animated:YES];
                        }
                    }
                        break;
                        
                    case 3:{
                        // Refer a friend
                        NSString * message = @"We are doint IOT Application.";
                        // UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
                        NSArray * shareItems = @[message];
                        UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
                        [self presentViewController:avc animated:YES completion:nil];
                        
                    }
                        break;
                    case 4:{
                        // Sync Device Model Status
                        BOOL isControllerFound = NO;
                        NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                        for (UIViewController *viewControllerObj in viewControllerArray) {
                            if([viewControllerObj isKindOfClass:[IMSynchDeviceModelViewController class]]) {
                                [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                                isControllerFound = YES;
                                break;
                            }
                        }
                        if(!isControllerFound) {
                            IMSynchDeviceModelViewController *objVC = [[IMSynchDeviceModelViewController alloc] initWithNibName:@"IMSynchDeviceModelViewController" bundle:nil];
                            [self.homeNavigationController pushViewController:objVC animated:YES];
                        }
                        
                    }
                        break;
                        
                    case 5:{
                        // Device model
                        [IMAppUtility alertWithTitle:BLANK andMessage:WORKING_PROGRESS andController:self];
                        
                    }
                        break;
                        
                    case 6:{
                        BOOL isControllerFound = NO;
                        NSArray *viewControllerArray = [self.homeNavigationController viewControllers];
                        for (UIViewController *viewControllerObj in viewControllerArray) {
                            if([viewControllerObj isKindOfClass:[IMCustomerSupportViewController class]]) {
                                [self.homeNavigationController popToViewController:viewControllerObj animated:YES];
                                isControllerFound = YES;
                                break;
                            }
                        }
                        if(!isControllerFound) {
                        IMCustomerSupportViewController *objVC = [[IMCustomerSupportViewController alloc]initWithNibName:@"IMCustomerSupportViewController" bundle:nil];
                        [self.homeNavigationController pushViewController:objVC animated:YES];
                        }
                    }
                        break;
                        
                    case 7:{
                        
                        IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
                        objVC.delegate = self;
                        objVC.typeOfPopUp = 1;
                        objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                        [self.navigationController presentViewController:objVC animated:NO completion:nil];
                    }
                        break;
                    default:
                        break;
                }
            }
                            dismissBlock:^{
            }];
        }
            break;
        case 93:{
            //List by options Button
            [FTPopOverMenu showForSender:sender withMenuArray:@[@"By Room", @"By Appliance", @"Enable Advance View"] imageArray:([APPDELEGATE roomType] == isRoom) ? @[@"e",@"d",([APPDELEGATE isAdvancedView] == YES)?@"D":@"2"]:@[@"d",@"e",([APPDELEGATE isAdvancedView] == YES)?@"D":@"2"]  headerTitle:@"CHANGE VIEW" doneBlock:^(NSInteger selectedIndex) {
                
                [self byRoomApplianceItemClick:selectedIndex];
                AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                if(selectedIndex == 2) {
                    appDelegate.isAdvancedView = !appDelegate.isAdvancedView;
                }
            } dismissBlock:^{
            }];
        }
            break;
        case 94:{
            //Floor Up
            [self.downFloorNumberButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [sender setTitleColor:AppTextColor forState:UIControlStateNormal];
            self.currentFloorCount++;
            if(self.currentFloorCount <= 9)
                self.floorCountLabel.text = [NSString stringWithFormat:@"Floor 0%ld",(long)self.currentFloorCount];
            else
                self.floorCountLabel.text = [NSString stringWithFormat:@"Floor %ld",(long)self.currentFloorCount];
        }
            break;
        case 95:{
            //Floor Down
            [self.upFloorNumberButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [sender setTitleColor:AppTextColor forState:UIControlStateNormal];
            if(self.currentFloorCount > 0)
                self.currentFloorCount--;
            
            if(self.currentFloorCount <= 9)
                self.floorCountLabel.text = [NSString stringWithFormat:@"Floor 0%ld",(long)self.currentFloorCount];
            else
                self.floorCountLabel.text = [NSString stringWithFormat:@"Floor %ld",(long)self.currentFloorCount];
        }
            break;
        case 96:{
            //Dropdown Left
        }
            break;
        case 97:{
            //Dropdown right
        }
            break;
        case 98:{
            //Dropdown Bottom
        }
            break;
        default:
            break;
    }
}


/**
 Left options button to show left options

 @param sender button tapped
 */
- (IBAction)leftOptionButtonAction: (UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self animateView:self.leftOptionsView andIsToShow:[sender isSelected] andType:1];
}


- (IBAction)rightOptionButtonAction: (UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self animateView:self.rightOptionsView andIsToShow:[sender isSelected] andType:2];
}

- (IBAction)bottomOptionButtonAction: (UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self animateView:self.bottomOptionsView andIsToShow:[sender isSelected] andType:3];
}


/**
 Button action handles tap on Options buttons placed on left, right and bottom views

 @param sender tapped button obj
 */
- (IBAction)commonButtonActionForOptions:(UIButton *)sender {
    switch (sender.tag) {
            //Home
        case 151: {
            IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
            objVC.typeOfPopUp = 2;
            objVC.delegate = self;
            objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self.navigationController presentViewController:objVC animated:NO completion:nil];
        }
            break;
            //Away
        case 152: {
            IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
            objVC.typeOfPopUp = 3;
            objVC.delegate = self;
            objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self.navigationController presentViewController:objVC animated:NO completion:nil];
        }
            break;
            //Stay
        case 153: {
            IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
            objVC.typeOfPopUp = 4;
            objVC.delegate = self;
            objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self.navigationController presentViewController:objVC animated:NO completion:nil];
        }
            break;
            //Logout
        case 154: {
            IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
            objVC.typeOfPopUp = 1;
            objVC.delegate = self;
            objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self.navigationController presentViewController:objVC animated:NO completion:nil];

        }
            break;
            //Notifications
        case 155: {
            
            IMNotificationViewController *notificationObjVC = [[IMNotificationViewController alloc]initWithNibName:@"IMNotificationViewController" bundle:nil];
            [self.navigationController pushViewController:notificationObjVC animated:YES];
        }
            break;
            //Favourite
        case 156: {
            IMFavouriteViewController *notificationObjVC = [[IMFavouriteViewController alloc]initWithNibName:@"IMFavouriteViewController" bundle:nil];
            [self.navigationController pushViewController:notificationObjVC animated:YES];
        }
            break;
            //Energy
        case 157: {
            IMEnergyViewController *objVC = [[IMEnergyViewController alloc] initWithNibName:@"IMEnergyViewController" bundle:nil];
            [self.navigationController pushViewController:objVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - Custom Delegate Method
- (void)menuItemClick:(NSInteger)index {
    
    switch (index) {
        case 0: {
            AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [appDelegate setupHomeVC];
        }
            break;
            
        case 1:{
            IMStaticViewController *objVC = [[IMStaticViewController alloc] initWithNibName:@"IMStaticViewController" bundle:nil];
            [self.homeNavigationController pushViewController:objVC animated:YES];
        }
            break;
            
        case 2:{
            IMEnquiryViewController *objVC = [[IMEnquiryViewController alloc] initWithNibName:@"IMEnquiryViewController" bundle:nil];
            [self.homeNavigationController pushViewController:objVC animated:YES];
        }
            break;
            
        case 3:{
            // Refer a friend
            NSString * message = @"My too cool Son";
           // UIImage * image = [UIImage imageNamed:@"boyOnBeach"];
            NSArray * shareItems = @[message];
            UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
            [self presentViewController:avc animated:YES completion:nil];
            
        }
            break;
        case 4:{
            // Sync
            [IMAppUtility alertWithTitle:BLANK andMessage:WORKING_PROGRESS andController:self];

        }
            break;
            
        case 5:{
            // Device model
            [IMAppUtility alertWithTitle:BLANK andMessage:WORKING_PROGRESS andController:self];

        }
            break;
            
        case 6:{
            //Customer Support Controller
            IMCustomerSupportViewController *objVC = [[IMCustomerSupportViewController alloc]initWithNibName:@"IMCustomerSupportViewController" bundle:nil];
            [self.homeNavigationController pushViewController:objVC animated:YES];
        }
            break;
            
        case 7:{
            //Logout Option
            IMLogoutViewController *objVC = [[IMLogoutViewController alloc] initWithNibName:@"IMLogoutViewController" bundle:nil];
            objVC.delegate = self;
              objVC.typeOfPopUp = 1;
            objVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self.navigationController presentViewController:objVC animated:NO completion:nil];
        }
            break;
            
        default:
            break;
    }
}


/**
 item click for home screen

 @param index indexSelected
 */
- (void)byRoomApplianceItemClick:(NSInteger)index {
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (index == 0) {
        // This is the room type
        appDelegate.roomType = isRoom;
        [self.bottomViewHeightConstraint setConstant:80.0];
        [self.bottomOptionsViewConstraint setConstant:-120];
        [self.viewBottomFloor setHidden:NO];
    }
    else if(index == 1) {
        // This is the appliance type
        appDelegate.roomType = isAppliance;
        [self.bottomViewHeightConstraint setConstant:1.0];
        [self.bottomOptionsViewConstraint setConstant:-200];
        [self.viewBottomFloor setHidden:YES];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeViewNotification" object:nil];
}


/**
 Back Delegate method from Logout Screen

 @param popUpType type of Pop Up shown basically
 1: Logout
 2: Home
 3: Away
 4: Stay
 */
- (void)logOutButtonDelegateWithPopUpType:(NSInteger)popUpType {
    
    switch (popUpType) {
        case 1: {
            [self.leftOptionsView setHidden:YES];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }
    
}


- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller {
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    popoverController.delegate = nil;
    popoverController = nil;
}

#pragma mark -************************** Animating View ***********************-

/**
 This method is used to make the view animated

 @param animatingView view which need to animate
 @param isToShow managed to show hide and show of view
 @param optionType 1: LeftOptionView, 2: Right Option View, 3: Bottom Option View
 */
- (void)animateView: (UIView *)animatingView andIsToShow:(BOOL)isToShow andType:(NSInteger)optionType{
    
    if (isToShow) {
        [UIView animateKeyframesWithDuration:0.5
                                       delay:0.0
                                     options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      switch (optionType) {
                                              //Left
                                          case 1: {
                                              animatingView.frame = CGRectMake(animatingView.frame.origin.x + 160, animatingView.frame.origin.y, animatingView.frame.size.width, animatingView.frame.size.height);
                                              self.leftOptionButton.frame = CGRectMake(self.leftOptionButton.frame.origin.x + 160, self.leftOptionButton.frame.origin.y, self.leftOptionButton.frame.size.width, self.leftOptionButton.frame.size.height);
                                          }
                                              break;
                                          case 2: {
                                              //Right
                                              animatingView.frame = CGRectMake(animatingView.frame.origin.x - 160, animatingView.frame.origin.y, animatingView.frame.size.width, animatingView.frame.size.height);
                                             self.rightOptionButton.frame = CGRectMake(self.rightOptionButton.frame.origin.x - 160, self.rightOptionButton.frame.origin.y, self.rightOptionButton.frame.size.width, self.rightOptionButton.frame.size.height);
                                          }
                                              break;
                                          case 3: {
                                              //Bottom
                                              animatingView.frame = CGRectMake(animatingView.frame.origin.x , animatingView.frame.origin.y - 160, animatingView.frame.size.width, animatingView.frame.size.height);
                                              self.bottomOptionButton.frame = CGRectMake(self.bottomOptionButton.frame.origin.x, self.bottomOptionButton.frame.origin.y - 160, self.bottomOptionButton.frame.size.width, self.bottomOptionButton.frame.size.height);
                                          }
                                              break;
                                          default:
                                              break;
                                      }
                                  }
                                  completion:^(BOOL finished) {
                                      
                                  }];
    }
    else {
        [UIView animateKeyframesWithDuration:0.5
                                       delay:0.0
                                     options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      switch (optionType) {
                                          case 1: {
                                               animatingView.frame = CGRectMake(animatingView.frame.origin.x - 160, animatingView.frame.origin.y, animatingView.frame.size.width, animatingView.frame.size.height);
                                               self.leftOptionButton.frame = CGRectMake(self.leftOptionButton.frame.origin.x-160, self.leftOptionButton.frame.origin.y, self.leftOptionButton.frame.size.width, self.leftOptionButton.frame.size.height);
                                          }
                                              break;
                                          case 2: {
                                                animatingView.frame = CGRectMake(animatingView.frame.origin.x + 160, animatingView.frame.origin.y, animatingView.frame.size.width, animatingView.frame.size.height);
                                                self.rightOptionButton.frame = CGRectMake(self.rightOptionButton.frame.origin.x+160, self.rightOptionButton.frame.origin.y, self.rightOptionButton.frame.size.width, self.rightOptionButton.frame.size.height);
                                          }
                                              break;
                                          case 3: {
                                                animatingView.frame = CGRectMake(animatingView.frame.origin.x, animatingView.frame.origin.y + 160, animatingView.frame.size.width, animatingView.frame.size.height);
                                              self.bottomOptionButton.frame = CGRectMake(self.bottomOptionButton.frame.origin.x,self.bottomOptionButton.frame.origin.y + 160 , self.bottomOptionButton.frame.size.width, self.bottomOptionButton.frame.size.height);
                                          }
                                              break;
                                          default:
                                              break;
                                      }
                                    
                                  }
                                  completion:^(BOOL finished) {
                                  }];
        
    }
}

@end
