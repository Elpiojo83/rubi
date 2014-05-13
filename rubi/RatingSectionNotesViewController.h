//
//  RatingSectionNotesViewController.h
//  rubi
//
//  Created by David Krachler on 13.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingSectionNotesViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *ratingSectionNotesTextField;

@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Ratingsection* ratingsection;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@end
