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
    //    STAppDelegate *appDel;
    
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
    // Do any additional setup after loading the view.
    
    appDelegate = [[UIApplication sharedApplication]delegate];
    
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
    
    filteredNames = [[NSMutableArray alloc]init];
    
    
    searchController = [[UISearchDisplayController alloc]init];
    
    searchController.searchResultsDataSource = self;
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"CHECK" ofType:@"plist"];
    
    NSString *winePath2 = [[NSBundle mainBundle] pathForResource:@"Liquor" ofType:@"plist"];
    
    beerValues = [NSDictionary dictionaryWithContentsOfFile:path2];
    
    WineValues = [NSDictionary dictionaryWithContentsOfFile:winePath2];
    
    beerKeys = [[beerValues allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    
    tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"MetalTable2.png"]];
    
    [tableView setSectionIndexColor:[UIColor blueColor]];
    [tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    
    //    appDel = (STAppDelegate *) [[UIApplication sharedApplication] delegate];
    [_beerTable reloadData];
    [_wineTable reloadData];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //    STProfile *profile = [appDel.profiles objectAtIndex:0];
    //    _weightLabel = profile.weight;
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
    else{
        
        
        cell.textLabel.text = filteredNames[indexPath.row];
        //            tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"MetalTable2.png"]];
        //        tableView.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
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

- (IBAction)drinkPressed:(id)sender {
    NSLog(@"%lu", (unsigned long)filteredNames.count);
    NSDate * now = [NSDate date];
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"hh:mm:ss:SSS"];
    //
    //    NSString *currentTime = [formatter stringFromDate:now];
    //    Put time differential to chanfe Bac time
    
    NSTimeInterval distanceBetweenDates = [now timeIntervalSinceDate:self.pastDate];
    double secondsInAnHour = 3600;
    float hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    
    
    float previousBAC = [_bacLabel.text floatValue];
    
    float Weight = [_weightEntered.text floatValue];
    float alcContent = [_alcoholContent floatValue];
    if (_maleOrFemale.selectedSegmentIndex == 0) {
        
        if (_poundOrKilogram.selectedSegmentIndex == 0) {
            if (hoursBetweenDates > 0) {
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.58 * (Weight/2.2))) - (0.013 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.58 * (Weight/2.2))) - (0.013 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.58 * (Weight/2.2))) - (0.013 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                
            }
            else{
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.58 * (Weight/2.2))) - (0.013 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.58 * (Weight/2.2))) - (0.013 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.58 * (Weight/2.2))) - (0.013 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
            }
        }
        if (_poundOrKilogram.selectedSegmentIndex == 1){
            if (hoursBetweenDates > 0) {
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.58 * (Weight))) - (0.013 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.58 * (Weight))) - (0.013 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.58 * (Weight))) - (0.013 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                
            }
            else{
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.58 * (Weight))) - (0.013 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.58 * (Weight))) - (0.013 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.58 * (Weight))) - (0.013 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
            }
        }
        float previousBAC = [_bacLabel.text floatValue];
    }
    if (_maleOrFemale.selectedSegmentIndex == 1) {
        if (_poundOrKilogram.selectedSegmentIndex == 0) {
            if (hoursBetweenDates > 0) {
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.49 * (Weight/2.2))) - (0.014 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.49 * (Weight/2.2))) - (0.014 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.49 * (Weight/2.2))) - (0.014 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                
            }
            else{
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.49 * (Weight/2.2))) - (0.014 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.49 * (Weight/2.2))) - (0.014 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.49 * (Weight/2.2))) - (0.014 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
            }
        }
        if (_poundOrKilogram.selectedSegmentIndex == 1){
            if (hoursBetweenDates > 0) {
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.49 * (Weight))) - (0.014 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.49 * (Weight))) - (0.014 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.49 * (Weight))) - (0.014 * hoursBetweenDates);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                
            }
            else{
                if (_beerSize.selectedSegmentIndex == 0) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 12) * 1.2)/(0.49 * (Weight))) - (0.014 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                    
                }
                if (_beerSize.selectedSegmentIndex == 1) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 20) * 1.2)/(0.49 * (Weight))) - (0.014 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
                if (_beerSize.selectedSegmentIndex == 2) {
                    
                    float BAC = ((.806 * (1.6667 *(.01)* alcContent* 40) * 1.2)/(0.49 * (Weight))) - (0.014 * 0);
                    float maleBAC = previousBAC + BAC;
                    NSString *calculatedBAC = [[NSString alloc] initWithFormat: @"%.3f", maleBAC];
                    _bacLabel.text = calculatedBAC;
                    self.pastDate = now;
                }
            }
        }
    }
 
    float finalBAC = [_bacLabel.text floatValue];
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
- (IBAction)resetButton:(id)sender {
    _bacLabel.text = @"0.00";
}
@end
