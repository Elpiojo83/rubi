//
//  TeamToProjectCVC.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "TeamToProjectCVC.h"
#import "TeamToProjectCVCell.h"
#import "TeamSelectionCDTVC.h"

@interface TeamToProjectCVC () <TeamSelectionCDTVCDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation TeamToProjectCVC

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Employees"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"lastname" ascending:YES ]];
        
        //request.predicate = [NSPredicate predicateWithFormat: @" project == %@" , self.project];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                            managedObjectContext: managedObjectContext
                                                                              sectionNameKeyPath: nil
                                                                                       cacheName: nil];
        NSError *error = nil;
        [self.fetchedResultsController performFetch: &error];
    }
    else {
        self.fetchedResultsController = nil;
    }
}

-(void)selectedEmployee:(Employees *)employee
             fromSender:(TeamSelectionCDTVC *)sender {
    
    [self.project addEmployeesObject: employee];

    [employee addProjectObject: self.project];
    NSError *error = nil;
    [self.managedObjectContext save: &error];

}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    /*
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections] [section];
    return [sectionInfo numberOfObjects];
    */
    
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeamToProjectCVCell *cell = (TeamToProjectCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier: @"MemberToProjectCVCell" forIndexPath:indexPath];
    
    Employees *employee = nil;
    NSLog(@"%ld", (long)indexPath.row);
    NSLog(@"%lu", (unsigned long)[[self.fetchedResultsController fetchedObjects] count]);
    if (indexPath.row <[[self.fetchedResultsController fetchedObjects] count]) {
        employee = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    
    cell.employee = employee;
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"searchTeam"]) {
        TeamSelectionCDTVC *controller = (TeamSelectionCDTVC *)[segue.destinationViewController topViewController];
        controller.managedObjectContext = self.managedObjectContext;
        controller.delegate = self;
    }
}

@end
