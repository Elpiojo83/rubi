//
//  Section.m
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import "Section.h"
#import "Ratingsection.h"
#import "Street.h"


@implementation Section

+(Section *)createSectionInmanagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"Section" inManagedObjectContext:managedObjectContext];
}

@dynamic sectionname;
@dynamic street;
@dynamic ratingSection;

@end
