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

    
    //self.urlConnection = nil;
    
    HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:5000];
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Export"
                                                    message:@"Upload erfolgreich."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
     
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"requesting error: %@", [error localizedDescription]);
    self.urlConnection = nil;
    [HUD hide:YES];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Export"
                                                    message:@"Upload fehlgeschlagen bitte versuchen Sie es erneut."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
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
    
    //[HUD showWhileExecuting:@selector(pushImages:toServer:) onTarget:self withObject:nil animated:YES];
    
    NSString *localFile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"rubi.sqlite"];

    
    NSString *api = @"http://app.rubi.st.automatix.koerbler.com/app/upload/upload.php";
    
    NSString *upload = @"http://app.rubi.st.automatix.koerbler.com/app/upload/image-upload.php";
    
    NSString *img = @"Send";
    
    [self sendFile:localFile toServer:api];
    
    
    [self pushImages:img toServer:upload];
    

    NSLog(@"touch: %@", localFile);
    
    
    
}

//-(void)pushImages upload:(NSString *)uploadURL{
    
-(void)pushImages:(NSString *)imagFile toServer:(NSString *)serverURL{
    
    NSLog(@"UPLOADING: %@",imagFile);
    
    NSLog(@"API URL: %@",serverURL);
    
    //fetch data
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveManagedObjectContext:) name:NSManagedObjectContextObjectsDidChangeNotification object:self.managedObjectContext];
    
    
    NSManagedObjectContext* managedObject = delegate.managedObjectContext;
    
    
    NSFetchRequest* fetchImages = [NSFetchRequest fetchRequestWithEntityName:@"Ratingsection"];
    
    NSFetchRequest* fetchRatingImages = [NSFetchRequest fetchRequestWithEntityName:@"RatingImage"];
    
    NSError* error;
    
    NSArray *allRatingsections = [managedObject executeFetchRequest:fetchImages error:&error];
    
    NSArray *allRatingimages = [managedObject executeFetchRequest:fetchRatingImages error:&error];
    
    int e;
    
    for(e=0; e < [allRatingimages count]; e++){
    
        NSLog(@"Ratingimages %i", [allRatingimages count]);
        
        //create request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        //Set Params
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:60];
        [request setHTTPMethod:@"POST"];
        
        //Create boundary, it can be anything
        NSString *boundary = @"------VohpleBoundary4QuqLuM1cE1615lMwCy";
        
        // set Content-Type in HTTP header
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        // post body
        NSMutableData *body = [NSMutableData data];
        
        //Populate a dictionary with all the regular values you would like to send.
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
        
        NSString *param1 = @"test";
        
        [parameters setValue:param1 forKey:@"param1-name"];
        
        
        NSString *filePath = [NSString stringWithFormat:@"%@", [[allRatingimages objectAtIndex:e] valueForKey:@"imagePathFilesystem"]];
        
        NSLog(@"THE FILEPATH TO Ratingimage: %@", filePath);
        
        NSData *ratingImagesData = [NSData dataWithContentsOfFile:filePath];
        
       // NSLog(@"DATA: %@", ratingImagesData);
        
        //Assuming data is not nil we add this to the multipart form
        if (ratingImagesData)
        {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filePath] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:ratingImagesData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        
        //Close off the request with the boundary
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the request
        [request setHTTPBody:body];
        
        NSString *baseUrl = @"http://app.rubi.st.automatix.koerbler.com/app/upload/image-upload.php";
        
       // NSString *baseUrl = serverURL;
        
        // set URL
        [request setURL:[NSURL URLWithString:baseUrl]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   
                                   NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                   
                                   if ([httpResponse statusCode] == 200) {
                                       
                                       NSLog(@"success");
                                       
                                     
                                   }
                                   else{
                                       NSLog(@"error on response");
                                       
                                   }
                                   
                               }];
    
    }
    
    int i = 0;
    
    for(i=0; i < [allRatingsections count]; i++){
    
    //create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    NSString *param1 = @"test";
    
    [parameters setValue:param1 forKey:@"param1-name"];
    
    
    NSString *filePath = [NSString stringWithFormat:@"%@", [[allRatingsections objectAtIndex:i] valueForKey:@"sectionSafetyHazardImagePath"]];
    
    NSLog(@"THE FILEPATH to safetyhazardimages: %@", filePath);
    
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
       // NSLog(@"DATA: %@", imageData);
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", filePath] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
 
        
    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    NSString *baseUrl = @"http://app.rubi.st.automatix.koerbler.com/app/upload/image-upload.php";
    
    // set URL
    [request setURL:[NSURL URLWithString:baseUrl]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                               
                               if ([httpResponse statusCode] == 200) {
                                   
                                   NSLog(@"success hazard");
                               }
                               else{
                                   NSLog(@"error on response");
                               }
                               
                           }];
    }
}




@end
