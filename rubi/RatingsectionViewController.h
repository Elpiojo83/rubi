//
//  RatingsectionViewController.h
//  rubi
//
//  Created by David Krachler on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingsectionViewController : UIViewController

@property (nonatomic, strong) Section *section;
@property (nonatomic, strong) Street* street;
@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Ratingsection* ratingsection;
@property (nonatomic, strong) RatingImage* ratingimage;
@property (nonatomic, strong) RatingsectionSafetyHazard* ratingsectionsafetyhazard;

@property (nonatomic, strong) NSString* constructiontype;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction)leftBikePathPicker:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *RatingSectionInterfaceView;

- (IBAction)dismissViewTouchUpInside:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *leftSideWalkWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *leftSideWalkWidthStepper;
- (IBAction)leftSideWalkIncrementStepper:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *leftBikePathWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *leftBikePathWidthStepper;
- (IBAction)leftBikePathIncrementStepper:(id)sender;



@property (strong, nonatomic) IBOutlet UITextField *streetWidthTextField;



@property (strong, nonatomic) IBOutlet UITextField *rightBikePathWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *rightBikePathWidthStepper;
- (IBAction)rightBikePathIncrementStepper:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *rightSideWalkWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *rightSideWalkWidthStepper;
- (IBAction)rightSideWalkIncrementStepper:(id)sender;


//Condition TextFields

@property (strong, nonatomic) IBOutlet UITextField *rightSideWalkConditionTextField;

@property (strong, nonatomic) IBOutlet UITextField *rightBikePathConditionTextField;



@property (strong, nonatomic) IBOutlet UITextField *rightEdgeConditionTextField;
- (IBAction)rightEdgeSteper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UIrightEdgeStepper;

@property (strong, nonatomic) IBOutlet UITextField *rightDrainageConditionTextField;
- (IBAction)rightDrainageStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UIrightDrainageStepper;

@property (strong, nonatomic) IBOutlet UITextField *streetFlatnessConditionTextField;
- (IBAction)streetFlatnessStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UIstreetFlatness;


@property (strong, nonatomic) IBOutlet UITextField *streetSurfaceConditionTextField;
- (IBAction)streetSurfaceStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UIstreetSurface;


@property (strong, nonatomic) IBOutlet UITextField *streetCkracksConditionTextField;
- (IBAction)streetCracksStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UIstreetCracks;


@property (strong, nonatomic) IBOutlet UITextField *leftSideWalkConditionTextField;



@property (strong, nonatomic) IBOutlet UITextField *leftDrainageConditionTextField;
- (IBAction)leftDrainageStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UILeftDrainage;

@property (strong, nonatomic) IBOutlet UITextField *leftBikePathConditionTextField;


@property (strong, nonatomic) IBOutlet UITextField *leftEdgeConditionTextField;
- (IBAction)leftEdgeStepper:(id)sender;
@property (strong, nonatomic) IBOutlet UIStepper *UIleftEdge;

// Buttons for Width

@property (strong, nonatomic) IBOutlet UIButton *streetWidth;
@property (strong, nonatomic) IBOutlet UIButton *leftSideWalkWidth;
@property (strong, nonatomic) IBOutlet UIButton *leftBikePathWidth;
@property (strong, nonatomic) IBOutlet UIButton *rightBikePathWidth;
@property (strong, nonatomic) IBOutlet UIButton *rightSideWalkWidth;

@property (strong, nonatomic) IBOutlet UIButton *streetWidthEnd;
@property (strong, nonatomic) IBOutlet UIButton *leftSideWalkWidthEnd;
@property (strong, nonatomic) IBOutlet UIButton *leftBikePathWidthEnd;
@property (strong, nonatomic) IBOutlet UIButton *rightBikePathWidthEnd;
@property (strong, nonatomic) IBOutlet UIButton *rightSideWalkWidthEnd;



@property (strong, nonatomic) IBOutlet UIButton *endPosition;
@property (strong, nonatomic) IBOutlet UIButton *startPosition;


@property (strong, nonatomic) IBOutlet UIButton *leftSideWalkConstructionType;
@property (strong, nonatomic) IBOutlet UIButton *leftBikePathConstructionType;
@property (strong, nonatomic) IBOutlet UIButton *leftEdgeConstructionType;
@property (strong, nonatomic) IBOutlet UIButton *leftDrainageConstructionType;

@property (strong, nonatomic) IBOutlet UIButton *streetConstructionType;

@property (strong, nonatomic) IBOutlet UIButton *rightSideWalkConstructionType;
@property (strong, nonatomic) IBOutlet UIButton *rightBikePathConstructionType;
@property (strong, nonatomic) IBOutlet UIButton *rightEdgeConstructionType;
@property (strong, nonatomic) IBOutlet UIButton *rightDrainageConstructionType;


@end
