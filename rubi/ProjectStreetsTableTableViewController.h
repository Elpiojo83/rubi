//
//  ProjectStreetsTableTableViewController.h
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectStreetsTableTableViewController : CoreDataTableViewController

@property (nonatomic, strong) Section *section;
@property (nonatomic, strong) Street* street;
@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Ratingsection* ratingsection;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
