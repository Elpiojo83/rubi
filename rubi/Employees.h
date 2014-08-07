//
//  Employees.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Employees : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *project;
@property (nonatomic, retain) NSString * deviceID;
@end

@interface Employees (CoreDataGeneratedAccessors)

- (void)addProjectObject:(Project *)value;
- (void)removeProjectObject:(Project *)value;
- (void)addProject:(NSSet *)values;
- (void)removeProject:(NSSet *)values;

@end
