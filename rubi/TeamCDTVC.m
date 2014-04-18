//
//  TeamCDTVC.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "TeamCDTVC.h"
#import "TeamTVCell.h"

@interface TeamCDTVC ()

@end

@implementation TeamCDTVC


-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Employees"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"lastname" ascending:YES ]];

        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Employee";
    
    TeamTVCell *cell = (TeamTVCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Employees *employee = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.employe = employee;
    
    return cell;
}

- (IBAction)addNewTeamMember:(UIBarButtonItem *)sender {
    
    NSManagedObject* employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employees" inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    [self.managedObjectContext save: &error];
}

- (IBAction)done:(UIBarButtonItem *)sender {
    NSError *error = nil;
    [self.managedObjectContext save: &error];

    [self dismissViewControllerAnimated: YES completion: NULL];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        @try {
            Employees *member = [self.fetchedResultsController objectAtIndexPath: indexPath];
            
            //[context deleteObject: route];
            [self.managedObjectContext deleteObject: member];
            
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
         
        }
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
