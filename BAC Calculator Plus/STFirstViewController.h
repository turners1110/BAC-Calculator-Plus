//
//  STFirstViewController.h
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/5/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAppDelegate.h"
#import "STProfile.h"
#import "STProfileViewController.h"

@interface STFirstViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>{
    UIViewController *appDelegate;
}

@property (strong, nonatomic) NSString *winesEntered;
@property (strong, nonatomic) NSString *beersEntered;
@property (strong, nonatomic) NSString *shotsEntered;
@property (weak, nonatomic) IBOutlet UITextField *timeEntered;
@property (weak, nonatomic) NSString *WEIGHT;
@property (weak, nonatomic) IBOutlet UILabel *BACLabel;
- (IBAction)malePressed:(id)sender;

- (IBAction)wholeScreen:(id)sender;
@property(nonatomic) float minimumValue;
@property NSArray *beerCount;
@property NSArray *wineCount;
@property NSArray *shotCount;
@property NSArray *timeCount;
@property float beerNumber;
@property float WineNumber;
@property float shotNumber;
@property (weak, nonatomic) NSString *FinalBac;
@property float MALE;
@property float metric;
@property float rateOfElimination;
@property float WaterConst;


@end
