//
//  StreetsTableViewController.m
//  rubi
//
//  Created by David Krachler on 24.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "StreetsTableViewController.h"
#import "NewStreetViewController.h"
#import "ProjectStreetsTableTableViewController.h"

@interface StreetsTableViewController ()

@end

@implementation StreetsTableViewController

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Street"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"streetname" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" project == %@" , self.project];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}

#pragma mark StreetsTable

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"streetsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Street *street = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    
    //Street *street = [[self.project.streets allObjects] objectAtIndex:indexPath.row];
    
    NSLog(@"streets in table %@", street);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",  street.streetname];
        
    return cell;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Streets inTableView: %@", self.street);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"addStreet"]){
        
        Project *dvcProject = self.project;
        NewStreetViewController *dvc = [segue destinationViewController];
        dvc.project = dvcProject;

    }
    if([segue.identifier isEqualToString:@"StreetsTable"]){
        
        Project *dvcProject = self.project;
        ProjectStreetsTableTableViewController *dvc = [segue destinationViewController];
        dvc.project = dvcProject;
        Street *street = [[self.project.streets allObjects] objectAtIndex: self.tableView.indexPathForSelectedRow.row];
        dvc.street = street;
        
        dvc.managedObjectContext = street.managedObjectContext;
    }
}


@end
