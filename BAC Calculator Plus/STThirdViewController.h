//
//  STThirdViewController.h
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/5/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface STThirdViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *searchText;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *matchingItems;
- (IBAction)mapButtonPressed:(id)sender;
- (IBAction)foodButton:(id)sender;
- (IBAction)barButton:(id)sender;


@property (weak, nonatomic) IBOutlet MKMapView *mapViewFood;

@property (weak, nonatomic) IBOutlet MKMapView *mapViewBar;
@property (strong, nonatomic) IBOutlet UILabel *currentLocationLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberFIeld;
@property (weak, nonatomic) IBOutlet UIButton *barButton;
- (IBAction)currentLocationButton:(id)sender;


@end
