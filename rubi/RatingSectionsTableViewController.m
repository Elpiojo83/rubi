//
//  RatingSectionsTableViewController.m
//  rubi
//
//  Created by David Krachler on 17.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "RatingSectionsTableViewController.h"
#import "ProjectStreetsTableTableViewController.h"
#import "Street.h"
#import "Project.h"
#import "Section.h"
#import "ProjectViewController.h"
#import "NewSectionFormView.h"
#import "Ratingsection.h"

@interface RatingSectionsTableViewController ()

@end

@implementation RatingSectionsTableViewController

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Ratingsection"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"startPosition" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" section == %@" , self.section];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"RatingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Ratingsection *ratingsection = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    cell.textLabel.text = ratingsection.startPosition;
    

    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
/*
    if([segue.identifier isEqualToString:@"addSection"]){
        
        NewSectionFormView *dvc = [segue destinationViewController];
        dvc.street = self.street;
        
    }
 */
    
}





-(void)viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"Project: %@", self.project.streets);

}



@end
