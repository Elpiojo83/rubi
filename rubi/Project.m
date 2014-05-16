//
//  Project.m
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import "Project.h"
#import "Contact.h"
#import "Employees.h"
#import "Street.h"


@implementation Project

+(Project *)createProjectInmanagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:managedObjectContext];
}

@dynamic projectTitle;
@dynamic projectTimestamp;
@dynamic unixTimestamp;
@dynamic projectNote;
@dynamic employees;
@dynamic contacts;
@dynamic streets;

@end
