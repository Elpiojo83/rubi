//
//  ProjectViewController.m
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Project.h"
#import "Street.h"
#import "ProjectViewController.h"
#import "CollectionView.h"
#import "ProjectStreetsTableTableViewController.h"
#import "NewStreetViewController.h"


@interface ProjectViewController ()
@property (weak, nonatomic) IBOutlet UIView *projectNotesView;
@property (weak, nonatomic) IBOutlet UITextView *projectNotesTextView;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) UITableView* tableView;

@end

@implementation ProjectViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   NSLog(@"Title: %@", self.project.projectTitle);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.projectNotesView.layer.borderColor = [UIColor grayColor].CGColor;
    self.projectNotesView.layer.borderWidth = 1.0f;
    self.projectNotesView.layer.cornerRadius = 5.0f;
    
    self.projectNotesTextView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
//    NSLog(@"ProjectStreets: %@", self.project.streets);
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationItem.title = [NSString stringWithFormat:@" %@", self.project.projectTitle];
  //  NSLog(@"Title: %@", self.project.projectTitle);
    
    if(!self.project.projectNote){
        self.projectNoteTextField.text = [NSString stringWithFormat:@""];
    }else{
        self.projectNoteTextField.text = [NSString stringWithFormat:@" %@", self.project.projectNote];
    }
    
    [self.tableView reloadData];
    
}

-(void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    
    self.project.projectNote = self.projectNoteTextField.text;
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
    
   // NSLog(@"Save Notes");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
  
  /*
    NSLog(@"Rows: %i", [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects]);
    
   return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
   */
    return [self.project.streets count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"streetsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Street *street = [[self.project.streets allObjects] objectAtIndex:indexPath.row];
    
    NSString* streetTitle = [NSString stringWithFormat:@"%@", street.streetname];
    
   // NSArray *names = [self.project.streets valueForKeyPath:@"streetname"];
   // NSLog(@"Streetnames: %@", names);
    
    //cell.textLabel.text = [names objectAtIndex:indexPath.row];
    cell.textLabel.text = streetTitle;
    
    return cell;
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"addStreet"]){
        
        Project *dvcProject = self.project;
        NewStreetViewController *dvc = [segue destinationViewController];
        dvc.project = dvcProject;
        
         NSLog(@"dvc Item: %@", dvcProject);
    }
    //Project *dvcProject = self.project;
    if([segue.identifier isEqualToString:@"Streets"]){
        
        Project *dvcProject = self.project;
        ProjectStreetsTableTableViewController *dvc = [segue destinationViewController];
        dvc.project = dvcProject;
        NSLog(@"DVC: %@", dvcProject);
    }
    
   
    
    
}


@end
