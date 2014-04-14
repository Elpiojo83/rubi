//
//  RatingImage.h
//  rubi
//
//  Created by David Krachler on 24.03.14.
//  Copyright (c) 2014 Koerbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Ratingsection;

@interface RatingImage : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) Ratingsection *ratingsection;

@end
