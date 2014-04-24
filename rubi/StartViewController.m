//
//  StartViewController.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 23.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "StartViewController.h"
#import "CollectionViewCell.h"
#import "Project.h"
#import "NewProjectFormView.h"
#import "ProjectViewController.h"
#import "TeamCDTVC.h"
#import "Street.h"

@interface StartViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *projectCV;

@property (nonatomic, strong) NSArray *projectArray;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;


@end

@implementation StartViewController

#pragma mark Fetched Result Controller

-(NSFetchedResultsController *)fetchedResultsController{
    
    if(_fetchedResultsController) return _fetchedResultsController;
    
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Project class])];
    NSSortDescriptor* sortPoject = [NSSortDescriptor sortDescriptorWithKey:@"projectTimestamp" ascending:NO];
    
    fetch.sortDescriptors = @[sortPoject];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    [_fetchedResultsController performFetch:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
        abort();
    }
    
    
    return _fetchedResultsController;
    
}

#pragma mark View Lifecycle

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[section];
    return [info numberOfObjects];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(480.0, 340.0);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(120., 260., 60., 55.);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ProjectCell";
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Project *projectTitle = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.ProjectTitleLabel.text = [NSString stringWithFormat:@"%@", projectTitle.projectTitle];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveManagedObjectContext:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
    
    NSManagedObjectContext* managedObject = delegate.managedObjectContext;
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    NSError* error;
    
    NSArray *allProjects = [managedObject executeFetchRequest:fetch error:&error];
    
    self.projectArray = allProjects;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [[self fetchedResultsController] delegate];
    
    // NSLog(@"Test GITHub");
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)saveManagedObjectContext: (NSNotification*) notification{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSError* error;
    [self.managedObjectContext save:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
    }
    
    [self refresh];
    
}

-(void) refresh{
    
    //    [self.collectionView reloadSections:0];
    
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Project class])];
    NSSortDescriptor* sortPoject = [NSSortDescriptor sortDescriptorWithKey:@"projectTimestamp" ascending:NO];
    
    fetch.sortDescriptors = @[sortPoject];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    
    [_fetchedResultsController performFetch:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
        abort();
    }
    
    
    [self.projectCV reloadData];
    
    //NSLog(@"Data reloaded");
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *mySelectedCell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    mySelectedCell.ProjectTitleLabel.textColor = [UIColor blackColor];
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *mySelectedCell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    mySelectedCell.ProjectTitleLabel.textColor = [UIColor blackColor];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"addProject"]){
        NewProjectFormView* controller = segue.destinationViewController;
        controller.parentManagedObjectContext = self.managedObjectContext;
    }
    if([segue.identifier isEqualToString:@"projectSegue"]){
        NSIndexPath *selectedIndexPath = [[self.projectCV indexPathsForSelectedItems] objectAtIndex:0];
        Project *project = [[self fetchedResultsController] objectAtIndexPath:selectedIndexPath];
        ProjectViewController *dvc = [segue destinationViewController];
        dvc.project = project;
        dvc.project.streets = project.streets;
        //dvc.street = self.street;
        
        Street *street = [[self fetchedResultsController] objectAtIndexPath:selectedIndexPath];
        dvc.street = street;
        
        dvc.managedObjectContext = self.managedObjectContext;
        
        NSLog(@"StreetFormsegue %@", street);
        
    }
    if([segue.identifier isEqualToString:@"manageTeam"]){
        TeamCDTVC *dvc = (TeamCDTVC *)[[segue destinationViewController] topViewController];
        dvc.managedObjectContext = self.managedObjectContext;
    }
}


@end
