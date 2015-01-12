//
//  STProfileVIewController.m
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/27/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import "STProfileVIewController.h"
#import "STAppDelegate.h"
@interface STProfileVIewController ()

@property NSString *weight;
@end

@implementation STProfileVIewController{
    STAppDelegate *appDel;
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    appDel = (STAppDelegate *) [[UIApplication sharedApplication] delegate];
    appDel.Profile = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buildProfile:(id)sender {
    
    NSString *weight = _weightEntered.text;
    NSString *age = _ageEntered.text;
    
    //metric system or not
    if (_poundsOrKilograms.selectedSegmentIndex == 0) {
        _metric = 0;
    }
    // returns 1.2 to be used in BAC formula [ Weight/2.2 for pounds and Weight/(2.2 - 1.2) for kg
    else{
        _metric = 1.2;
    }
    
    //dummy variable indicating male or female
    
    if (_maleOrFemale.selectedSegmentIndex == 0){
        _MALE = 1;
    }
    else{
        _MALE = 0;
    }
    
    //making the profile from the given information
    
    STProfile *profile = [[STProfile alloc] initWithWeight:weight forAge:age forMetric:_metric andMALE:_MALE];
    
    //Optional check to see what gets passed:
    //NSLog(@"metric: %f", profile.metric);
    //NSLog(@"male: %f", profile.MALE);
    //NSLog(@"weight %@", profile.weight);
    
    [appDel.Profile addObject:profile];
    [_weightEntered resignFirstResponder];
    [_ageEntered resignFirstResponder];

    //alerts if the user forgot to enter a weight
    if (_weightEntered.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a weight"
                                                        message:@"Without a weight, you will be unable to check your BAC"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    // alerts if the user forgot to enter an age
    else if (_ageEntered.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter an age"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    //indicatio the profile has been created
    else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile has been created"
                                                    message:@"Proceed by accessing other tabs"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];


}
}

- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1) {
        // do something here...
        //currently only uses one button
        NSLog(@"it Worked!");
//        [self performSegueWithIdentifier:@"a" sender:nil];
        
    }
}



- (IBAction)wholeScreenPressed:(id)sender {
    [_weightEntered resignFirstResponder];
    [_ageEntered resignFirstResponder];
}






@end
