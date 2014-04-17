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



/*
- (void)setupFetchedResultsController // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Street"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"project"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    
    //request.predicate = [NSPredicate predicateWithFormat:@"street.streetname = %@", self.street.streetname];
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.project.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}
*/
// 16. Update our title and set up our NSFRC when our Model is set
/*
- (void)setSection:(Section *)section
{
    _section = section;
    self.title = section.sectionname;
    
  //  NSLog(@"TitleData: %@", section.sectionname);
    
    [self setupFetchedResultsController];
}
*/
// 18. Load up our cell using the NSManagedObject retrieved using NSFRC's objectAtIndexPath:
// (back to PhotographersTableViewController.m for next step, segueing)

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
    
    //NSLog(@"Sections: %@", section.sectionname);
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    

    if([segue.identifier isEqualToString:@"addSection"]){
        
        NewSectionFormView *dvc = [segue destinationViewController];
        dvc.street = self.street;
        
    }
    if([segue.identifier isEqualToString:@"toRatingSections"]){
        
        RatingSectionsTableViewController *dvc = [segue destinationViewController];
        dvc.section = self.section;
        
    }


    
    //Street *street = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    /*
    if ([segue.identifier isEqualToString:@"addSection"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Street *dvcStreet = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NewSectionFormView *dvc = [segue destinationViewController];
        dvc.street = dvcStreet;
        NSLog(@"DVC Street: %@", dvcStreet);
    
    }
     */
    
}

/*
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    Street *street = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
}
*/



-(void)viewDidAppear:(BOOL)animated{
    
    
    NSLog(@"Project: %@", self.project.streets);
    
   // NSLog(@"Sections: %@", self.street.section);
    /*
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* manageObjectContext = appDelegate.managedObjectContext;
    
    NSManagedObject* section = [NSEntityDescription insertNewObjectForEntityForName:@"Section" inManagedObjectContext:manageObjectContext];
    
    NSString* newSection = [NSString stringWithFormat:@"%@", @"Testsection"];
    
    [section setValue:newSection forKey:@"sectionname"];
    
    
    [self.street addSectionObject:(Section*)section];
    
     
    NSLog(@"New Section: %@", section);
    */
}

// 20. Add segue to show the photo (ADDED AFTER LECTURE)
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    if ([segue.identifier isEqualToString:@"Show Photo"]) {
        [segue.destinationViewController setImageURL:[NSURL URLWithString:photo.imageURL]];
        [segue.destinationViewController setTitle:photo.title];
    }
}
*/
@end
