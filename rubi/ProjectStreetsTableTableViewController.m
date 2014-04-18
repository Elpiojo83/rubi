//
//  ProjectStreetsTableTableViewController.m
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "ProjectStreetsTableTableViewController.h"
#import "Street.h"
#import "Project.h"
#import "Section.h"
#import "ProjectViewController.h"
#import "NewSectionFormView.h"
#import "RatingSectionsTableViewController.h"

@interface ProjectStreetsTableTableViewController ()


@end

@implementation ProjectStreetsTableTableViewController



-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Section"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"sectionname" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" street == %@" , self.street];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SectionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Section *section = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    cell.textLabel.text = section.sectionname;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

    if([segue.identifier isEqualToString:@"addSection"]){
        
        NewSectionFormView *dvc = [segue destinationViewController];
        dvc.street = self.street;
        
    }
    
    if([segue.identifier isEqualToString:@"toRatingSections"]){
        
        //Section *sec = [self.fetchedResultsController objectAtIndexPath:0];
        //NSLog(@"the section %@",sec );
        
        
        
        Section *sec = [[self.fetchedResultsController fetchedObjects] objectAtIndex: self.tableView.indexPathForSelectedRow.row];
        NSLog(@"the section %@",sec );
        
        
        RatingSectionsTableViewController *dvc = [segue destinationViewController];
        dvc.section = sec;
        dvc.managedObjectContext = _managedObjectContext;
        
        
    }

}


-(void)viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"ProjectData: %@", self.project.streets);
    
}

@end
