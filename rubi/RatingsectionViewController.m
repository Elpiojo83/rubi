//
//  RatingsectionViewController.m
//  rubi
//
//  Created by David Krachler on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "RatingsectionViewController.h"
<<<<<<< HEAD
#import "RatingSectionsTableViewController.h"
#import "Street.h"
#import "Project.h"
#import "Section.h"
=======
#import "RatingImagesViewController.h"
#import "CoreDataTableViewController.h"
>>>>>>> FETCH_HEAD
#import "Ratingsection.h"

@interface RatingsectionViewController ()

@end

@implementation RatingsectionViewController

/*
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Ratingsection"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"startPositionGPS" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" ratingsection == %@" , self.ratingsection];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}
*/

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
    
    NSLog(@"RatingSection: %@", self.section);
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        
        //NewSectionFormView *dvc = [segue destinationViewController];
        //dvc.street = self.street;
        
        RatingImagesViewController *dvc = [segue destinationViewController];
        //dvc. = self.ratingimage;
       // dvc.ratingsection = self.ratingsection;
        dvc.managedObjectContext = self.managedObjectContext;
       // dvc.section = self.section;
        
        NSLog(@"Segue Section: %@", self.managedObjectContext);
        
    }
    
    
}


#pragma mark ImagPicker

/*
- (void) navigationController: (UINavigationController *) navigationController  willShowViewController: (UIViewController *) viewController animated: (BOOL) animated {
    if (imagePickerController.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showCamera:)];
        viewController.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:button];
    } else {
        UIBarButtonItem* button = [[UIBarButtonItem alloc] initWithTitle:@"Library" style:UIBarButtonItemStylePlain target:self action:@selector(showLibrary:)];
        viewController.navigationItem.leftBarButtonItems = [NSArray arrayWithObject:button];
        viewController.navigationItem.title = @"Take Photo";
        viewController.navigationController.navigationBarHidden = NO; // important
    }
}

- (void) showCamera: (id) sender {
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
}

- (void) showLibrary: (id) sender {
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}
*/



@end
