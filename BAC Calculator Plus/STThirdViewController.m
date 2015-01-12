//
//  STThirdViewController.m
//  BAC Calculator Plus
//
//  Created by Samuel Turner on 4/5/14.
//  Copyright (c) 2014 Samuel Turner. All rights reserved.
//

#import "STThirdViewController.h"
#import <MapKit/MapKit.h>

@interface STThirdViewController()

@property NSString *phoneNumber;

@end

@implementation STThirdViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
}


@synthesize phoneNumber;

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
	// enable location manager and add any view to this viewcontroller
    
   
    [self.mapView setDelegate:self];
    [self.mapViewFood setDelegate:self];
    [self.mapViewBar setDelegate:self];
    _mapView.showsUserLocation=YES;
    _mapViewFood.showsUserLocation=YES;
    _mapViewBar.showsUserLocation=YES;
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
    }


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    
    //size of map view
    
    double miles = 12.0;
    double scalingFactor =
    ABS( cos(2 * M_PI * newLocation.coordinate.latitude /360.0) );
    
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/( scalingFactor*69.0 );
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = newLocation.coordinate;
    
    [self.mapView setRegion:region animated:YES];
    self.mapView.showsUserLocation = YES;
    
    
// The text that appears to indicate current location

    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            _currentLocationLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@ %@ %@",
                                 placemark.subThoroughfare, placemark.thoroughfare,
                                  placemark.locality,
                                 placemark.administrativeArea, placemark.postalCode,
                                 placemark.country
                                          ];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    
    [mapView setRegion:mapRegion animated: YES];
}

//taxi button
- (IBAction)mapButtonPressed:(id)sender {
    
    //hide other views
   [_mapView setHidden:NO];
   [_mapViewFood setHidden:YES];
   [_mapViewBar setHidden:YES];
    
    //other details about taxi button
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    //search query
    request.naturalLanguageQuery = @"Taxi";
    request.region = _mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    _matchingItems = [[NSMutableArray alloc] init];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) NSLog(@"No Matches");
        else for (MKMapItem *result in response.mapItems) { [_matchingItems addObject:result];
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];annotation.coordinate = result.placemark.coordinate;
            annotation.title = result.name;
            annotation.subtitle = result.phoneNumber;

            NSString *PhoneNumber = annotation.subtitle;
            _phoneNumberFIeld.text = PhoneNumber;
            [_mapView addAnnotation:annotation];
            phoneNumber = PhoneNumber;
        } }];
    
    
}

- (IBAction)foodButton:(id)sender {

   //hide other views
    
    [_mapView setHidden:YES];
    [_mapViewFood setHidden:NO];
    [_mapViewBar setHidden:YES];
    MKCoordinateSpan span;
   span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    //search query
   request.naturalLanguageQuery = @"Fast Food";
    request.region = _mapViewFood.region;
   MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    _matchingItems = [[NSMutableArray alloc] init];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) NSLog(@"No Matches");
        else for (MKMapItem *result in response.mapItems) { [_matchingItems addObject:result];
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];annotation.coordinate = result.placemark.coordinate;
            annotation.title = result.name;
            annotation.subtitle = result.phoneNumber;
           [_mapViewFood addAnnotation:annotation]; } }];

}

- (IBAction)barButton:(id)sender {
    
   //hide other views
    [_mapView setHidden:YES];
    [_mapViewFood setHidden:YES];
    [_mapViewBar setHidden:NO];
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    //search query
    request.naturalLanguageQuery = @"Bar";
    request.region = _mapViewBar.region;
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    _matchingItems = [[NSMutableArray alloc] init];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) NSLog(@"No Matches");
        else for (MKMapItem *result in response.mapItems) { [_matchingItems addObject:result];
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];annotation.coordinate = result.placemark.coordinate;
            annotation.title = result.name;
            annotation.subtitle = result.phoneNumber;
            [_mapViewBar addAnnotation:annotation]; } }];
   
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if(annotation == mapView.userLocation){
        return nil;
    }
    
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"current"];
    
    //pin details
    pin.pinColor = MKPinAnnotationColorRed;
    pin.backgroundColor = [UIColor clearColor];
    pin.draggable = NO;
    pin.highlighted = YES;
    pin.animatesDrop = TRUE;
    pin.canShowCallout = YES;
    
    //selects which image to pair with phone number
    
    if (mapView == _mapView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Taxi.png"]];
        pin.leftCalloutAccessoryView = imageView;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
    if (mapView == _mapViewBar) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bar Icon.png"]];
        pin.leftCalloutAccessoryView = imageView;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
    
    
    else {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FastFood.png"]];
        pin.leftCalloutAccessoryView = imageView;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return pin;
    }
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
    calloutAccessoryControlTapped:(UIControl *)control
    {
    //
    NSString *call = view.annotation.subtitle;
    NSString *CallNumber = [NSString stringWithFormat: @"telprompt://%@", call];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:CallNumber]];


}



- (IBAction)currentLocationButton:(id)sender {
        [_mapViewBar setCenterCoordinate: _mapViewFood.userLocation.coordinate animated:YES];
        [_mapViewFood setCenterCoordinate: _mapViewFood.userLocation.coordinate animated:YES];
        [_mapView setCenterCoordinate: _mapViewFood.userLocation.coordinate animated:YES];
    
}
@end
