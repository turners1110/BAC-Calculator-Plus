//
//  STAdvancedBACViewController.m
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/14/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//


#import "STAdvancedBACViewController.h"

@interface STAdvancedBACViewController ()

@property (nonatomic, copy) NSDictionary *brand;
@property (nonatomic, copy) NSArray *keys;
@property (nonatomic, copy) NSMutableArray *filteredNames;
@property (nonatomic, copy) NSMutableArray *wineFiltered;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, copy) NSDictionary *beerValues;
@property (nonatomic, copy) NSDictionary *WineValues;
@property (nonatomic, copy) NSArray *beerKeys;
@property (nonatomic, strong) NSDate *pastDate;
@property (nonatomic, copy) NSDictionary *wineType;
@property (nonatomic, copy) NSArray *wineKeys;
@end

@implementation STAdvancedBACViewController{
        STAppDelegate *appDel;
    
}
@synthesize brand, keys, filteredNames, searchController, beerValues, beerKeys, wineType, wineKeys, WineValues, wineFiltered;

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
   
    // setitng up the alcoghol tables
    // wine table is currently used for spirits
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UITableView *wineTableVIew = (id)[self.view viewWithTag:3];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [wineTableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BeerList" ofType:@"plist"];
    brand = [NSDictionary dictionaryWithContentsOfFile:path];
    keys = [[brand allKeys]sortedArrayUsingSelector:@selector(compare:)];
    NSString *winepath = [[NSBundle mainBundle] pathForResource:@"LiquorCheck" ofType:@"plist"];
    
    wineType = [NSDictionary dictionaryWithContentsOfFile:winepath];
    wineKeys = [[wineType allKeys]sortedArrayUsingSelector:@selector(compare:)];
    
    // setup search results
    filteredNames = [[NSMutableArray alloc]init];
    searchController = [[UISearchDisplayController alloc]init];
    searchController.searchResultsDataSource = self;
    
    //comparisson valus to get alcohol content
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"CHECK" ofType:@"plist"];
    NSString *winePath2 = [[NSBundle mainBundle] pathForResource:@"Liquor" ofType:@"plist"];
    beerValues = [NSDictionary dictionaryWithContentsOfFile:path2];
    WineValues = [NSDictionary dictionaryWithContentsOfFile:winePath2];
    beerKeys = [[beerValues allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    //look of the tabl
    tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"MetalTable2.png"]];
    [tableView setSectionIndexColor:[UIColor blueColor]];
    [tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    
    //import profile
    appDel = (STAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    [_beerTable reloadData];
    [_wineTable reloadData];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    float last = [appDel.Profile count];
    last--;
    
    //imports profile data
    if (last >= 0) {
        STProfile *profile = [appDel.Profile objectAtIndex: last];
        _WEIGHT = profile.weight;
        _MALE = profile.MALE;
        _metric= profile.metric;
        _AGE = [profile.age floatValue];
    

}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //tag 1 is the beer table
    if (tableView.tag == 1) {
        if (_alcoholSelector.selectedSegmentIndex == 0) {
            return [keys count];
            
        }
        else {
            return [wineKeys count];
        }
        
    }
    
    else{
        return 1;
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor lightGrayColor];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(25/255.0) green:(75/255.0) blue:(255.0/255.0) alpha:1.0];
    
    bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;
    
     //tag 1 is the beer table
    if (tableView.tag == 1) {
        if (_alcoholSelector.selectedSegmentIndex == 0) {
            NSString *key = keys[indexPath.section];
            NSArray *keyValues = brand[key];
            
            cell.textLabel.text = keyValues[indexPath.row];
        }
        else{
            NSString *key = keys[indexPath.section];
            NSArray *keyValues = wineType[key];
            
            cell.textLabel.text = keyValues[indexPath.row];
        }}

    //search results
    else{
        
        cell.textLabel.text = filteredNames[indexPath.row];
        //            tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"MetalTable2.png"]];
        //        tableView.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     //tag 1 is the beer table
    if (tableView.tag == 1) {
        if (_alcoholSelector.selectedSegmentIndex == 0) {
            NSString *key = keys[section];
            
            NSArray *keyValues = brand[key];
            
            return [keyValues count];
        }
        else {
            NSString *key = wineKeys[section];
            
            NSArray *keyValues = wineType[key];
            return [keyValues count];
        }
        
    }
    else{
        return [filteredNames count];
        
        
    }
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (tableView.tag == 1) {
        return keys;
    }
    else{
        return nil;
    }
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 1){
        return keys[section];
    }
    else{
        return nil;
    }
}

#pragma mark

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [filteredNames removeAllObjects];
    if (searchString.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [search] %@", self.searchBar.text];
        for (NSString *key in keys)  {
            NSArray *matches = [brand[key]filteredArrayUsingPredicate:predicate];
            NSArray *winematches = [wineType[key]filteredArrayUsingPredicate:predicate];
            if (_alcoholSelector.selectedSegmentIndex == 0) {
                [filteredNames addObjectsFromArray:matches];
            }
            else{
                [filteredNames addObjectsFromArray:winematches];
            }
        }
    }
    return YES;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1) {
        if (_alcoholSelector.selectedSegmentIndex == 0) {
            NSString *key = keys[indexPath.section];
            NSArray *keyValues = brand[key];
            
            NSString *BeerSelected = keyValues[indexPath.row];
            _alcoholContent = beerValues[BeerSelected];
            
        }
        else{
            NSString *key = keys[indexPath.section];
            NSArray *keyValues = wineType[key];
            
            NSString *WineSelected = keyValues[indexPath.row];
            _alcoholContent = WineValues[WineSelected];
        }
        
    }
    else{
        if (_alcoholSelector.selectedSegmentIndex == 0) {
            NSString *BeerSelected = filteredNames[indexPath.row];
            _alcoholContent = beerValues[BeerSelected];
        }
        else{
            NSString *WineSelected = filteredNames[indexPath.row];
            _alcoholContent = WineValues[WineSelected];
        }
    }
}

//calculating BAC from alcohol inforation
- (IBAction)drinkPressed:(id)sender {
    
    // alerts user if there has not been a profile created
    if (_WEIGHT.length < 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Profile Created"
                                                        message:@"Enter a Profile in the profile tab"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    //alerts user if they are under 21
    if (_WEIGHT.length > 0 && _AGE < 21) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Age"
                                                        message:@"You must be over 21 to legally drink"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    
    // get current date to factor in time of drinking
    
    NSDate * now = [NSDate date];
    NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:self.pastDate];
    double secondsInAnHour = 3600;
    float hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    // access information to run BAC calculation
    float previousBAC = [_bacLabel.text floatValue];
    float Weight = [_WEIGHT floatValue];
    float alcContent = [_alcoholContent floatValue];
    
    //gender identifier male = 1 female = 0
    if (_MALE == 1) {
        _rateOfElimination = .015;
        _WaterConst = .58;
    }
    else{
        _rateOfElimination = .017;
        _WaterConst = .49;
    }
    
    //access weight and factor inunit type
    Weight = (Weight/ (2.2 - _metric));
    
    //size of drink based on what the user selected
    switch (_beerSize.selectedSegmentIndex) {
      case 0:
        _drinkSize = 12;
        break;
      case 1:
        _drinkSize = 20;
        break;
      case 2:
        _drinkSize = 40;
        break;
      case 3:
        _drinkSize = 1.5;
        break;
                
      default:
        break;
}
    
    //for the first drink where no timepassed is 0:
    if (hoursBetweenDates > 0) {
    _BAC = ((.806*(1.667*(.01)* alcContent * _drinkSize *1.2))/(_WaterConst * Weight)) - (_rateOfElimination * hoursBetweenDates);
    }
    
    //for any subsequent drink:
    else{
        _BAC = ((.806*(1.667*(.01)* alcContent * _drinkSize *1.2))/(_WaterConst * Weight)) - (_rateOfElimination * 0);
    }
    
    //Include previous BAC before drink (time factored in in the formula
    
    float totalBAC = _BAC + previousBAC;
   
    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", totalBAC];
    _bacLabel.text = calculatedBAC;
    
    // setting the "past date to be used for next drink
    self.pastDate = now;
    
    //alert messages dependning on the BAC level
    if (totalBAC > .5) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BAC is too high"
                                                        message:@"Please enter a realistic amount"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    
    if (totalBAC > .08 & totalBAC < .15) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Greater than the legal limit"
                                                        message:@"You are not legally allowed to drive"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    if (totalBAC > .15 & totalBAC < .2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Significant Impairment"
                                                        message:@"Dysphoria and Nausea may be present"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    if (totalBAC > .2 & totalBAC < .25) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Blackout zone"
                                                        message:@"May need help standing, blackout likely"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
    
    if (totalBAC > .25 & totalBAC < .5) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"STOP DRINKING"
                                                        message:@"Al functions impaired, risk of choking"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
}

- (IBAction)selectedAlcohol:(id)sender {
    if (_alcoholSelector.selectedSegmentIndex == 0) {
        [_beerTable reloadData];
        
    }
    if (_alcoholSelector.selectedSegmentIndex == 1) {
        [_beerTable reloadData];
    }
}
- (IBAction)hideKeyboard:(id)sender {
    [_weightEntered resignFirstResponder];
    [_searchBar resignFirstResponder];
    [_beerTable resignFirstResponder];
    
}

//button to check the status of their BAC without consuming a beverage

- (IBAction)checkBAC:(id)sender {
    NSDate * now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss:SSS"];
    NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:self.pastDate];
    double secondsInAnHour = 3600;
    float hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    float previousBAC = [_bacLabel.text floatValue];
    float BAC2 = previousBAC - (0.013 * hoursBetweenDates);
    
    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", BAC2];
    
    float finalBAC = [calculatedBAC floatValue];
    
    
    //alert messages
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
    
    _bacLabel.text = calculatedBAC;
    self.pastDate = now;
}

//sets the BAC back to zero
- (IBAction)resetButton:(id)sender {
    NSDate * now = [NSDate date];
    _bacLabel.text = @"0.00";
    self.pastDate = now;
}
@end
