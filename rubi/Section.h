//
//  Section.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ratingsection, Street;

@interface Section : NSManagedObject

+(Section*) createSectionInmanagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

@property (nonatomic, retain) NSString * sectionname;
@property (nonatomic, retain) Street *street;
@property (nonatomic, retain) NSSet *ratingSection;
@property (nonatomic, retain) NSString * deviceID;
@end

@interface Section (CoreDataGeneratedAccessors)

- (void)addRatingSectionObject:(Ratingsection *)value;
- (void)removeRatingSectionObject:(Ratingsection *)value;
- (void)addRatingSection:(NSSet *)values;
- (void)removeRatingSection:(NSSet *)values;

@end
