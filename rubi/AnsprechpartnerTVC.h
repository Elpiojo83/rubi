//
//  AnsprechpartnerCDTVC.h
//  rubi
//
//  Created by Markus Kroisenbrunner on 17.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "Project.h"
#import "Contact.h"

@interface AnsprechpartnerTVC : UITableViewController

@property (nonatomic, strong) Contact *contact;
@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@end
