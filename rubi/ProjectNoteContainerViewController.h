//
//  ProjectNoteCintainerViewControllerTableViewController.h
//  rubi
//
//  Created by David Krachler on 08.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectNoteContainerViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *projectNoteTextField;
@property (weak, nonatomic) IBOutlet UIView *projectNotesView;

@property (nonatomic, strong) Project* project;
@property (nonatomic, strong) Street* street;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@end
