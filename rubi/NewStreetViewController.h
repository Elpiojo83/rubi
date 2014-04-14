//
//  NewStreetViewController.h
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewStreetViewController : UIViewController <UITextFieldDelegate>


@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Street* street;
@property (nonatomic, strong) NSManagedObjectContext* parentManagedObjectContext;

@end
