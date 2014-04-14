//
//  Ratingsection.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RatingImage, RatingsectionSafetyHazard, Section;

@interface Ratingsection : NSManagedObject

@property (nonatomic, retain) NSString * ratingSectionTitle;
@property (nonatomic, retain) NSString * startPosition;
@property (nonatomic, retain) NSString * startPositionGPS;
@property (nonatomic, retain) NSString * endPosition;
@property (nonatomic, retain) NSString * endPositionGPS;
@property (nonatomic, retain) NSString * leftSidewalkWidth;
@property (nonatomic, retain) NSString * leftSidewalkMethodOfConstruction;
@property (nonatomic, retain) NSString * leftSidewalkCondition;
@property (nonatomic, retain) NSString * leftEdgeMethodOfConstruction;
@property (nonatomic, retain) NSString * leftEdgeCondition;
@property (nonatomic, retain) NSString * leftDrainageMethodOfCondition;
@property (nonatomic, retain) NSString * leftDrainageCondition;
@property (nonatomic, retain) NSString * streetWidth;
@property (nonatomic, retain) NSString * streetMethodOfConstruction;
@property (nonatomic, retain) NSString * streetFlatness;
@property (nonatomic, retain) NSString * streetSurfaceDamage;
@property (nonatomic, retain) NSString * streetCracks;
@property (nonatomic, retain) NSString * rightDrainageCondition;
@property (nonatomic, retain) NSString * rightDrainageMethodOfConstruction;
@property (nonatomic, retain) NSString * rightEdgeCondition;
@property (nonatomic, retain) NSString * rightEdgeMethodOfConstruction;
@property (nonatomic, retain) NSString * rightBikepathCondition;
@property (nonatomic, retain) NSString * rightBikepathMethodOfConstruction;
@property (nonatomic, retain) NSString * righBikepathWidth;
@property (nonatomic, retain) NSString * leftBikepathCondition;
@property (nonatomic, retain) NSString * leftBikepathMethodOfConstruction;
@property (nonatomic, retain) NSString * leftBikepathWidth;
@property (nonatomic, retain) NSString * rightSidewalkMethodOfConstruction;
@property (nonatomic, retain) NSString * rightSidewalkCondition;
@property (nonatomic, retain) NSString * rightSidewalkWidth;
@property (nonatomic, retain) NSString * ratingSectionNotes;
@property (nonatomic, retain) Section *section;
@property (nonatomic, retain) NSSet *hazards;
@property (nonatomic, retain) NSSet *ratingimage;
@end

@interface Ratingsection (CoreDataGeneratedAccessors)

- (void)addHazardsObject:(RatingsectionSafetyHazard *)value;
- (void)removeHazardsObject:(RatingsectionSafetyHazard *)value;
- (void)addHazards:(NSSet *)values;
- (void)removeHazards:(NSSet *)values;

- (void)addRatingimageObject:(RatingImage *)value;
- (void)removeRatingimageObject:(RatingImage *)value;
- (void)addRatingimage:(NSSet *)values;
- (void)removeRatingimage:(NSSet *)values;

@end
