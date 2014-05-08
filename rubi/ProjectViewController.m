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
#import "AnsprechpartnerTVC.h"
#import "TeamToProjectCVC.h"
#import "StreetsTableViewController.h"
#import "ProjectNoteContainerViewController.h"


@interface ProjectViewController ()


@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
//@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (weak, nonatomic) IBOutlet UIView *AnsprechpartnerView;
@property (weak, nonatomic) IBOutlet UIView *TeamView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *StrreetsTableView;

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
    
}

- (void)viewDidAppear:(BOOL)animated{
   
    [super viewDidAppear:animated];
    
    self.navigationItem.title = [NSString stringWithFormat:@" %@", self.project.projectTitle];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    
    [self.segmentedControl addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)changeView: (UISegmentedControl *) control {
    switch (control.selectedSegmentIndex) {
        case 0:
            self.TeamView.hidden = YES;
            self.AnsprechpartnerView.hidden = NO;
            break;
        case 1:
            self.AnsprechpartnerView.hidden = YES;
            self.TeamView.hidden = NO;
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ( [segue.identifier isEqualToString: @"Ansprechpartner"]) {
        AnsprechpartnerTVC *controller = (AnsprechpartnerTVC *)segue.destinationViewController;
        controller.project = self.project;
        controller.contact = [[self.project.contacts allObjects] firstObject];
        controller.managedObjectContext = self.project.managedObjectContext;
    }
    
    if ( [segue.identifier isEqualToString: @"Team"]) {
        TeamToProjectCVC *controller = (TeamToProjectCVC *)segue.destinationViewController;
        controller.project = self.project;
        controller.managedObjectContext = self.project.managedObjectContext;

    }
    
    if ( [segue.identifier isEqualToString: @"Streets"]) {
        
        StreetsTableViewController *dvc = (StreetsTableViewController *) [[segue destinationViewController] topViewController];
        dvc.project = self.project;
        dvc.street = self.street;
        dvc.managedObjectContext = self.managedObjectContext;
        NSLog(@"StreetsTableSegue: %@", dvc.street);
        
    }
    
    if ( [segue.identifier isEqualToString: @"ProjectNotes"]) {
        
        ProjectNoteContainerViewController *dvc = [segue destinationViewController];
        dvc.project = self.project;
        dvc.managedObjectContext = self.managedObjectContext;
        
    }
    
    
}


@end
