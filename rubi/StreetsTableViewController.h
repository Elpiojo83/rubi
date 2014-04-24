//
//  StreetsTableViewController.h
//  rubi
//
//  Created by David Krachler on 24.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface StreetsTableViewController : CoreDataTableViewController

@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Street* street;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
