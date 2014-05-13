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
#import "WidthPickerViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "RatingSectionNotesViewController.h"
#import "SiGeViewController.h"
#import "RatingsectionSafetyHazard.h"

@interface RatingsectionViewController () <PickerViewControllerDelegate,
                                            UIPopoverControllerDelegate,
                                            CLLocationManagerDelegate, WidthPickerViewControllerDelegate>

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
    
    [self showAllButtonTitles];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)leftSideWalkIncrementStepper:(id)sender {
    NSString *leftSideWalkStepperValue = [NSString localizedStringWithFormat:@"%.F", _leftSideWalkWidthStepper.value];
    
    
    _leftSideWalkConditionTextField.text = leftSideWalkStepperValue;
    
    self.ratingsection.leftSidewalkCondition = leftSideWalkStepperValue;
    
}
- (IBAction)leftBikePathIncrementStepper:(id)sender {
    NSString *leftBikeCondition = [NSString localizedStringWithFormat:@"%.F", _leftBikePathWidthStepper.value];
    
    
    _leftBikePathConditionTextField.text = leftBikeCondition;
    
    self.ratingsection.leftBikepathCondition = leftBikeCondition;
}



- (IBAction)rightBikePathIncrementStepper:(id)sender{
    NSString *rightBikePathStepperValue = [NSString localizedStringWithFormat:@"%.F", _rightBikePathWidthStepper.value];

   _rightBikePathConditionTextField.text = rightBikePathStepperValue;
    self.ratingsection.rightBikepathCondition = rightBikePathStepperValue;
    }

- (IBAction)rightSideWalkIncrementStepper:(id)sender{
    NSString *rightSideWalkStepperValue = [NSString localizedStringWithFormat:@"%.F", _rightSideWalkWidthStepper.value];
    
    
    _rightSideWalkConditionTextField.text = rightSideWalkStepperValue;
    self.ratingsection.rightSidewalkCondition = rightSideWalkStepperValue;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

    if([segue.identifier isEqualToString:@"RatingImages"]){
        
        RatingImagesViewController *dvc = (RatingImagesViewController *)[[segue destinationViewController] topViewController];
        
        dvc.ratingsection = self.ratingsection;
        dvc.managedObjectContext = self.managedObjectContext;
        
        
        dvc.ratingsection = self.ratingsection;
        dvc.ratingimage = self.ratingimage;
        dvc.ratingsection.ratingimage = self.ratingsection.ratingimage;
        
        
    }
    else if( [segue.identifier isEqualToString:@"showPickerView"] ) {
        PickerViewController *controller = (PickerViewController *)segue.destinationViewController;
        controller.delegate = self;
        controller.sourceControl = sender;
    }
    else if( [segue.identifier isEqualToString:@"showWidthPickerView"] ) {
        WidthPickerViewController *controller = (WidthPickerViewController *)segue.destinationViewController;
        controller.delegate = self;
        controller.sourceControl = sender;
    }
    else if ( [segue.identifier isEqualToString: @"RatingNotes"]) {
        
        RatingSectionNotesViewController *dvc = [segue destinationViewController];
        dvc.project = self.project;
        dvc.ratingsection = self.ratingsection;
        dvc.managedObjectContext = self.managedObjectContext;
        
    }
    else if ( [segue.identifier isEqualToString: @"SiGe"]) {
        
        SiGeViewController *dvc = [segue destinationViewController];
        dvc.project = self.project;
        dvc.ratingsection = self.ratingsection;
        dvc.ratingSectionSafetyHazard = self.ratingSectionSafetyHazard;
        
        dvc.managedObjectContext = self.managedObjectContext;
        
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
    
    
    [self saveAllButtonTitleValues];
    
}
    


- (IBAction)dismissViewTouchUpInside:(id)sender {
    
    

    
    //ConstructionTypes
    
    [self saveAllButtonTitleValues];
    
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


-(IBAction)presentWidthPopOvercontroller:(id)sender {
    WidthPickerViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"WidthPicker"];
    
    controller.delegate = self;
    controller.sourceControl = (UIButton *)sender;
    
    self.popController = [[UIPopoverController alloc]
                          initWithContentViewController: controller];
    self.popController.delegate = self;
    //Get the cell from your table that presents the popover
    
    NSString *endButton = [NSString stringWithFormat:@"%ld", (long)[sender tag]];
    
    if([endButton isEqualToString:@"1902"]){
        [self.popController presentPopoverFromRect: ((UIButton *)sender).bounds
                                            inView: ((UIButton *)sender)
                          permittedArrowDirections: UIPopoverArrowDirectionRight animated:YES];
          NSLog(@"Button pressed: %ld", [sender tag]);
    }else{
        [self.popController presentPopoverFromRect: ((UIButton *)sender).bounds
                                            inView: ((UIButton *)sender)
                          permittedArrowDirections: UIPopoverArrowDirectionLeft animated:YES];
    }

}

-(IBAction)presentEndWidthPopOvercontroller:(id)sender {
    WidthPickerViewController* controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"WidthPicker"];
    
    controller.delegate = self;
    controller.sourceControl = (UIButton *)sender;
    
    self.popController = [[UIPopoverController alloc]
                          initWithContentViewController: controller];
    self.popController.delegate = self;
    //Get the cell from your table that presents the popover
    
    
        [self.popController presentPopoverFromRect: ((UIButton *)sender).bounds
                                            inView: ((UIButton *)sender)
                          permittedArrowDirections: UIPopoverArrowDirectionRight animated:YES];
        NSLog(@"Button pressed: %ld", [sender tag]);

    
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


- (IBAction)rightEdgeSteper:(id)sender {
    NSString *rightEdgeStepperValue = [NSString localizedStringWithFormat:@"%.F", _UIrightEdgeStepper.value];
    _rightEdgeConditionTextField.text = rightEdgeStepperValue;
    
    self.ratingsection.rightEdgeCondition = rightEdgeStepperValue;
    
}
- (IBAction)rightDrainageStepper:(id)sender {
    NSString *rightDrainage = [NSString localizedStringWithFormat:@"%.F", _UIrightDrainageStepper.value];
    _rightDrainageConditionTextField.text = rightDrainage;
    
    self.ratingsection.rightDrainageCondition = rightDrainage;
}
- (IBAction)streetSurfaceStepper:(id)sender {
    NSString *streetSurface = [NSString localizedStringWithFormat:@"%.F", _UIstreetSurface.value];
    _streetSurfaceConditionTextField.text = streetSurface;
    
    self.ratingsection.streetSurfaceDamage = streetSurface;
    
}
- (IBAction)streetFlatnessStepper:(id)sender {
    NSString *streetFlatness = [NSString localizedStringWithFormat:@"%.F", _UIstreetFlatness.value];
    _streetFlatnessConditionTextField.text = streetFlatness;
    
    self.ratingsection.streetFlatness = streetFlatness;
    
}
- (IBAction)streetCracksStepper:(id)sender {
    NSString *streetCracks = [NSString localizedStringWithFormat:@"%.F", _UIstreetCracks.value];
    _streetCkracksConditionTextField.text = streetCracks;
    
    self.ratingsection.streetCracks = streetCracks;
}
- (IBAction)leftDrainageStepper:(id)sender {
    NSString *leftDrainage = [NSString localizedStringWithFormat:@"%.F", _UILeftDrainage.value];
    _leftDrainageConditionTextField.text = leftDrainage;

    self.ratingsection.leftDrainageCondition = leftDrainage;
}

- (IBAction)leftEdgeStepper:(id)sender {
    NSString *leftEdge = [NSString localizedStringWithFormat:@"%.F", _UIleftEdge.value];
    _leftEdgeConditionTextField.text = leftEdge;
    
    self.ratingsection.leftEdgeCondition = leftEdge;
    
}

-(void)saveAllButtonTitleValues{
    
    //Method
    
    self.ratingsection.leftSidewalkMethodOfConstruction = [self.leftSideWalkConstructionType currentTitle];
    self.ratingsection.leftBikepathMethodOfConstruction = [self.leftBikePathConstructionType currentTitle];
    self.ratingsection.leftEdgeMethodOfConstruction = [self.leftEdgeConstructionType currentTitle];
    self.ratingsection.leftDrainageMethodOfCondition = [self.leftDrainageConstructionType currentTitle];
    
    self.ratingsection.streetMethodOfConstruction = [self.streetConstructionType currentTitle];
    
    self.ratingsection.rightSidewalkMethodOfConstruction = [self.rightSideWalkConstructionType currentTitle];
    self.ratingsection.rightBikepathMethodOfConstruction = [self.rightBikePathConstructionType currentTitle];
    self.ratingsection.rightEdgeMethodOfConstruction = [self.rightEdgeConstructionType currentTitle];
    self.ratingsection.rightDrainageMethodOfConstruction = [self.rightDrainageConstructionType currentTitle];
    
    
    //Width
    
    self.ratingsection.leftSidewalkWidth = [self.leftSideWalkWidth currentTitle];
    self.ratingsection.leftBikepathWidth = [self.leftBikePathWidth currentTitle];
    
    self.ratingsection.streetWidth = [self.streetWidth currentTitle];
    
    self.ratingsection.rightSidewalkWidth = [self.rightSideWalkWidth currentTitle];
    self.ratingsection.righBikepathWidth = [self.rightBikePathWidth currentTitle];
    
    //Position
    
    self.ratingsection.startPosition = [self.startPosition currentTitle];
    self.ratingsection.endPosition = [self.endPosition currentTitle];
    
}


-(void)showAllButtonTitles{
    [self.leftSideWalkConstructionType setTitle:self.ratingsection.leftSidewalkMethodOfConstruction forState:normal];
    [self.leftBikePathConstructionType setTitle:self.ratingsection.leftBikepathMethodOfConstruction forState:normal];
    [self.leftEdgeConstructionType setTitle:self.ratingsection.leftEdgeMethodOfConstruction forState:normal];
    [self.leftDrainageConstructionType setTitle:self.ratingsection.leftDrainageMethodOfCondition forState:normal];
    
    [self.streetConstructionType setTitle:self.ratingsection.streetMethodOfConstruction forState:normal];
    
    [self.rightSideWalkConstructionType setTitle:self.ratingsection.rightSidewalkMethodOfConstruction forState:normal];
    [self.rightBikePathConstructionType setTitle:self.ratingsection.rightBikepathMethodOfConstruction forState:normal];
    [self.rightEdgeConstructionType setTitle:self.ratingsection.rightEdgeMethodOfConstruction forState:normal];
    [self.rightDrainageConstructionType setTitle:self.ratingsection.rightDrainageMethodOfConstruction forState:normal];
    
    //Fill in the Stepper Textfields
    
    _rightSideWalkConditionTextField.text = self.ratingsection.rightSidewalkCondition;
    _rightBikePathConditionTextField.text = self.ratingsection.rightBikepathCondition;
    _rightEdgeConditionTextField.text = self.ratingsection.rightEdgeCondition;
    _rightDrainageConditionTextField.text = self.ratingsection.rightDrainageCondition;
    
    _streetFlatnessConditionTextField.text = self.ratingsection.streetFlatness;
    _streetSurfaceConditionTextField.text = self.ratingsection.streetSurfaceDamage;
    _streetCkracksConditionTextField.text = self.ratingsection.streetCracks;
    
    _leftDrainageConditionTextField.text = self.ratingsection.leftDrainageCondition;
    _leftEdgeConditionTextField.text = self.ratingsection.rightDrainageCondition;
    _leftBikePathConditionTextField.text = self.ratingsection.leftBikepathCondition;
    _leftSideWalkConditionTextField.text = self.ratingsection.leftSidewalkCondition;
    
    //Fill Buttons with Width
    [self.streetWidth setTitle:self.ratingsection.streetWidth forState:normal];
    
    [self.rightSideWalkWidth setTitle:self.ratingsection.rightSidewalkWidth forState:normal];
    [self.rightBikePathWidth setTitle:self.ratingsection.righBikepathWidth forState:normal];
    
    [self.leftSideWalkWidth setTitle:self.ratingsection.leftSidewalkWidth forState:normal];
    [self.leftBikePathWidth setTitle:self.ratingsection.leftBikepathWidth forState:normal];
    
    [self.startPosition setTitle:self.ratingsection.startPosition forState:normal];
    [self.endPosition setTitle:self.ratingsection.endPosition forState:normal];
    
    
}

@end
