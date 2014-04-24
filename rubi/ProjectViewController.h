//
//  ProjectViewController.h
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextView *projectNoteTextField;

@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Street* street;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@end
