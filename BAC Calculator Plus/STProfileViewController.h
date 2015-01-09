//
//  STProfileVIewController.h
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/27/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STProfile.h"
#import "STAdvancedBACViewController.h"
#import "STProfileViewController.h"


@interface STProfileVIewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *weightEntered;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maleOrFemale;
@property (weak, nonatomic) IBOutlet UISegmentedControl *poundsOrKilograms;
@property (weak, nonatomic) IBOutlet UITextField *ageEntered;
@property (strong, nonatomic) NSString *adjustedWeight;
@property (weak, nonatomic) NSString *gender;

- (IBAction)buildProfile:(id)sender;
- (IBAction)wholeScreenPressed:(id)sender;



@end
