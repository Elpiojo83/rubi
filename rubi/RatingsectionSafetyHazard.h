//
//  RatingsectionSafetyHazard.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ratingsection;

@interface RatingsectionSafetyHazard : NSManagedObject

@property (nonatomic, retain) NSString * safetyHazardNote;
@property (nonatomic, retain) NSString * safetyHazardImagePath;
@property (nonatomic, retain) Ratingsection *ratingsections;
@property (nonatomic, retain) NSString * deviceID;

@end
