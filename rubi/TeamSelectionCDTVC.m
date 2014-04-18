//
//  TeamSelectionCDTVC.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 18.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "TeamSelectionCDTVC.h"
#import "TeamSelectionTVCell.h"

@interface TeamSelectionCDTVC ()

@end

@implementation TeamSelectionCDTVC


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
    
    static NSString *CellIdentifier = @"TeamSelectionCell";
    
    TeamSelectionTVCell *cell = (TeamSelectionTVCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Employees *employee = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.employe = employee;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Employees *selEmployee = [[self.fetchedResultsController fetchedObjects] objectAtIndex: indexPath.row];
    
    [self.delegate selectedEmployee: selEmployee fromSender: self];
    
    [self dismissViewControllerAnimated: YES completion: NULL];
}

- (IBAction)done:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated: YES completion: NULL];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated: YES completion: NULL];
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
