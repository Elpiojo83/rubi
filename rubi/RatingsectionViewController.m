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

@interface RatingsectionViewController ()

@end

@implementation RatingsectionViewController


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
        
        
        RatingImagesViewController *dvc = [segue destinationViewController];
        dvc.managedObjectContext = self.managedObjectContext;
        
        //dvc.ratingsection.ratingimage = self.ratingsection.ratingimage;
        //NSLog(@"imgs: %@", dvc.ratingsection.ratingimage);
        
        dvc.ratingsection = self.ratingsection;
        dvc.ratingimage = self.ratingimage;
        dvc.ratingsection.ratingimage = self.ratingsection.ratingimage;
        
       // NSLog(@"Segue Section: %@", self.managedObjectContext);
        
    }
    
    
}




@end
