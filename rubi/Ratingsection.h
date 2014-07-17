//
//  Ratingsection.h
//  rubi
//
//  Created by David Krachler on 13.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RatingImage, RatingsectionSafetyHazard, Section;

@interface Ratingsection : NSManagedObject

@property (nonatomic, retain) NSString * endPosition;
@property (nonatomic, retain) NSString * endPositionGPS;
@property (nonatomic, retain) NSString * leftBikepathCondition;
@property (nonatomic, retain) NSString * leftBikepathMethodOfConstruction;
@property (nonatomic, retain) NSString * leftBikepathWidth;
@property (nonatomic, retain) NSString * leftDrainageCondition;
@property (nonatomic, retain) NSString * leftDrainageMethodOfCondition;
@property (nonatomic, retain) NSString * leftEdgeCondition;
@property (nonatomic, retain) NSString * leftEdgeMethodOfConstruction;
@property (nonatomic, retain) NSString * leftSidewalkCondition;
@property (nonatomic, retain) NSString * leftSidewalkMethodOfConstruction;
@property (nonatomic, retain) NSString * leftSidewalkWidth;
@property (nonatomic, retain) NSString * ratingSectionNotes;
@property (nonatomic, retain) NSString * ratingSectionTitle;
@property (nonatomic, retain) NSString * righBikepathWidth;
@property (nonatomic, retain) NSString * rightBikepathCondition;
@property (nonatomic, retain) NSString * rightBikepathMethodOfConstruction;
@property (nonatomic, retain) NSString * rightDrainageCondition;
@property (nonatomic, retain) NSString * rightDrainageMethodOfConstruction;
@property (nonatomic, retain) NSString * rightEdgeCondition;
@property (nonatomic, retain) NSString * rightEdgeMethodOfConstruction;
@property (nonatomic, retain) NSString * rightSidewalkCondition;
@property (nonatomic, retain) NSString * rightSidewalkMethodOfConstruction;
@property (nonatomic, retain) NSString * rightSidewalkWidth;
@property (nonatomic, retain) NSString * startPosition;
@property (nonatomic, retain) NSString * startPositionGPS;
@property (nonatomic, retain) NSString * streetCracks;
@property (nonatomic, retain) NSString * streetFlatness;
@property (nonatomic, retain) NSString * streetMethodOfConstruction;
@property (nonatomic, retain) NSString * streetSurfaceDamage;
@property (nonatomic, retain) NSString * streetWidth;
@property (nonatomic, retain) NSString * sectionSafetyHazardImagePath;
@property (nonatomic, retain) NSString * sectionSafetyHazardNote;
@property (nonatomic, retain) NSString * streetWidthEnd;
@property (nonatomic, retain) NSString * leftSidewalkWidthEnd;
@property (nonatomic, retain) NSString * leftBikepathWidthEnd;
@property (nonatomic, retain) NSString * rightSidewalkWidthEnd;
@property (nonatomic, retain) NSString * rightBikepathWidthEnd;


@property (nonatomic, retain) RatingsectionSafetyHazard *hazards;
@property (nonatomic, retain) NSSet *ratingimage;
@property (nonatomic, retain) Section *section;
@end

@interface Ratingsection (CoreDataGeneratedAccessors)

- (void)addRatingimageObject:(RatingImage *)value;
- (void)removeRatingimageObject:(RatingImage *)value;
- (void)addRatingimage:(NSSet *)values;
- (void)removeRatingimage:(NSSet *)values;

@end
