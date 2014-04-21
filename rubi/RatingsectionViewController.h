//
//  RatingsectionViewController.h
//  rubi
//
//  Created by David Krachler on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingsectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *RatingSectionInterfaceView;

@property (nonatomic, strong) Section *section;
@property (nonatomic, strong) Street* street;
@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Ratingsection *ratingsection;


@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
