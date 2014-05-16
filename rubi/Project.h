//
//  Project.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact, Employees, Street;

@interface Project : NSManagedObject

+(Project*) createProjectInmanagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

@property (nonatomic, retain) NSString * projectTitle;
@property (nonatomic, retain) NSDate * projectTimestamp;
@property (nonatomic, retain) NSString * unixTimestamp;
@property (nonatomic, retain) NSString * projectNote;
@property (nonatomic, retain) NSSet *employees;
@property (nonatomic, retain) NSSet *contacts;
@property (nonatomic, retain) NSSet *streets;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Employees *)value;
- (void)removeEmployeesObject:(Employees *)value;
- (void)addEmployees:(NSSet *)values;
- (void)removeEmployees:(NSSet *)values;

- (void)addContactsObject:(Contact *)value;
- (void)removeContactsObject:(Contact *)value;
- (void)addContacts:(NSSet *)values;
- (void)removeContacts:(NSSet *)values;

- (void)addStreetsObject:(Street *)value;
- (void)removeStreetsObject:(Street *)value;
- (void)addStreets:(NSSet *)values;
- (void)removeStreets:(NSSet *)values;

@end
