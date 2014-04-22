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

@property (nonatomic, strong) NSString* constructiontype;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UIView *RatingSectionInterfaceView;



@property (strong, nonatomic) IBOutlet UITextField *leftSideWalkWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *leftSideWalkWidthStepper;
- (IBAction)leftSideWalkIncrementStepper:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *leftBikePathWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *leftBikePathWidthStepper;
- (IBAction)leftBikePathIncrementStepper:(id)sender;



@property (strong, nonatomic) IBOutlet UITextField *streetWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *streetWidthStepper;
- (IBAction)leftStreetWidthIncrementStepper:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *rightBikePathWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *rightBikePathWidthStepper;
- (IBAction)rightBikePathIncrementStepper:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *rightSideWalkWidthTextField;
@property (strong, nonatomic) IBOutlet UIStepper *rightSideWalkWidthStepper;
- (IBAction)rightSideWalkIncrementStepper:(id)sender;

@end
