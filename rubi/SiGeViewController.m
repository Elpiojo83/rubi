//
//  SiGeViewController.m
//  rubi
//
//  Created by David Krachler on 13.05.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "SiGeViewController.h"
#import "Ratingsection.h"
#import "RatingsectionViewController.h"



@interface SiGeViewController ()

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

@implementation SiGeViewController

/*
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"RatingsectionSafetyHazard"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"safetyHazardImagePath" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" ratingsection == %@" , self.ratingsection];
        
        
        NSLog(@"Curr. Images: %@", request);
        
        NSLog(@"imaes: %@", self.ratingsectionsafetyhazard.safetyHazardImagePath);
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
        
        
    }
    else {
        self.fetchedResultsController = nil;
    }
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   // HazardNote
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(!self.ratingsection.sectionSafetyHazardNote){
        self.HazardNote.text = [NSString stringWithFormat:@"Platz für Notizen..."];
    }else{
        self.HazardNote.text = [NSString stringWithFormat:@" %@", self.ratingsection.sectionSafetyHazardNote];
    }
    
    
    //self.Mylibrary = [[ALAssetsLibrary alloc] init];
    
    NSString *myGrabbedImage = [NSString stringWithFormat:@"%@.png" , self.ratingsection.startPositionGPS];//@"SiGe.png";
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,          NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    NSString *fullPath = [documentDirectory stringByAppendingPathComponent:myGrabbedImage];
    NSData *data = [NSData dataWithContentsOfFile:fullPath];
    
    [[self SigeImagView]setImage:[UIImage imageWithData:data]];
    
    
    NSLog(@"RatingsectionLOG: %@ SafetyHazardLOG:%@", self.ratingsectionsafetyhazard.safetyHazardNote, self.ratingsectionsafetyhazard.safetyHazardImagePath);
    
}


-(void)onKeyboardHide:(NSNotification *)notification
{
    //keyboard will hide
    
    if(!self.ratingsectionsafetyhazard){
        self.ratingsectionsafetyhazard = [NSEntityDescription insertNewObjectForEntityForName:@"RatingsectionSafetyHazard" inManagedObjectContext: self.managedObjectContext];
    }
    
    self.ratingsection.sectionSafetyHazardNote = self.HazardNote.text;
   // self.ratingsectionsafetyhazard.safetyHazardImagePath = self.ratingsectionsafetyhazard.safetyHazardImagePath;
    
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    [delegate saveContext];
    
    NSLog(@"Nnote %@", self.ratingsectionsafetyhazard.safetyHazardNote);
    
    NSLog(@"Save Notes");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePictureTouchUpInside:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark Image picker delegate methdos



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    
    NSData *data = UIImagePNGRepresentation(self.chosenImage);
    
    NSString *myGrabbedImage = [NSString stringWithFormat:@"%@.png" , self.ratingsection.startPositionGPS];// @"SiGe.png";
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    
    [self.SigeImagView setImage:self.chosenImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *fullPathToFile = [documentDirectory stringByAppendingPathComponent:myGrabbedImage];
    [data writeToFile:fullPathToFile atomically:YES];
    
    
    if(!self.ratingsectionsafetyhazard){
      //  self.ratingsectionsafetyhazard = [NSEntityDescription insertNewObjectForEntityForName:@"RatingsectionSafetyHazard" inManagedObjectContext: self.managedObjectContext];
        
       // [self.ratingsection addHazardsObject:self.ratingsectionsafetyhazard];
        
    }
    
    
    self.ratingsection.sectionSafetyHazardImagePath = [NSString stringWithFormat:@"%@", fullPathToFile];
    //self.ratingsectionsafetyhazard.safetyHazardNote = [NSString stringWithFormat:@"%@", self.HazardNote.text];
    
    
    
    NSLog(@"Path: %@", self.ratingsectionsafetyhazard);
    
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
