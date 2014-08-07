//
//  Contact.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSNumber * zip;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * position;
@property (nonatomic, retain) NSSet *project;
@property (nonatomic, retain) NSString * deviceID;
@end

@interface Contact (CoreDataGeneratedAccessors)

- (void)addProjectObject:(Project *)value;
- (void)removeProjectObject:(Project *)value;
- (void)addProject:(NSSet *)values;
- (void)removeProject:(NSSet *)values;

@end
