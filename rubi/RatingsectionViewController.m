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

@interface RatingsectionViewController () <PickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnA;

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




- (IBAction)dismissViewTouchUpInside:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
