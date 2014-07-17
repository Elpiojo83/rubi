//
//  CustomCell.h
//  rubi
//
//  Created by David Krachler on 16.07.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "SWTableViewCell.h"

@interface CustomCell : SWTableViewCell

@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Street* street;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
