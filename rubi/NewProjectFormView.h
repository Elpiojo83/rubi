//
//  NewProjectFormView.h
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewProjectFormView : UIViewController
@property (nonatomic, strong) Project* project;
@property NSManagedObjectContext *parentManagedObjectContext;

@end
