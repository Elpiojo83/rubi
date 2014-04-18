//
//  TeamCDTVC.h
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface TeamCDTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
