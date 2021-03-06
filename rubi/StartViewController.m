//
//  StartViewController.m
//  rubi
//
//  Created by Markus Kroisenbrunner on 23.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "StartViewController.h"
#import "CollectionViewCell.h"
#import "Project.h"
#import "NewProjectFormView.h"
#import "ProjectViewController.h"
#import "TeamCDTVC.h"
#import "Street.h"
#import "MBProgressHUD.h"

@interface StartViewController () <UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UIGestureRecognizerDelegate,
                                    UIAlertViewDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;


@property (nonatomic, strong) IBOutlet UICollectionView *projectCV;

@property (nonatomic, strong) NSArray *projectArray;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (nonatomic, strong) NSIndexPath* indexPathToDelete;

@end

@implementation StartViewController

#pragma mark Fetched Result Controller

-(NSFetchedResultsController *)fetchedResultsController{
    
    if(_fetchedResultsController) return _fetchedResultsController;
    
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Project class])];
    NSSortDescriptor* sortPoject = [NSSortDescriptor sortDescriptorWithKey:@"projectTimestamp" ascending:NO];
    
    fetch.sortDescriptors = @[sortPoject];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    [_fetchedResultsController performFetch:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
        abort();
    }
    
    
    return _fetchedResultsController;
    
}

#pragma mark View Lifecycle

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    id<NSFetchedResultsSectionInfo> info = self.fetchedResultsController.sections[section];
    return [info numberOfObjects];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(480.0, 340.0);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(120., 260., 60., 55.);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ProjectCell";
    
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Project *projectTitle = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.ProjectTitleLabel.text = [NSString stringWithFormat:@"%@", projectTitle.projectTitle];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveManagedObjectContext:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
    
    NSManagedObjectContext* managedObject = delegate.managedObjectContext;
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    NSError* error;
    
    NSArray *allProjects = [managedObject executeFetchRequest:fetch error:&error];
    
    self.projectArray = allProjects;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(longPressHandler:)];
    longPress.delegate = self;
    

    [self.projectCV addGestureRecognizer:longPress];

}



-(void) longPressHandler:(UILongPressGestureRecognizer*)gesture{
    
    CGPoint tapLocation = [gesture locationInView: self.projectCV];
    
    
    
    NSIndexPath *indexPath = [self.projectCV indexPathForItemAtPoint: tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateRecognized) {

        
        
        self.indexPathToDelete = indexPath;
        
        UIAlertView *deleteAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Löschen?"
                                    message:[NSString stringWithFormat:@"Wollen Sie wirklich dieses Projekt löschen?"]
                                    delegate:self cancelButtonTitle:@"Abbrechen" otherButtonTitles:@"OK", nil];
        deleteAlert.delegate = self;
       
        
        NSIndexPath *indexPath = [self.projectCV indexPathForItemAtPoint: tapLocation];
        UICollectionViewCell *cell = [self.projectCV cellForItemAtIndexPath:indexPath];
        
        NSLog(@"Index %@", indexPath);
        
        CGPoint position = cell.center;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(position.x, position.y)];
        [path addLineToPoint:CGPointMake(position.x-5, position.y)];
        [path addLineToPoint:CGPointMake(position.x, position.y)];
        [path addLineToPoint:CGPointMake(position.x-5, position.y)];
        [path addLineToPoint:CGPointMake(position.x, position.y)];
        [path addLineToPoint:CGPointMake(position.x-5, position.y)];
        [path addLineToPoint:CGPointMake(position.x, position.y)];
        [path addLineToPoint:CGPointMake(position.x-5, position.y)];
        [path addLineToPoint:CGPointMake(position.x, position.y)];
        [path addLineToPoint:CGPointMake(position.x-5, position.y)];
        [path addLineToPoint:CGPointMake(position.x, position.y)];
        [path addLineToPoint:CGPointMake(position.x-5, position.y)];
        [path addLineToPoint:CGPointMake(position.x, position.y)];
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.path = path.CGPath;
        positionAnimation.duration = 1.0f;
        positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        
        [CATransaction begin];
        [cell.layer addAnimation:positionAnimation forKey:nil];
        [CATransaction commit];
        
        
        [deleteAlert show];
        
    }
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected button index = %ld", (long)buttonIndex);
    if (buttonIndex == 1) {
        // Do what you need to do to delete the cell
        
        [self.projectCV performBatchUpdates:^{
            
            
            Project *projectToDelete = [self.fetchedResultsController.fetchedObjects objectAtIndex: self.indexPathToDelete.row];
            
            [self.managedObjectContext deleteObject: projectToDelete];
            
            ;
            
        } completion: ^(BOOL finished) {
            
            [self.projectCV reloadData];
        }];
        
        
    }
    
    self.indexPathToDelete = nil;

}

-(void)viewDidAppear:(BOOL)animated{
    [[self fetchedResultsController] delegate];
    
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)saveManagedObjectContext: (NSNotification*) notification{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSError* error;
    [self.managedObjectContext save:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
    }
    
    [self refresh];
    
}

-(void) refresh{
    
    NSFetchRequest* fetch = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Project class])];
    NSSortDescriptor* sortPoject = [NSSortDescriptor sortDescriptorWithKey:@"projectTimestamp" ascending:NO];
    
    fetch.sortDescriptors = @[sortPoject];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    
    [_fetchedResultsController performFetch:&error];
    
    if(error){
        NSLog(@"Error: %@", error);
        abort();
    }
    
    
    [self.projectCV reloadData];

}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell *mySelectedCell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    mySelectedCell.ProjectTitleLabel.textColor = [UIColor blackColor];
    
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *mySelectedCell = (CollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    mySelectedCell.ProjectTitleLabel.textColor = [UIColor blackColor];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"addProject"]){
        NewProjectFormView* controller = segue.destinationViewController;
        controller.parentManagedObjectContext = self.managedObjectContext;
    }
    if([segue.identifier isEqualToString:@"projectSegue"]){
        NSIndexPath *selectedIndexPath = [[self.projectCV indexPathsForSelectedItems] objectAtIndex:0];
        Project *project = [[self fetchedResultsController] objectAtIndexPath:selectedIndexPath];
        ProjectViewController *dvc = [segue destinationViewController];
        dvc.project = project;
        dvc.project.streets = project.streets;
        //dvc.street = self.street;
        
        Street *street = [[self fetchedResultsController] objectAtIndexPath:selectedIndexPath];
        dvc.street = street;
        
        dvc.managedObjectContext = self.managedObjectContext;
        
        NSLog(@"StreetFormsegue %@", street);
        
    }
    if([segue.identifier isEqualToString:@"manageTeam"]){
        TeamCDTVC *dvc = (TeamCDTVC *)[[segue destinationViewController] topViewController];
        dvc.managedObjectContext = self.managedObjectContext;
    }
}

#pragma mark Upload sqlite

- (void)sendFile:(NSString *)filePath toServer:(NSString *)serverURL
{

    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (!fileData) {
        NSLog(@"Error: file error");
        return;
    }
    
    if (self.urlConnection) {
        [self.urlConnection cancel];
        self.urlConnection = nil;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:serverURL]];
    [request setTimeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"780808070779786865757";
    
    /* Header */
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    /* Body */
    NSMutableData *postData = [NSMutableData data];
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"file\"; filename=\"rubi.sqlite\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:fileData];
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    
    self.urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void)sendImage:(NSString *)filePath toServer:(NSString *)serverURL
{
    
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (!fileData) {
        NSLog(@"Error: file error");
        return;
    }
    
    if (self.urlConnection) {
        [self.urlConnection cancel];
        self.urlConnection = nil;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:serverURL]];
    [request setTimeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"780808070779786865757";
    
    /* Header */
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    int r = rand();
    
    /* Body */
    NSMutableData *postData = [NSMutableData data];
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"file\"; filename=\"@%d.png\"\r\n", r] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:fileData];
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    
    self.urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}





- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if (self.receivedData) {
        self.receivedData = nil;
    }
    self.receivedData = [[NSMutableData alloc] init];
    expectedLength = MAX([response expectedContentLength], 1);
	currentLength = 0;
	HUD.mode = MBProgressHUDModeDeterminate;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
    
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finish requesting: %@", [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding]);
    self.urlConnection = nil;
    HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"requesting error: %@", [error localizedDescription]);
    self.urlConnection = nil;
    [HUD hide:YES];
}


- (IBAction)exportProjectToServer:(id)sender {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// Set determinate bar mode
	// Set determinate mode
	HUD.mode = MBProgressHUDModeDeterminate;
	
	HUD.delegate = self;
	HUD.labelText = @"Loading";
	
	// myProgressTask uses the HUD instance to update progress
	[HUD showWhileExecuting:@selector(sendFile:toServer:) onTarget:self withObject:nil animated:YES];
    
    NSString *localFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"rubi.sqlite"];

    
    //NSString *myGrabbedImage = [NSString stringWithFormat:@"%@.png" , @"15.43078893,47.06967842"];//@"SiGe.png";
    
    //NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,          NSUserDomainMask, YES);
    //NSString *documentDirectory = [path objectAtIndex:0];
    //NSString *fullPath = [documentDirectory stringByAppendingPathComponent:myGrabbedImage];
    //NSData *data = [NSData dataWithContentsOfFile:fullPath];
    
    
    NSString *api = @"http://app.rubi.st.automatix.koerbler.com/app/upload/upload.php";
    
    
    //[self sendImage:fullPath toServer:api];
    [self sendFile:localFile toServer:api];
    

    NSLog(@"touch: %@", localFile);
    
}




@end
