//
//  Street.m
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import "Street.h"
#import "Project.h"
#import "Section.h"


@implementation Street

+(Street*) createStreetInmanagedObjectContext: (NSManagedObjectContext*) managedObjectContext{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Street" inManagedObjectContext:managedObjectContext];
}

@dynamic streetname;
@dynamic streetCrdate;
@dynamic project;
@dynamic section;

@end
