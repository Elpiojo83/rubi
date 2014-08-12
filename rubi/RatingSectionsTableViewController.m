//
//  RatingSectionsTableViewController.m
//  rubi
//
//  Created by David Krachler on 17.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//


#import "RatingSectionsTableViewController.h"
#import "ProjectStreetsTableTableViewController.h"
#import "Street.h"
#import "Project.h"
#import "Section.h"
#import "ProjectViewController.h"
#import "NewSectionFormView.h"
#import "Ratingsection.h"
#import "RatingImagesViewController.h"
#import "RatingImage.h"
#import "RatingsectionViewController.h"


@interface RatingSectionsTableViewController ()

@end

@implementation RatingSectionsTableViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}



- (IBAction)AddRatingsectionTouchUpInside:(id)sender {
    
    

    NSLog(@"Current Section: %@", _section);
    
    //AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    //NSManagedObjectContext* manageObjectContext = appDelegate.managedObjectContext;
    
    NSManagedObject* ratingsection = [NSEntityDescription insertNewObjectForEntityForName:@"Ratingsection" inManagedObjectContext:_managedObjectContext];
    
   // NSString* newRatingsectionStartPosition = [NSString stringWithFormat:@"Abschnitt"];
    
    
    NSString *newRatingsectionStartPosition = [NSString stringWithFormat:@"%@,%@", _latidude, _longitude];
    NSDate * newDate = [NSDate date];
    
    time_t unixTime = (time_t) [newDate timeIntervalSince1970];
    NSString *unixTS = [NSString stringWithFormat:@" %ld", unixTime];
    [ratingsection setValue:unixTS forKey:@"timestamp"];
    
    [ratingsection setValue:newRatingsectionStartPosition forKey:@"startPositionGPS"];
    
    [ratingsection setValue:uniqueDeviceID forKey:@"deviceID"];
    
    [self.section addRatingSectionObject:(Ratingsection*)ratingsection];
    
    
    
    [self.tableView reloadData];
    
    
    
   // NSLog(@"New Section: %@", newRatingsectionStartPosition);
    
    
   // NSLog(@"Add Rating Section");
    
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
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latidude  = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
      //  NSLog(@"Position %@ %@", _longitude, _latidude);
    }
    
    [locationManager stopUpdatingLocation];
    
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
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

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Ratingsection"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"timestamp" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" section == %@" , self.section];
        
        
        NSLog(@"Curr. Section: %@", _section);
        
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"RatingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Ratingsection *ratingsection = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
   // cell.textLabel.text = [NSString stringWithFormat:@"Abschnitt%@",  ratingsection.startPositionGPS];
    
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"Teilbewertung %i",  indexPath.row+1];
    
    NSLog(@"RATINGSECTION: %@", ratingsection);
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Ratingsection *deleteRatingsection = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject: deleteRatingsection];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    

    if([segue.identifier isEqualToString:@"addSection"]){
        
        NewSectionFormView *dvc = [segue destinationViewController];
        dvc.street = self.street;
        
    }
    
    if([segue.identifier isEqualToString:@"toRatingSections"]){
        
        Ratingsection *ratingSection = [[self.fetchedResultsController fetchedObjects] objectAtIndex: self.tableView.indexPathForSelectedRow.row];
        NSLog(@"the section %@",ratingSection );
        
        

        RatingsectionViewController *dvc = (RatingsectionViewController *)[[segue destinationViewController] topViewController];
        dvc.managedObjectContext = self.managedObjectContext;
        
        dvc.ratingsection = ratingSection;
        
        dvc.title = [NSString stringWithFormat:@"Teilbewertung %i", self.tableView.indexPathForSelectedRow.row+1];
        
        NSLog(@"SegueToSectio %@", dvc.title);
        
    }

 
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    //NSLog(@"SKTION; %@", [cell.count]);
    
    /*
    
    if(){
        NSLog(@"Current Section: %@", _section);
        
        //AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        //NSManagedObjectContext* manageObjectContext = appDelegate.managedObjectContext;
        
        NSManagedObject* ratingsection = [NSEntityDescription insertNewObjectForEntityForName:@"Ratingsection" inManagedObjectContext:_managedObjectContext];
        
        // NSString* newRatingsectionStartPosition = [NSString stringWithFormat:@"Abschnitt"];
        
        
        NSString *newRatingsectionStartPosition = [NSString stringWithFormat:@"%@,%@", _latidude, _longitude];
        
        [ratingsection setValue:newRatingsectionStartPosition forKey:@"startPositionGPS"];
        
        
        [self.section addRatingSectionObject:(Ratingsection*)ratingsection];
        
        [self.tableView reloadData];
    }
    */
    
}




-(void)viewDidAppear:(BOOL)animated{
    
    
   NSLog(@"Current Section: %@", _section);

}



@end
