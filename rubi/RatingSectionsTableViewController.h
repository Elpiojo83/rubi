//
//  RatingSectionsTableViewController.h
//  rubi
//
//  Created by David Krachler on 17.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RatingSectionsTableViewController : CoreDataTableViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) Section *section;
@property (nonatomic, strong) Street* street;
@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Ratingsection *ratingsection;

@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latidude;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
