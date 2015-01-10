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
    float weightVal = [weight floatValue];
    NSString *age = _ageEntered.text;
    
    if (_poundsOrKilograms.selectedSegmentIndex == 0) {
        _metric = 0;
    }
    else{
        _metric = 1.2;
    }
    
    
    if (_maleOrFemale.selectedSegmentIndex == 0){
        _MALE = 1;
    }
    else{
        _MALE = 0;
    }
    
    
    STProfile *profile = [[STProfile alloc] initWithWeight:weight forAge:age forMetric:_metric andMALE:_MALE];
    
    
    NSLog(@"metric: %f", profile.metric);
    NSLog(@"male: %f", profile.MALE);
    NSLog(@"weight %@", profile.weight);
    
    [appDel.Profile addObject:profile];
    [_weightEntered resignFirstResponder];
    [_ageEntered resignFirstResponder];

    if (_weightEntered.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a weight"
                                                        message:@"Without a weight, you will be unable to check your BAC"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else if (_ageEntered.text.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter an age"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    
    
    
    else {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Profile has been created"
                                                    message:@"Proceed by accessing other tabs"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];


}
}
//I want to be able to switch to next tab, or even better would be to have this view controller be the main tab anf it would be a forced advance into the tab view controller, maybe not, Ill see.
- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1) {
        // do something here...
        NSLog(@"it Worked!");
//        [self performSegueWithIdentifier:@"a" sender:nil];
        
    }
}



- (IBAction)wholeScreenPressed:(id)sender {
    [_weightEntered resignFirstResponder];
    [_ageEntered resignFirstResponder];
}






@end
