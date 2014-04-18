//
//  TeamSelectionCDTVC.h
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Employees.h"

@protocol TeamSelectionCDTVCDelegate;
@interface TeamSelectionCDTVC : CoreDataTableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (assign) id <TeamSelectionCDTVCDelegate> delegate;

@end

@protocol TeamSelectionCDTVCDelegate

-(void) selectedEmployee: (Employees *) employee
              fromSender: (TeamSelectionCDTVC *) sender;

@end