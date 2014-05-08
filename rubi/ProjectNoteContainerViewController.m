//
//  ProjectNoteCintainerViewControllerTableViewController.m
//  rubi
//
//  Created by David Krachler on 08.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ProjectNoteContainerViewController.h"
#import "Project.h"
#import "Street.h"
#import "ProjectViewController.h"


@interface ProjectNoteContainerViewController ()

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

@implementation ProjectNoteContainerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
   if(!self.project.projectNote){
        self.projectNoteTextField.text = [NSString stringWithFormat:@""];
    }else{
        self.projectNoteTextField.text = [NSString stringWithFormat:@" %@", self.project.projectNote];
    }
   

}

-(void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    
    self.project.projectNote = self.projectNoteTextField.text;
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
    
    NSLog(@"Nnote %@", self.project.projectNote);
    
    NSLog(@"Save Notes");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
