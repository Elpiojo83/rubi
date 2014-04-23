//
//  RatinImagesViewController.m
//  rubi
//
//  Created by David Krachler on 22.04.14.
//  Copyright (c) 2014 koerbler. All rights reserved.
//

#import "RatingImagesViewController.h"
#import "RatingImage.h"
#import "Ratingsection.h"
//#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface RatingImagesViewController ()

@end

@implementation RatingImagesViewController

/*
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"RatingImage"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"imagePath" ascending:YES ]];
        request.predicate = [NSPredicate predicateWithFormat: @" ratingsection == %@" , self.ratingsection];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request managedObjectContext:managedObjectContext sectionNameKeyPath: nil cacheName: nil];
    }
    else {
        self.fetchedResultsController = nil;
    }
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ImageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    RatingImage *image = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    cell.textLabel.text = image.imagePath;
    
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    
}


- (IBAction)takePictureTouchUpInside:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;


    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


#pragma mark Image picker delegate methdos
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
   /*
    [self.Mylibrary saveImage:image toAlbum:@"Rubi" withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
    }];
    */
    /*
    [self.Mylibrary writeImageToSavedPhotosAlbum:@"Rubi" metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        
        //             report_memory(@"After writing to library");
        if (error2) {
            NSLog(@"ERROR: the image failed to be written");
        }
        else {
            NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
        }
        
        runOnMainQueueWithoutDeadlocking(^{
            //                 report_memory(@"Operation completed");
            [photoCaptureButton setEnabled:YES];
        });
        
    }];
    */
    
    [self.Mylibrary writeImageToSavedPhotosAlbum: image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error2)
     {
         //             report_memory(@"After writing to library");
         if (error2) {
             NSLog(@"ERROR: the image failed to be written");
         }
         else {
             NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             
             
             
             
         }
         
     }];
    
    
    [picker dismissModalViewControllerAnimated:NO];
}

/*
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:NO];
}
*/


#pragma mark images from album

/*
-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    _managedObjectContext = managedObjectContext;
    if (managedObjectContext) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"RatingImage"];
        request.sortDescriptors = @[[ NSSortDescriptor  sortDescriptorWithKey: @"imagePath" ascending:YES ]];
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest: request
                                                                            managedObjectContext: managedObjectContext
                                                                              sectionNameKeyPath: nil
                                                                                       cacheName: nil];
        NSError *error = nil;
        [self.fetchedResultsController performFetch: &error];
    }
    else {
        self.fetchedResultsController = nil;
    }
}
*/

-(void)viewDidAppear:(BOOL)animated{
    
    self.Mylibrary = [[ALAssetsLibrary alloc] init];
    
   // NSLog(@"IMAGES: %@", self.ratingsection.startPositionGPS);
   // NSString *myAlbum = [NSString stringWithFormat:@"%@", self.section.sectionname];
   // NSLog(@"CurrentAlbum: %@", myAlbum);
    
    self.ratingimage = [NSEntityDescription insertNewObjectForEntityForName:@"RatingImage" inManagedObjectContext: self.managedObjectContext];
    
    
    NSLog(@"Image %@", self.ratingsection.ratingimage);
    NSLog(@"RatingSection %@", self.ratingsection);
    NSLog(@"RatingImage %@", self.ratingimage);


    
    self.ratingimage.imagePath = @"somPath";
    [self.ratingsection addRatingimageObject: self.ratingimage];
    
  
    
}

@end
