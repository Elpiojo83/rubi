//
//  Street.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project, Section;

@interface Street : NSManagedObject

+(Street*) createStreetInmanagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

@property (nonatomic, retain) NSString * streetname;
@property (nonatomic, retain) NSDate * streetCrdate;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSSet *section;
@end

@interface Street (CoreDataGeneratedAccessors)

- (void)addSectionObject:(Section *)value;
- (void)removeSectionObject:(Section *)value;
- (void)addSection:(NSSet *)values;
- (void)removeSection:(NSSet *)values;

@end
