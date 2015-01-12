//
//  STAdvancedBACViewController.h
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/14/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STAppDelegate.h"
#import "STProfile.h"
#import "STProfileViewController.h"

@interface STAdvancedBACViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>{
    UIViewController *appDelegate;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSString *alcoholContent;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)checkBAC:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *poundOrKilogram;
@property (strong, nonatomic) IBOutlet UISegmentedControl *beerSize;
@property (strong, nonatomic) IBOutlet UISegmentedControl *maleOrFemale;
@property (strong, nonatomic) IBOutlet UITextField *weightEntered;
@property (strong, nonatomic) IBOutlet UITableView *wineTable;
@property (strong, nonatomic) IBOutlet UITableView *beerTable;
@property (strong, nonatomic) IBOutlet UISegmentedControl *alcoholSelector;
- (IBAction)resetButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *bacLabel;
- (IBAction)drinkPressed:(id)sender;
- (IBAction)selectedAlcohol:(id)sender;
@property (strong, nonatomic) NSString *weightLabel;

@property float drinkSize;
@property float metric;
@property float rateOfElimination;
@property float WaterConst;
@property float BAC;
@property float AGE;
@property (strong, nonatomic) NSString* WEIGHT;
@property float MALE;

@end

