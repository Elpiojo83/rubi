//
//  NewProjectFormView.m
//  rubi
//
//  Created by David Krachler on 27.03.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "NewProjectFormView.h"
#import "CollectionView.h"

@interface NewProjectFormView ()
@property (weak, nonatomic) IBOutlet UITextField *NewProjectTitleTextField;

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

@implementation NewProjectFormView

- (IBAction)CancelNewProject:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)AddNewProjectTouchUpInside:(id)sender {
    
    
    self.project.projectTitle = self.NewProjectTitleTextField.text;
    self.project.projectTimestamp = [NSDate date];
    
    NSError* error;
    [self.managedObjectContext save:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
    }
    
    NSLog(@"%@", self.project);

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
    self.managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.parentContext = self.parentManagedObjectContext;
    self.project = [Project createProjectInmanagedObjectContext:self.managedObjectContext];
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
