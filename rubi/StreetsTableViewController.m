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
#import "SWTableViewCell.h"
#import "UMTableViewCell.h"
#import "CustomCell.h"

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

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"Edit"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Löschen"];
    
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    
    return leftUtilityButtons;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *cellIdentifier = @"MyCustomCell";
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    cell.delegate = self;
    
   // cell.customLabel.text = @"Some Text";
  //  cell.customImageView.image = [UIImage imageNamed:@"MyAwesomeTableCellImage"];
  //  [cell setCellHeight:cell.frame.size.height];
    Street *street = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Abschnitt: %@",  street.streetname];
    
    return cell;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"check button was pressed");
            break;
        case 1:
            NSLog(@"clock button was pressed");
            break;
        case 2:
            NSLog(@"cross button was pressed");
            break;
        case 3:
            NSLog(@"list button was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            NSLog(@"More button was pressed");
            break;
        case 1:
        {
            // Delete button was pressed
            
            
            NSLog(@"Delete button was pressed");
            
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            //[_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            //[self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            Street *deleteStreet = [self.fetchedResultsController objectAtIndexPath:cellIndexPath];
            [self.managedObjectContext deleteObject: deleteStreet];
            
            break;
        }
        default:
            break;
    }
}

/*

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"streetsCell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
 
 
    SWTableViewCell  *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.leftUtilityButtons = [self leftButtons];
        cell.rightUtilityButtons = [self rightButtons];
        cell.delegate = self;
    }
    
    
    // Configure the cell...
    Street *street = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    
    //Street *street = [[self.project.streets allObjects] objectAtIndex:indexPath.row];
    
    NSLog(@"streets in table %@", street);
    cell.textLabel.text = [NSString stringWithFormat:@"Abschnitt: %@",  street.streetname];
        
    return cell;

}

*/

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/*

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        Street *deleteStreet = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject: deleteStreet];
    
    }
}
*/
/*
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"More button was pressed");
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"More more more" delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            //NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            //[_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            //[self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
           // Street *deleteStreet = [self.fetchedResultsController objectAtIndexPath:indexPath];
           // [self.managedObjectContext deleteObject: deleteStreet];
            
            NSLog(@"Delete");
            
            break;
        }
        default:
            break;
    }
}
*/
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            // set to NO to disable all left utility buttons appearing
            return NO;
            break;
        case 2:
            // set to NO to disable all right utility buttons appearing
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
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
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Here, indexpath returns the selection of cell's indexpath, so put your code here
    
    //_test.text = [Street objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"StreetsTable" sender:self.tableView];
    
    NSLog(@"PATH2: %@", indexPath);
    //then push your view
    
}
*/
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
        
        //NSIndexPath *cellIndexPath = [self.tableView indexPathForSelectedRow:cell];
        
        //Street *street = [[self.project.streets allObjects] objectAtIndex: self.tableView.indexPathForSelectedRow.row];
        
        // Street *street = [[self.project.streets allObjects] self.tableView:indexPath.row];
        
        NSIndexPath *indexPathItem = [self.tableView indexPathForCell:sender];
        
        Street *street = [[self.project.streets allObjects] objectAtIndex:indexPathItem.row];
        
        NSLog(@"Selected Row: %i", indexPathItem.row);
        
        dvc.street = street;
        
        //  dvc.street = [[self.project.streets allObjects] objectAtIndex:indexPathItem.row];
        
        dvc.managedObjectContext = street.managedObjectContext;
        
        // dvc.managedObjectContext = sender;
        
        //NSLog(@"DVC-Data: %@", dvc);
        
        
        
         Project *dvcProject = self.project;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
         
         Street *street = [[self.project.streets allObjects] objectAtIndex:indexPath.row];
         
         NewStreetViewController *dvc = [segue destinationViewController];
         dvc.project = dvcProject;
         dvc.street = street;
         dvc.managedObjectContext = street.managedObjectContext;
        
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        NSLog(@"PATH: %i", path.row);
        
        
    }
}
@end
