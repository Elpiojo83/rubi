//
//  NewStreetViewController.m
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "Project.h"
#import "Street.h"
#import "ProjectViewController.h"
#import "CollectionView.h"

#import "NewStreetViewController.h"

@interface NewStreetViewController ()

@property (nonatomic, strong) NSManagedObject* theStreet;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITextField *streetTextField;


@end

@implementation NewStreetViewController

- (IBAction)addNewStreet:(id)sender {
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* manageObjectContext = appDelegate.managedObjectContext;
    
    NSManagedObject* street = [NSEntityDescription insertNewObjectForEntityForName:@"Street" inManagedObjectContext:manageObjectContext];
    
    NSString* newStreet = [NSString stringWithFormat:@"%@", self.streetTextField.text];
    
    NSDate * newDate = [NSDate date]; //self.project.projectTimestamp;
    
    
    
    
    time_t unixTime = (time_t) [newDate timeIntervalSince1970];
    NSString *unixTS = [NSString stringWithFormat:@" %ld", unixTime];
    
    NSLog(@"The Timestamp: %@", unixTS);
    
    [street setValue:[NSDate date] forKey:@"streetCrdate"];
    [street setValue:newStreet forKey:@"streetname"];
    [street setValue:unixTS forKey:@"streetUnixTimestamp"];
    
    
    [self.project addStreetsObject:(Street*)street];
    
    //   NSLog(@"theObejct: %@", street);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)cancelNewStreetFormTouchUpInside:(id)sender {
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
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated{
    //  NSLog(@"Object1: %@", self.project.streets);
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