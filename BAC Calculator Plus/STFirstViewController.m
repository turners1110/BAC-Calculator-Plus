//
//  STFirstViewController.m
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/5/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import "STFirstViewController.h"

@interface STFirstViewController ()



@end

@implementation STFirstViewController{
    STAppDelegate *appDel;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.text = _beerCount[row];
    label.backgroundColor = [UIColor lightGrayColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    return label;
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component== 0){
    return [_beerCount count];
    }
    if(component== 1){
        return [_wineCount count];
    }

    else{
        return [_shotCount count];
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component== 0){
        return _beerCount[row];
    }
    if (component == 1) {
        return _wineCount[row];
    }
    else{
        return _shotCount[row];
    
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _beerCount = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25"];
    _wineCount = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25"];
    _shotCount = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25"];
    
    //calling app delegate to access profile
    
    appDel = (STAppDelegate *) [[UIApplication sharedApplication] delegate];
   
    
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    float last = [appDel.Profile count];
    last--;
    if (last >= 0) {
        STProfile *profile = [appDel.Profile objectAtIndex: last];
        _WEIGHT = profile.weight;
        _AGE = [profile.age floatValue];
        NSLog(@"%@", profile.weight);
        _MALE = profile.MALE;
        _metric= profile.metric;
    
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        float beerdrank = row;
        NSString *messege = [NSString stringWithFormat:@"%.3f", beerdrank];
        _beersEntered = messege;
    }
    if (component == 1) {
        float winedrank = row;
        NSString *messege = [NSString stringWithFormat:@"%.3f", winedrank];
        _winesEntered = messege;
    }
    if (component == 2) {
        float shotdrank = row;
        NSString *messege = [NSString stringWithFormat:@"%f", shotdrank];
        _shotsEntered = messege;

    }
    
    
}



- (IBAction)malePressed:(id)sender {
    
    //if no available weight it means the user did not enter a profile
    //show alert
    if (_WEIGHT.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Profile Created"
                                                        message:@"Enter a Profile in the profile tab"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    //alert if user is under 21
    if (_WEIGHT.length > 0 && _AGE < 21) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Age"
                                                        message:@"You must be over 21 to legally drink"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    // Getting the total number of drinks
    
    float beerNumber = [_beersEntered floatValue];
    float wineNumber = [_winesEntered floatValue];
    float shotNumber = [_shotsEntered floatValue];
    float drinkNumber = beerNumber + wineNumber + shotNumber;
    
    //time drinking
    float time = [_timeEntered.text floatValue];
    
    //weight
    float weight = [_WEIGHT floatValue];
    
    //gender and related factors
    if (_MALE == 1) {
        _rateOfElimination = .015;
        _WaterConst = .58;
    }
    else{
        _rateOfElimination = .017;
        _WaterConst = .49;
    }

    //BAC formula
    float BAC =((.806* drinkNumber *1.2))/(_WaterConst * weight) - (_rateOfElimination * time);
    
    _FinalBac = [NSString stringWithFormat:@"%.3f", BAC];

    
    //Different alert messeges
    float finalBAC = [_FinalBac floatValue];
    
    if (finalBAC > .5) {
     
        

        
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BAC is too high"
                                                    message:@"Please enter a realistic amount"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
    }
        
    if (finalBAC > .08 & finalBAC < .15) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Greater than the legal limit"
                                                        message:@"You are not legally allowed to drive"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];

    }
    
    if (finalBAC > .15 & finalBAC < .2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Significant Impairment"
                                                        message:@"Dysphoria and Nausea may be present"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    if (finalBAC > .2 & finalBAC < .25) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Blackout zone"
                                                        message:@"May need help standing, blackout likely"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    if (finalBAC > .25 & finalBAC < .5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"STOP DRINKING"
                                                        message:@"Al functions impaired, risk of choking"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    //make the BAC appear
    
    [_BACLabel setText:_FinalBac];
}

- (IBAction)wholeScreen:(id)sender {
    [_timeEntered resignFirstResponder];
}

@end
