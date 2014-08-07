//
//  NewSectionFormView.m
//  rubi
//
//  Created by David Krachler on 16.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "NewSectionFormView.h"
#import "ProjectStreetsTableTableViewController.h"
#import "ProjectViewController.h"

@interface NewSectionFormView ()

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;



@end

@implementation NewSectionFormView


- (IBAction)AddNewSection:(id)sender {
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* manageObjectContext = appDelegate.managedObjectContext;

    NSManagedObject* section = [NSEntityDescription insertNewObjectForEntityForName:@"Section" inManagedObjectContext:manageObjectContext];
    
    NSString* newSection = [NSString stringWithFormat:@"%@", self.NewSectionTextField.text];
    
    [section setValue:uniqueDeviceID forKey:@"deviceID"];
    
    [section setValue:newSection forKey:@"sectionname"];
    
    
    [self.street addSectionObject:(Section*)section];
    
    
    NSLog(@"New Section: %@", section);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)CancelNewSection:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    
    
    //NSLog(@"Street in Form%@", [[self.street.section allObjects] objectAtIndex:0]);
    
    
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
