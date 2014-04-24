//
//  RatingsectionViewController.m
//  rubi
//
//  Created by David Krachler on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "RatingsectionViewController.h"
#import "RatingImagesViewController.h"
#import "CoreDataTableViewController.h"
#import "Ratingsection.h"
#import "PickerViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RatingsectionViewController () <PickerViewControllerDelegate,
                                            UIPopoverControllerDelegate,
                                            CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnA2;


@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;

@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latidude;

@property (nonatomic, strong) UIPopoverController *popController;

@end

@implementation RatingsectionViewController

-(void)selectedString:(NSString *)value
           forControl:(id)sourceControl
           fromSender:(PickerViewController *)sender{
    if ([sourceControl isKindOfClass: [UIButton class]]) {
        [sourceControl setTitle: value forState: UIControlStateNormal];
    }
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
    
    UIColor *streetBg = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"street.png"]];
    self.RatingSectionInterfaceView.backgroundColor = streetBg;
    
    NSLog(@"TYPE: %@", self.ratingsection);

    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)leftSideWalkIncrementStepper:(id)sender {
    NSString *leftSideWalkStepperValue = [NSString localizedStringWithFormat:@"%.2F", _leftSideWalkWidthStepper.value];
    
    
    _leftSideWalkWidthTextField.text = leftSideWalkStepperValue;
    
}
- (IBAction)leftBikePathIncrementStepper:(id)sender {
    NSString *rightSideWalkStepperValue = [NSString localizedStringWithFormat:@"%.2F", _leftBikePathWidthStepper.value];
    
    
    _leftBikePathWidthTextField.text = rightSideWalkStepperValue;
}

- (IBAction)leftStreetWidthIncrementStepper:(id)sender{
    NSString *streetStepperValue = [NSString localizedStringWithFormat:@"%.2F", _streetWidthStepper.value];
    
    
    _streetWidthTextField.text = streetStepperValue;
}

- (IBAction)rightBikePathIncrementStepper:(id)sender{
    NSString *rightBikePathStepperValue = [NSString localizedStringWithFormat:@"%.2F", _rightBikePathWidthStepper.value];
    
    
    _rightBikePathWidthTextField.text = rightBikePathStepperValue;
}

- (IBAction)rightSideWalkIncrementStepper:(id)sender{
    NSString *rightSideWalkStepperValue = [NSString localizedStringWithFormat:@"%.2F", _rightSideWalkWidthStepper.value];
    
    
    _rightSideWalkWidthTextField.text = rightSideWalkStepperValue;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

    if([segue.identifier isEqualToString:@"RatingImages"]){
        
        RatingImagesViewController *dvc = (RatingImagesViewController *)[[segue destinationViewController] topViewController];
        //RatingImagesViewController *dvc = [segue destinationViewController];
        
        dvc.ratingsection = self.ratingsection;
        dvc.managedObjectContext = self.managedObjectContext;
        
        
        //dvc.ratingsection.ratingimage = self.ratingsection.ratingimage;
        //NSLog(@"imgs: %@", dvc.ratingsection.ratingimage);
        
        dvc.ratingsection = self.ratingsection;
        dvc.ratingimage = self.ratingimage;
        dvc.ratingsection.ratingimage = self.ratingsection.ratingimage;
        
        
        
        
       // NSLog(@"Segue Section: %@", self.managedObjectContext);
        
    }
    else if( [segue.identifier isEqualToString:@"showPickerView"] ) {
        PickerViewController *controller = (PickerViewController *)segue.destinationViewController;
        controller.delegate = self;
        controller.sourceControl = sender;
    }
    
}

- (IBAction)newRatingSection:(UIBarButtonItem *)sender {
    
    
    Ratingsection* ratingsection = [NSEntityDescription insertNewObjectForEntityForName:@"Ratingsection" inManagedObjectContext:_managedObjectContext];
    
    // NSString* newRatingsectionStartPosition = [NSString stringWithFormat:@"Abschnitt"];
    
    
    NSString *newRatingsectionStartPosition = [NSString stringWithFormat:@"%@,%@", _longitude, _latidude];
    
    [ratingsection setValue:newRatingsectionStartPosition forKey:@"startPositionGPS"];
    
    
    [self.ratingsection.section addRatingSectionObject:(Ratingsection*)ratingsection];
    
    
    RatingsectionViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"RatingsectionViewController"];
    controller.project = self.project;
    controller.ratingsection = ratingsection;
    controller.managedObjectContext = self.managedObjectContext;
    
    UINavigationController *navigationController = self.navigationController;
    // Pop to root view controller (not animated) before pushing
    [navigationController popToRootViewControllerAnimated:NO];
    [navigationController pushViewController: controller animated:YES];
}
    


- (IBAction)dismissViewTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)leftBikePathPicker:(id)sender {
    
    [self presentPopOvercontroller: sender];
}

-(IBAction)presentPopOvercontroller:(id)sender {
    PickerViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"PickerViewController"];
    
    controller.delegate = self;
    controller.sourceControl = (UIButton *)sender;
    
    self.popController = [[UIPopoverController alloc]
                          initWithContentViewController: controller];
    self.popController.delegate = self;
    //Get the cell from your table that presents the popover
    
    [self.popController presentPopoverFromRect: ((UIButton *)sender).bounds
                                        inView: ((UIButton *)sender)
                      permittedArrowDirections: UIPopoverArrowDirectionLeft animated:YES];
    
}

#pragma LocationManager Methoden

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latidude  = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        //  NSLog(@"Position %@ %@", _longitude, _latidude);
    }
    
    [self.locationManager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
    [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            NSString *adress = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                placemark.subThoroughfare, placemark.thoroughfare,
                                placemark.postalCode, placemark.locality,
                                placemark.administrativeArea,
                                placemark.country];
            NSLog(@"Adress: %@", adress);
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}


@end
